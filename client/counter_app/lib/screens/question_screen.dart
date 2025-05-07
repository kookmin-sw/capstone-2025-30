import 'package:flutter/material.dart';
import 'package:counter_app/components/header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:camera/camera.dart';

import '../styles/custom_styles.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras![0],
        ResolutionPreset.medium,
      );
      await _cameraController!.initialize();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Header(
            centerIcon: Text(
              "💬",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: screenWidth * 0.7,
            height: screenWidth * 0.7 * (376 / 232),
            color: CustomStyles.primaryGray,
            child:
                _cameraController != null &&
                        _cameraController!.value.isInitialized
                    ? CameraPreview(_cameraController!)
                    : const Center(child: CircularProgressIndicator()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/restroom.svg'),
              const SizedBox(width: 52),
              SvgPicture.asset('assets/icons/wifi.svg'),
            ],
          ),
        ],
      ),
    );
  }
}
