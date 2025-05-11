import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

import '../styles/custom_styles.dart';

import '../services/web_socket_service.dart';
import 'package:counter_app/services/grpc_service.dart';
import 'package:counter_app/components/header.dart';
import 'package:counter_app/components/sign_video.dart';
import 'question_screen.dart';

class AnswerScreen extends StatefulWidget {
  final bool isOrder;

  const AnswerScreen({super.key, this.isOrder = false});

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  final Logger logger = Logger();
  bool _isPressedYes = false;
  bool _isPressedNo = false;
  List<String> videos = [];

  @override
  void initState() {
    super.initState();
    videos = WebSocketService().getSignUrls();
    logger.i("websocket 수어 영상: $videos");
  }

  Future<void> _handleYesTap() async {
    final grpc = GrpcService();

    try {
      await grpc.connect();

      if (!mounted) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const QuestionScreen()),
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

    const inquirieVideos = [
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%8D%94%2C%EA%B2%8C%EB%8B%A4%EA%B0%80%2C%EB%8D%94%EA%B5%AC%EB%82%98%2C%EC%B6%94%EA%B0%80%2C%EB%8D%94%EC%9A%B1.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%AC%B8%EC%9D%98.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9E%88%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%AC%BC%EC%9D%8C%ED%91%9C.mp4",

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
              "💬",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SignVideo(
                  srcList: widget.isOrder ? inquirieVideos : videos,
                  aspectRatio: widget.isOrder ? (3 / 4) : (9 / 16),
                  onCompleted: () {
                    if (!mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuestionScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                if (widget.isOrder)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTapDown: (_) => setState(() => _isPressedYes = true),
                        onTapUp: (_) {
                          setState(() => _isPressedYes = false);
                          _handleYesTap();
                        },
                        onTapCancel:
                            () => setState(() => _isPressedYes = false),
                        child: Container(
                          width: screenWidth * 0.37,
                          height: 87,
                          decoration: BoxDecoration(
                            color:
                                _isPressedYes
                                    ? CustomStyles.primaryBlue
                                    : CustomStyles.primaryGray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/yes.svg',
                                colorFilter: ColorFilter.mode(
                                  _isPressedYes
                                      ? CustomStyles.primaryWhite
                                      : CustomStyles.pointGray,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Text(
                                '예',
                                style: CustomStyles.fontHead16.copyWith(
                                  color:
                                      _isPressedYes
                                          ? CustomStyles.primaryWhite
                                          : CustomStyles.pointGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTapDown: (_) => setState(() => _isPressedNo = true),
                        onTapUp: (_) {
                          setState(() => _isPressedNo = false);
                        },
                        onTapCancel: () => setState(() => _isPressedNo = false),
                        child: Container(
                          width: screenWidth * 0.37,
                          height: 87,
                          decoration: BoxDecoration(
                            color:
                                _isPressedNo
                                    ? CustomStyles.primaryBlue
                                    : CustomStyles.primaryGray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/no.svg',
                                colorFilter: ColorFilter.mode(
                                  _isPressedNo
                                      ? CustomStyles.primaryWhite
                                      : CustomStyles.pointGray,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Text(
                                '아니요',
                                style: CustomStyles.fontHead16.copyWith(
                                  color:
                                      _isPressedNo
                                          ? CustomStyles.primaryWhite
                                          : CustomStyles.pointGray,
                                ),
                              ),
                            ],
                          ),
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
