import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:permission_handler/permission_handler.dart';

class CallPage extends StatefulWidget {
  final String roomId;
  final String title;
  final bool isMobile;

  const CallPage({
    super.key,
    required this.roomId,
    required this.title,
    required this.isMobile
  });

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  final _messageController = TextEditingController();
  RTCDataChannel? _dataChannel;

  @override
  void initState() {
    super.initState();
    initRenderers();
    _initCall();
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  _initCall() async {
    await _requestPermissions();
    await _createPeerConnection();
  }

  _createPeerConnection() async {
    // Replace these with your STUN/TURN server URLs if you have your own
    Map<String, dynamic> configuration = {
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ]
    };

    _peerConnection =
    await createPeerConnection(configuration, {'optional': []});

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
  }

  _onIceCandidate(RTCIceCandidate candidate) {
    // Send ICE candidate to the other user through your signaling server
  }

  _onAddStream(MediaStream stream) {
    // Set the remote renderer's source to the received stream
    _remoteRenderer.srcObject = stream;
  }

  _createDataChannel() async {
    RTCDataChannelInit dataChannelDict = RTCDataChannelInit();
    _dataChannel = await _peerConnection!.createDataChannel('textMessages', dataChannelDict);
    _dataChannel!.onMessage = (RTCDataChannelMessage message) {
      // Handle received messages
      if (kDebugMode) {
        print('Received message: ${message.text}');
      }
    };
  }

  _sendMessage() async {
    if (_dataChannel != null && _messageController.text.isNotEmpty) {
      String messageText = _messageController.text;
      if (kDebugMode) {
        print(messageText);
      }
      if (messageText.startsWith('/ai ')) {
        String prompt = messageText.substring(4); // Remove the '/ai ' command
        String chatGPTResponse = await _getChatGPTResponse(prompt);
        messageText = 'AI Assistant: $chatGPTResponse';
        if (kDebugMode) {
          print(messageText);
        }
      }
      _dataChannel!.send(RTCDataChannelMessage(_messageController.text));
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
        appBar: AppBar(title: Text('Call ${widget.roomId}')),
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
          ],
        )
    );
  }
}