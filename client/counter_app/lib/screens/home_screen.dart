import 'package:flutter/material.dart';
import '../styles/custom_styles.dart';

import 'package:counter_app/components/header.dart';
import 'package:counter_app/components/sign_video.dart';
import 'question_screen.dart';
import 'answer_screen.dart';
import 'loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isPressed = false;

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
              "🏠",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SignVideo(srcList: videos),
                const SizedBox(height: 30),
                GestureDetector(
                  onTapDown: (_) => setState(() => _isPressed = true),
                  onTapUp: (_) {
                    setState(() => _isPressed = false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuestionScreen(),
                        // builder: (context) => const AnswerScreen(isOrder: true),
                        // builder: (context) => const LoadingScreen(),
                      ),
                    );
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
