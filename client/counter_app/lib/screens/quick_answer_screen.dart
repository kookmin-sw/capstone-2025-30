import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:counter_app/components/header.dart';
import 'package:counter_app/components/sign_video.dart';

class QuickAnswerScreen extends StatefulWidget {
  final bool isWifi;

  const QuickAnswerScreen({super.key, this.isWifi = false});

  @override
  State<QuickAnswerScreen> createState() => _QuickAnswerScreenState();
}

class _QuickAnswerScreenState extends State<QuickAnswerScreen> {
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    const wifiVideos = [
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%B5%E1%86%AB%E1%84%90%E1%85%A5%E1%84%82%E1%85%A6%E1%86%BA.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B9%84%EB%B0%80.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B2%88%ED%98%B8.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/cafepassword+~+%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%82%E1%85%B5%E1%84%83%E1%85%A1.mp4",
    ];

    const restroomVideos = [
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%ED%99%94%EC%9E%A5%EC%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%98%A4%EB%A5%B8%EC%AA%BD.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9E%88%EB%8B%A4.mp4",
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
                  srcList: widget.isWifi ? wifiVideos : restroomVideos,
                  aspectRatio: (9 / 16),
                  isOnce: false,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
