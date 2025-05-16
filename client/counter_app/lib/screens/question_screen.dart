import 'dart:async';
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
  final bool isOrder;
  final int number;

  const QuestionScreen({super.key, this.isOrder = false, this.number = 0});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  final List<List<int>> _frameBuffer = [];
  final Logger logger = Logger();
  late GrpcService _grpcService;
  Timer? _batchSendTimer;

  int _frameCount = 0;
  late Timer _fpsTimer;

  @override
  void initState() {
    super.initState();
    _grpcService = GrpcService();
    _grpcService.connect();
    _initializeCamera();
    _startBatchSendingTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  void _startBatchSendingTimer() {
    _batchSendTimer = Timer.periodic(Duration(seconds: 1), (_) async {
      if (_frameBuffer.isEmpty) return;

      final framesToSend = List<List<int>>.from(_frameBuffer);
      _frameBuffer.clear();

      try {
        final success = await _grpcService.sendFrames(
          framesToSend,
          inquiryType: widget.isOrder ? '주문 문의사항' : '일반 문의사항',
          num: widget.number,
        );
        if (!success) {
          logger.e('배치 프레임 전송 실패');
        }
      } catch (e) {
        logger.e('배치 전송 중 오류: $e');
      }
    });
  }

  // 테스트용
  void _startFpsTimer() {
    _fpsTimer = Timer.periodic(Duration(seconds: 1), (_) {
      logger.i('1초 동안 처리된 프레임 수: $_frameCount');
      _frameCount = 0;
    });
  }

  // 테스트용
  void _stopFpsTimer() {
    _fpsTimer.cancel();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    final frontCamera = cameras?.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras!.first,
    );

    if (frontCamera != null) {
      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.low,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _cameraController!.initialize();
      setState(() {});

      _startFpsTimer();

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

      final List<int> rgbBytes = List<int>.filled(width * height * 3, 0);

      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          final uvX = x ~/ 2;
          final uvY = y ~/ 2;
          final uvIndex = uvY * uvRowStride + uvX * uvPixelStride;
          final index = y * width + x;
          final pixelIndex = index * 3;

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

      final rotatedImage = imglib.copyRotate(rgbImage, angle: 270);
      return imglib.encodeJpg(rotatedImage, quality: 50);
    } catch (e) {
      logger.e('YUV420 to JPEG 변환 실패: $e');
      return null;
    }
  }

  void _processCameraImage(CameraImage image) {
    _frameCount++; // 테스트용코드

    _convertYUV420ToJPEG(image).then((jpegBytes) {
      if (jpegBytes != null) {
        _frameBuffer.add(jpegBytes);
        if (_frameBuffer.length > 90) {
          _frameBuffer.removeRange(0, _frameBuffer.length - 90);
        }
      }
    });
  }

  @override
  void dispose() {
    _stopFpsTimer(); // 테스트용
    _batchSendTimer?.cancel();
    _cameraController?.dispose();
    _grpcService.shutdown();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _cameraController?.stopImageStream();
      logger.i('앱 비활성화로 카메라 중지');
    } else if (state == AppLifecycleState.resumed) {
      if (_cameraController != null &&
          _cameraController!.value.isInitialized &&
          !_cameraController!.value.isStreamingImages) {
        _cameraController!.startImageStream(_processCameraImage);
        logger.i('앱 재활성화로 카메라 재시작');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              centerIcon: Text(
                '💬',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              showSendButton: true,
              onSend: () async {
                await _cameraController?.stopImageStream();
                _batchSendTimer?.cancel();

                bool success = true;
                if (_frameBuffer.isNotEmpty) {
                  success = await _grpcService.sendFrames(
                    List<List<int>>.from(_frameBuffer),
                    inquiryType: widget.isOrder ? '주문 문의사항' : '일반 문의사항',
                    num: widget.number,
                  );

                  if (!success) {
                    logger.e('최종 프레임 전송 실패');
                  }

                  _frameBuffer.clear();
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoadingScreen(error: !success),
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
                      height:
                          widget.isOrder
                              ? screenWidth * 0.85 * (500 / 290)
                              : screenWidth * 0.67 * (500 / 290),
                      color: CustomStyles.primaryGray,
                      child:
                          _cameraController != null &&
                                  _cameraController!.value.isInitialized
                              ? CameraPreview(_cameraController!)
                              : const Center(
                                child: CircularProgressIndicator(),
                              ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (!widget.isOrder)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuickAnswerScreen(),
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
                                builder: (_) => QuickAnswerScreen(isWifi: true),
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
      ),
    );
  }
}
