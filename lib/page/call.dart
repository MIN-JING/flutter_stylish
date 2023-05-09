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

  @override
  void initState() {
    super.initState();
    initRenderers();
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
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

  _initCall() async {
    debugPrint('initializing call...');
    await _requestPermissions();
    await _createPeerConnection();

    if (_peerConnection != null) {
      _listenForIceCandidates();
    }
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
    debugPrint('Peer connection created: $_peerConnection');
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
    debugPrint('Local stream created: $_localStream');
    // Add the local stream to the peer connection and display it
    _localStream!.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });

    _localRenderer.srcObject = _localStream;

    // Create the data channel for text messages
    _createDataChannel();
  }

  _onIceCandidate(RTCIceCandidate candidate) {
    debugPrint('onIceCandidate');
    debugPrint('Got ICE candidate: $candidate');

    final roomId = _roomIdController.text;

    // Create an ICE candidate object with the candidate information
    final iceCandidate = {
      'candidate': candidate.candidate,
      'sdpMLineIndex': candidate.sdpMLineIndex,
      'sdpMid': candidate.sdpMid,
    };

    // Save the ICE candidate to Firebase Realtime Database
    final DatabaseReference iceCandidateRef = FirebaseDatabase.instance.reference()
        .child('calls').child(roomId).child('iceCandidates');
    iceCandidateRef.push().set(iceCandidate).then((_) {
      debugPrint('Ice candidate saved successfully!');
    }).catchError((error) {
      debugPrint('Error saving ice candidate: $error');
    });

    // Debug prints to verify that _onIceCandidate is being called
    debugPrint('ICE candidate gathered: $candidate');
    debugPrint('ICE candidate saved to database: $iceCandidate');
  }

  void _listenForIceCandidates() {
    debugPrint('_listenForIceCandidates');

    final roomId = _roomIdController.text;
    DatabaseReference iceCandidatesRef = FirebaseDatabase.instance.reference()
        .child('calls').child(roomId).child('iceCandidates');

    iceCandidatesRef.onChildAdded.listen((event) {
      // Get the ICE candidate data from the event
      var iceCandidateData = event.snapshot.value;

      debugPrint('listen iceCandidateData: $iceCandidateData');
      // Create an RTCIceCandidate object from the ICE candidate data
      var iceCandidate = RTCIceCandidate(
        iceCandidateData['candidate'],
        iceCandidateData['sdpMid'],
        iceCandidateData['sdpMLineIndex'],
      );

      // Add the ICE candidate to the peer connection object
      _peerConnection!.addCandidate(iceCandidate);
    });
  }

  _onAddStream(MediaStream stream) {
    debugPrint('Remote stream added: $stream');
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