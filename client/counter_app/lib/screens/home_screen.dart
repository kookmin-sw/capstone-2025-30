import 'package:flutter/material.dart';
import '../styles/custom_styles.dart';

import 'package:counter_app/services/web_socket_service.dart';
import 'package:counter_app/services/grpc_service.dart';
import 'package:counter_app/components/header.dart';
import 'package:counter_app/components/sign_video.dart';
import 'answer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    // 웹소켓에서 추가 문의 메시지 오면 자동으로 화면 이동하도록
    WebSocketService().onInquiryRequestReceived = () {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AnswerScreen(isOrder: true),
        ),
      );
    };
  }

  Future<void> _handleTap() async {
    final grpc = GrpcService();

    try {
      await grpc.connect();

      if (!mounted) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() => _isPressed = false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnswerScreen()),
        );
      });
    } catch (e) {
      if (!mounted) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('gRPC 연결 실패')));
      });
    } finally {
      await grpc.shutdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const videos = [
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%A1%E1%84%89%E1%85%A6%E1%84%8B%E1%85%AD%2C%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%B5%20%E1%84%80%E1%85%A1%E1%84%89%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%84%8B%E1%85%A9.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A7%81%EC%9B%90.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%AC%B8%EC%9D%98.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9E%88%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%A1%E1%86%AF%E1%84%91%E1%85%AE%E1%86%BC%E1%84%89%E1%85%A5%E1%86%AB+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",

      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A8%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB+%E1%84%8F%E1%85%B3%E1%86%AF%E1%84%85%E1%85%B5%E1%86%A8.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%B9%B4%EB%A9%94%EB%9D%BC.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%BC%9C%EB%8B%A4%2C%20%EC%BC%9C%EC%A7%80%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%AC%B8%EC%9D%98.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%88%98%EC%96%B4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B3%B4%EC%97%AC%EC%A3%BC%EB%8B%A4.mp4",

      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%88%98%EC%96%B4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%AC%B8%EC%9D%98.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A7%81%EC%9B%90.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%ED%95%9C%EA%B8%80.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B3%80%ED%95%98%EB%8B%A4%2C%20%EB%B3%80%ED%99%98.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A0%84%EB%8B%AC.mp4",

      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%88%98%EC%96%B4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%AC%B8%EC%9D%98.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A0%84%EB%B6%80.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B3%B4%EC%97%AC%EC%A3%BC%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%AC%B8%EC%9D%98.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A0%84%EB%8B%AC.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9C%84.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%98%A4%EB%A5%B8%EC%AA%BD.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B2%84%ED%8A%BC.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4",
    ];

    return Scaffold(
      body: Column(
        children: [
          Header(
            centerIcon: Text(
              "🏠",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            hideBackButton: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SignVideo(srcList: videos, isOnce: false),
                const SizedBox(height: 30),
                GestureDetector(
                  onTapDown: (_) => setState(() => _isPressed = true),
                  onTapUp: (_) {
                    setState(() => _isPressed = false);
                    _handleTap();
                  },
                  onTapCancel: () => setState(() => _isPressed = false),
                  child: Container(
                    height: screenWidth * (164 / 300),
                    decoration: BoxDecoration(
                      color:
                          _isPressed
                              ? CustomStyles.primaryBlue
                              : CustomStyles.primaryGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('💬', style: TextStyle(fontSize: 60)),
                        const SizedBox(height: 16),
                        Text(
                          '문의하기',
                          style: CustomStyles.fontHead20.copyWith(
                            color:
                                _isPressed
                                    ? CustomStyles.primaryWhite
                                    : CustomStyles.primaryBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
