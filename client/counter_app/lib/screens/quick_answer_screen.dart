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
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%B5%E1%86%AB%E1%84%90%E1%85%A5%E1%84%82%E1%85%A6%E1%86%BA.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%B5%E1%84%86%E1%85%B5%E1%86%AF.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A5%E1%86%AB%E1%84%92%E1%85%A9.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%B5%E1%86%BB%E1%84%83%E1%85%A1.mp4",
    ];

    const restroomVideos = [
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%92%E1%85%AA%E1%84%8C%E1%85%A1%E1%86%BC%E1%84%89%E1%85%B5%E1%86%AF.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A9%E1%84%85%E1%85%B3%E1%86%AB%E1%84%8D%E1%85%A9%E1%86%A8.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%B5%E1%86%BB%E1%84%83%E1%85%A1.mp4",
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
