import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;
import 'dart:typed_data';

import '../styles/custom_styles.dart';

import 'package:counter_app/services/grpc_service.dart';
import 'package:counter_app/components/header.dart';
import 'loading_screen.dart';
import 'quick_answer_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _canProcessFrame = true;
  final List<List<int>> _frameBuffer = [];
  final Logger logger = Logger();

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
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _cameraController!.initialize();
      setState(() {});

      _cameraController!.startImageStream(_processCameraImage);
    }
  }

  Future<List<int>?> _convertYUV420ToJPEG(CameraImage image) async {
    try {
      final width = image.width;
      final height = image.height;

      final yPlane = image.planes[0];
      final uPlane = image.planes[1];
      final vPlane = image.planes[2];

      final uvRowStride = uPlane.bytesPerRow;
      final uvPixelStride = uPlane.bytesPerPixel ?? 1;

      final yBytes = yPlane.bytes;
      final uBytes = uPlane.bytes;
      final vBytes = vPlane.bytes;

      final int frameSize = width * height;
      final List<int> rgbBytes = List<int>.filled(frameSize * 3, 0);

      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          final int uvX = x ~/ 2;
          final int uvY = y ~/ 2;
          final int uvIndex = uvY * uvRowStride + uvX * uvPixelStride;
          final int index = y * width + x;
          final int pixelIndex = index * 3;

          if (index >= yBytes.length ||
              uvIndex >= uBytes.length ||
              uvIndex >= vBytes.length) {
            continue;
          }

          int Y = yBytes[index];
          int U = uBytes[uvIndex];
          int V = vBytes[uvIndex];

          int r = (Y + 1.402 * (V - 128)).round();
          int g = (Y - 0.344136 * (U - 128) - 0.714136 * (V - 128)).round();
          int b = (Y + 1.772 * (U - 128)).round();

          r = r.clamp(0, 255);
          g = g.clamp(0, 255);
          b = b.clamp(0, 255);

          if (pixelIndex + 2 < rgbBytes.length) {
            rgbBytes[pixelIndex] = r;
            rgbBytes[pixelIndex + 1] = g;
            rgbBytes[pixelIndex + 2] = b;
          }
        }
      }

      final rgbImage = imglib.Image.fromBytes(
        width: width,
        height: height,
        bytes: Uint8List.fromList(rgbBytes).buffer,
        order: imglib.ChannelOrder.rgb,
        format: imglib.Format.uint8,
      );

      return imglib.encodeJpg(rgbImage);
    } catch (e) {
      logger.e("YUV420 to JPEG 변환 실패: $e");
      return null;
    }
  }

  void _processCameraImage(CameraImage image) async {
    // 프레임 너무 자주 처리하지 않게 throttle 걸기
    if (!_canProcessFrame) return;
    _canProcessFrame = false;

    final bytes = await _convertYUV420ToJPEG(image);
    if (bytes != null) {
      _frameBuffer.add(bytes);
    }

    if (_frameBuffer.length > 100) {
      _frameBuffer.removeAt(0); // 오래된 프레임 제거해서 너무 쌓이지 않게
    }

    Future.delayed(Duration(milliseconds: 50), () {
      // 약 20fps
      _canProcessFrame = true;
    });
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
            onSend: () async {
              bool hasError = false;

              final grpcService = GrpcService();
              try {
                await grpcService.sendFrames(
                  _frameBuffer,
                  inquiryType: '주문 문의사항',
                  num: 1,
                );
              } catch (e) {
                logger.e("gRPC 전송 중 오류: $e");
                hasError = true;
              }

              if (!mounted) return;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LoadingScreen(error: hasError),
                ),
              );
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
                    height: screenWidth * 0.67 * (500 / 290),
                    color: CustomStyles.primaryGray,
                    child:
                        _cameraController != null &&
                                _cameraController!.value.isInitialized
                            ? CameraPreview(_cameraController!)
                            : const Center(child: CircularProgressIndicator()),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuickAnswerScreen(),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/restroom.svg',
                        width: 64,
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => QuickAnswerScreen(isWifi: true),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/wifi.svg',
                        width: 64,
                      ),
                    ),
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
