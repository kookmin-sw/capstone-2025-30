import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/custom_styles.dart';

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
  bool _isPressedYes = false;
  bool _isPressedNo = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const videos = [
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%A1%E1%84%89%E1%85%A6%E1%84%8B%E1%85%AD%2C%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%B5+%E1%84%80%E1%85%A1%E1%84%89%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%84%8B%E1%85%A9.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%84%86%E1%85%AE%E1%86%AB.mp4",
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
                  srcList: videos,
                  aspectRatio: widget.isOrder ? (3 / 4) : (9 / 16),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuestionScreen(),
                            ),
                          );
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
