import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_database/firebase_database.dart';

class CallPage extends StatefulWidget {
  final String title;
  final bool isMobile;

  const CallPage({
    super.key,
    required this.title,
    required this.isMobile
  });

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  RTCDataChannel? _dataChannel;
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  final _roomIdController = TextEditingController();
  final _messageController = TextEditingController();
  final _receivedMessageController = TextEditingController();
  // global variable to store the peer connection instance
  static RTCPeerConnection? _globalPeerConnection;


  @override
  void initState() {
    super.initState();
    initRenderers();
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  _initCall() async {
    debugPrint('initializing call...');
    await _requestPermissions();
    await _createPeerConnection();
  }

  _createPeerConnection() async {
    debugPrint('creating peer connection...');
    // Replace these with your STUN/TURN server URLs if you have your own
    Map<String, dynamic> configuration = {
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ]
    };

    _peerConnection = await createPeerConnection(configuration, {'optional': []});
    _globalPeerConnection = _peerConnection;

    // Add event listeners
    _peerConnection!.onIceCandidate = _onIceCandidate;
    _peerConnection!.onAddStream = _onAddStream;

    // Request camera and microphone access and create a local stream
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {
        'width': 640,
        'height': 480,
      },
    });

    // Add the local stream to the peer connection and display it
    _localStream!.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });

    _localRenderer.srcObject = _localStream;

    // Create the data channel for text messages
    _createDataChannel();

    // _savePeerConnection();
  }

  _saveCallData() async {
    // Get the room ID from the TextField controller
    final roomId = _roomIdController.text;

    // Save call data to the Realtime Database
    final DatabaseReference callRef = FirebaseDatabase.instance.reference()
        .child('calls').child(roomId);
    await callRef.set({
      'startedAt': DateTime.now().toUtc().toString(),
    });

    // Listen for changes to the call data
    callRef.onValue.listen((event) {
      if (event.snapshot.value != null && event.snapshot.value['startedAt'] != null) {
        // Join the call
        _initCall();

        // String remotePeerConnectionString = event.snapshot.value['peerConnection'];
        // if (remotePeerConnectionString == _globalPeerConnection.toString()) {
        //   // The two devices are connected with the same peer connection
        //   debugPrint('Connected with the same peer connection!');
        // } else {
        //   // The two devices are not connected with the same peer connection
        //   debugPrint('Connected with different peer connections!');
        // }
      } else {
        // Display an error message or return to the previous page
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Room ID not found. Please enter a valid Room ID.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });

    // Save the room ID to the messages node in Firebase Realtime Database
    final DatabaseReference messagesRef = FirebaseDatabase.instance.reference()
        .child('messages').child(roomId);
    messagesRef.push().set({
      'text': 'RoomId -$roomId- joined the chat',
      'timestamp': DateTime.now().toUtc().toString(),
    });
  }

  _onIceCandidate(RTCIceCandidate candidate) {
    final roomId = _roomIdController.text;

    // Send ICE candidate to the other user through Firebase Realtime Database
    DatabaseReference iceCandidateRef = FirebaseDatabase.instance.reference()
        .child('iceCandidates').push();
    iceCandidateRef.set({
      'roomId': roomId,
      'candidate': candidate.toMap() // convert the RTCIceCandidate to a map for serialization
    });
  }

  _onAddStream(MediaStream stream) {
    // Set the remote renderer's source to the received stream
    _remoteRenderer.srcObject = stream;
  }

  _createDataChannel() async {
    debugPrint("_createDataChannel");
    RTCDataChannelInit dataChannelDict = RTCDataChannelInit();
    _dataChannel = await _peerConnection!.createDataChannel('textMessages', dataChannelDict);

    _dataChannel!.onDataChannelState = (RTCDataChannelState state) {
      if (state == RTCDataChannelState.RTCDataChannelOpen) {
        debugPrint('Data channel is open!');
      } else {
        debugPrint('Data channel is closed!');
      }
    };

    _dataChannel!.onMessage = (RTCDataChannelMessage message) {
      debugPrint("_dataChannel!.onMessage");
      // Handle received messages
      debugPrint('_Received message: ${message.text}');

      setState(() {
        _receivedMessageController.text = message.text;
      });
    };
  }

  _sendMessage() async {
    if (_dataChannel != null && _messageController.text.isNotEmpty) {
      String messageText = _messageController.text;
      debugPrint('messageText: $messageText');

      if (messageText.startsWith('/ai ')) {
        String prompt = messageText.substring(4); // Remove the '/ai ' command
        String chatGPTResponse = await _getChatGPTResponse(prompt);
        messageText = 'AI Assistant: $chatGPTResponse';
        debugPrint('messageText AI Assistant: $messageText');
        setState(() {
          _receivedMessageController.text = messageText;
        });
      }

      _dataChannel!.send(RTCDataChannelMessage(messageText));
      _messageController.clear();
    }
  }

  _savePeerConnection() async {
    final roomId = _roomIdController.text;

    // Save the peer connection object to Firebase Realtime Database
    final DatabaseReference callRef = FirebaseDatabase.instance.reference()
        .child('calls').child(roomId);
    await callRef.set({
      'startedAt': DateTime.now().toUtc().toString(),
      'peerConnection': _globalPeerConnection.toString() // Convert the peer connection object to a string for serialization
    });
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  Future<String> _getChatGPTResponse(String prompt) async {
    try {
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('chatGPT');
      final response = await callable.call({'prompt': prompt});
      return response.data;
    } catch (error) {
      if (kDebugMode) {
        print('Error calling ChatGPT Cloud Function: $error');
      }
      return 'Error: Unable to get a response from the ChatGPT API';
    }
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Call Room: ${_roomIdController.text}')),
        body: Column(
          children: [
            Expanded(
                child: OrientationBuilder(builder: (context, orientation) {
                  return Center(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.black54),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: RTCVideoView(_remoteRenderer),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 20,
                            child: Container(
                              width: orientation == Orientation.portrait ? 90 : 120,
                              height: orientation == Orientation.portrait ? 120 : 90,
                              decoration: const BoxDecoration(color: Colors.black54),
                              child: RTCVideoView(_localRenderer),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Received message:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _receivedMessageController.text,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(hintText: 'Type a message...'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _roomIdController,
                      decoration: const InputDecoration(hintText: 'Room ID'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.connect_without_contact),
                    onPressed: _saveCallData,
                  ),
                ],
              ),
            ),
    ]));
  }
}