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
  final Logger logger = Logger();
  late GrpcService _grpcService;

  int _frameCount = 0;
  bool _grpcError = false;
  late Timer _fpsTimer;
  bool _showCountdown = true;
  int _countdown = 3;
  int _receivedFrameCount = 0;
  bool _grpcStarted = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera().then((_) {
      _startCountdownAndGrpc();
    });
    WidgetsBinding.instance.addObserver(this);
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

  Future<void> _startCountdownAndGrpc() async {
    for (int i = 3; i > 0; i--) {
      if (!mounted) return;
      setState(() {
        _countdown = i;
      });
      await Future.delayed(Duration(seconds: 1));
    }

    if (!mounted) return;
    setState(() {
      _showCountdown = false;
    });

    _grpcService = GrpcService();
    await _grpcService.connect();

    _startFpsTimer();
    _cameraController!.startImageStream(_processCameraImage);
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
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await _cameraController!.initialize();
      setState(() {});
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
      return imglib.encodeJpg(rotatedImage, quality: 15);
    } catch (e) {
      logger.e('YUV420 to JPEG 변환 실패: $e');
      return null;
    }
  }

  void _processCameraImage(CameraImage image) {
    _frameCount++; // 테스트용코드

    _convertYUV420ToJPEG(image).then((jpegBytes) async {
      if (jpegBytes == null || jpegBytes.isEmpty) {
        logger.w("⚠️ JPEG 변환 결과가 null 또는 empty");
        return;
      }

      _receivedFrameCount++;

      if (!_grpcStarted && _receivedFrameCount >= 1) {
        _grpcStarted = true;
        await _grpcService.startGrpcStream();
      }

      try {
        _grpcService.sendSingleFrame(
          jpegBytes,
          inquiryType: widget.isOrder ? 'order' : 'inquiry',
          num: widget.number,
        );
      } catch (e) {
        logger.e('프레임 전송 중 오류: $e');
        _grpcError = true;
      }
    });
  }

  @override
  void dispose() {
    _stopFpsTimer(); // 테스트용
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
      body: SafeArea(
        child: SingleChildScrollView(
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

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => LoadingScreen(
                            error: _grpcError,
                            isOrder: widget.isOrder,
                            grpcService: _grpcService,
                          ),
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
                                ? AspectRatio(
                                  aspectRatio:
                                      _cameraController!.value.aspectRatio,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      CameraPreview(_cameraController!),
                                      if (_showCountdown)
                                        Container(
                                          color: Colors.black,
                                          child: Center(
                                            child: Text(
                                              '$_countdown',
                                              style: const TextStyle(
                                                fontSize: 80,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                )
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
                                  builder:
                                      (_) => QuickAnswerScreen(isWifi: true),
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
      ),
    );
  }
}
