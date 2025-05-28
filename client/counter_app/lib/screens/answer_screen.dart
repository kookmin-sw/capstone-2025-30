import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

import '../styles/custom_styles.dart';

import '../services/web_socket_service.dart';
import 'package:counter_app/services/grpc_service.dart';
import 'package:counter_app/components/header.dart';
import 'package:counter_app/components/sign_video.dart';
import 'question_screen.dart';
import 'home_screen.dart';

class AnswerScreen extends StatefulWidget {
  final bool isOrder;
  final int number;

  const AnswerScreen({super.key, this.isOrder = false, this.number = 0});

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  final Logger logger = Logger();
  bool _isPressedYes = false;
  bool _isPressedNo = false;
  List<String> videos = [];

  final List<String> postVideos = [
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8F%E1%85%A1%E1%84%86%E1%85%A6%E1%84%85%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8F%E1%85%A7%E1%84%83%E1%85%A1%2C%20%E1%84%8F%E1%85%A7%E1%84%8C%E1%85%B5%E1%84%83%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%AF%E1%86%AB%E1%84%92%E1%85%A1%E1%84%83%E1%85%A1%2C%20%E1%84%87%E1%85%A1%E1%84%85%E1%85%A1%E1%84%83%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%AE%E1%86%AB%E1%84%8B%E1%85%B4.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%AE%E1%84%8B%E1%85%A5.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A9%E1%84%8B%E1%85%A7%E1%84%8C%E1%85%AE%E1%84%83%E1%85%A1.mp4",

    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%AE%E1%86%AB%E1%84%8B%E1%85%B4.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%86%BC%E1%84%8C%E1%85%B5%2C%20%E1%84%81%E1%85%B3%E1%84%83%E1%85%A1%2C%20%E1%84%86%E1%85%A5%E1%86%B7%E1%84%8E%E1%85%AE%E1%84%83%E1%85%A1%2C%20%E1%84%80%E1%85%B3%E1%84%86%E1%85%A1%E1%86%AB%2C%20%E1%84%86%E1%85%A1%E1%84%85%E1%85%B3%E1%84%83%E1%85%A1%2C%20%E1%84%8C%E1%85%A5%E1%86%BC%E1%84%8C%E1%85%B5.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%AF%E1%86%AB%E1%84%92%E1%85%A1%E1%84%83%E1%85%A1%2C%20%E1%84%87%E1%85%A1%E1%84%85%E1%85%A1%E1%84%83%E1%85%A1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%AC%E1%86%AB%E1%84%8D%E1%85%A9%E1%86%A8.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%B1.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB.mp4",
    "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%82%E1%85%AE%E1%84%85%E1%85%B3%E1%84%83%E1%85%A1.mp4",
  ];

  @override
  void initState() {
    super.initState();
    final incomingVideos = WebSocketService().getSignUrls();
    videos = [...incomingVideos, ...postVideos];
    logger.i('websocket 수어 영상: $videos');
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
          MaterialPageRoute(
            builder: (_) => QuestionScreen(isOrder: widget.isOrder),
          ),
        );
      });
    } catch (e) {
      logger.e('grpc 호출 실패: $e');
    } finally {
      await grpc.shutdown();
    }
  }

  Future<void> _handleNoTap() async {
    final grpc = GrpcService();

    try {
      await grpc.connect();

      await grpc.sendFastInquiryRespIsNo(
        title: widget.isOrder ? 'order' : 'inquiry',
        num: widget.number,
      );

      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      logger.e('grpc 호출 실패: $e');
    } finally {
      await grpc.shutdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const inquirieVideos = [
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%83%E1%85%A5%2C%20%E1%84%80%E1%85%A6%E1%84%83%E1%85%A1%E1%84%80%E1%85%A1%2C%20%E1%84%83%E1%85%A5%E1%84%80%E1%85%AE%E1%84%82%E1%85%A1%2C%20%E1%84%8E%E1%85%AE%E1%84%80%E1%85%A1%2C%20%E1%84%83%E1%85%A5%E1%84%8B%E1%85%AE%E1%86%A8.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%AE%E1%86%AB%E1%84%8B%E1%85%B4.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%B5%E1%86%BB%E1%84%83%E1%85%A1.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%AE%E1%86%AF%E1%84%8B%E1%85%B3%E1%86%B7%E1%84%91%E1%85%AD.mp4",

      "https://signordermenu.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A8+%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%82%E1%85%AE%E1%84%85%E1%85%B3%E1%84%83%E1%85%A1.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8F%E1%85%A1%E1%84%86%E1%85%A6%E1%84%85%E1%85%A1.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8F%E1%85%A7%E1%84%83%E1%85%A1%2C%20%E1%84%8F%E1%85%A7%E1%84%8C%E1%85%B5%E1%84%83%E1%85%A1.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%AF%E1%86%AB%E1%84%92%E1%85%A1%E1%84%83%E1%85%A1%2C%20%E1%84%87%E1%85%A1%E1%84%85%E1%85%A1%E1%84%83%E1%85%A1.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%AE%E1%86%AB%E1%84%8B%E1%85%B4.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%AE%E1%84%8B%E1%85%A5.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A9%E1%84%8B%E1%85%A7%E1%84%8C%E1%85%AE%E1%84%83%E1%85%A1.mp4",

      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%AE%E1%84%8B%E1%85%A5.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%AE%E1%86%AB%E1%84%8B%E1%85%B4.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%B5%E1%86%A8%E1%84%8B%E1%85%AF%E1%86%AB.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%92%E1%85%A1%E1%86%AB%E1%84%80%E1%85%B3%E1%86%AF.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A7%E1%86%AB%E1%84%92%E1%85%A1%E1%84%83%E1%85%A1%2C%20%E1%84%87%E1%85%A7%E1%86%AB%E1%84%92%E1%85%AA%E1%86%AB.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%83%E1%85%A1%E1%86%AF.mp4",

      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%AE%E1%84%8B%E1%85%A5.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%AE%E1%86%AB%E1%84%8B%E1%85%B4.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%87%E1%85%AE.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A9%E1%84%8B%E1%85%A7%E1%84%8C%E1%85%AE%E1%84%83%E1%85%A1.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%AE%E1%86%AB%E1%84%8B%E1%85%B4.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%83%E1%85%A1%E1%86%AF.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%B1.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A9%E1%84%85%E1%85%B3%E1%86%AB%E1%84%8D%E1%85%A9%E1%86%A8.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A5%E1%84%90%E1%85%B3%E1%86%AB.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%82%E1%85%AE%E1%84%85%E1%85%B3%E1%84%83%E1%85%A1.mp4",
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(
              centerIcon: Text(
                '💬',
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
                          onTapDown:
                              (_) => setState(() => _isPressedYes = true),
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
                            _handleNoTap();
                          },
                          onTapCancel:
                              () => setState(() => _isPressedNo = false),
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
      ),
    );
  }
}
