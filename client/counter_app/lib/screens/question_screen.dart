import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:camera/camera.dart';

import '../styles/custom_styles.dart';

import 'package:counter_app/components/header.dart';
import 'loading_screen.dart';

class QuestionScreen extends StatefulWidget {
  final bool isOrder;

  const QuestionScreen({super.key, this.isOrder = false});

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
            showSendButton: true,
            onSend: () {
              print("전송 눌림");
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height:
                        widget.isOrder
                            ? screenWidth * 0.7 * (376 / 232)
                            : screenWidth * 0.8 * (500 / 290),
                    color: CustomStyles.primaryGray,
                    child:
                        _cameraController != null &&
                                _cameraController!.value.isInitialized
                            ? CameraPreview(_cameraController!)
                            : const Center(child: CircularProgressIndicator()),
                  ),
                ),
                const SizedBox(height: 30),
                if (widget.isOrder)
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
          ),
        ],
      ),
    );
  }
}
