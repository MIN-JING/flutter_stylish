import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class ARPage extends StatefulWidget {
  final String title;
  final bool isMobile;

  const ARPage({
    super.key,
    required this.title,
    required this.isMobile
  });

  @override
  _ARPageState createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _onARCoreViewCreated(ARCoreController controller) {
    // Perform any action on the ARCore view here
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    await _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('AR Page')),
        body: Column()
    );
  }
}