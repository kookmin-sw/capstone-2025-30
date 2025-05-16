import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../styles/custom_styles.dart';
import 'package:counter_app/components/header.dart';
import 'package:counter_app/components/bottom_sheet.dart';
import 'package:counter_app/components/sign_video.dart';

class LoadingScreen extends StatefulWidget {
  final bool error;

  const LoadingScreen({super.key, this.error = false});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const videos = [
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%A9%E1%84%80%E1%85%B3%E1%86%B7%2C%20%E1%84%8C%E1%85%A1%E1%86%A8%E1%84%83%E1%85%A1%2C%20%E1%84%8C%E1%85%A5%E1%86%A8%E1%84%83%E1%85%A1.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%80%E1%85%B5%E1%84%83%E1%85%A1%E1%84%85%E1%85%B5%E1%84%83%E1%85%A1.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%B5%E1%86%A8%E1%84%8B%E1%85%AF%E1%86%AB.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%86%E1%85%AE%E1%86%AB%E1%84%8B%E1%85%B4.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%83%E1%85%A2%E1%84%83%E1%85%A1%E1%86%B8.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%AE%E1%84%8B%E1%85%A5.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%92%E1%85%B2%E1%84%83%E1%85%A2%E1%84%91%E1%85%A9%E1%86%AB%2C%20%E1%84%92%E1%85%A2%E1%86%AB%E1%84%83%E1%85%B3%E1%84%91%E1%85%A9%E1%86%AB.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%87%E1%85%A9%E1%84%8B%E1%85%A7%E1%84%8C%E1%85%AE%E1%84%83%E1%85%A1.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%A1%E1%86%B7%E1%84%89%E1%85%B5.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%80%E1%85%B5%E1%84%83%E1%85%A1%E1%84%85%E1%85%B5%E1%84%83%E1%85%A1.mp4",
    ];

    return Stack(
      children: [
        Scaffold(
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
                    SignVideo(srcList: videos, isOnce: false),
                    const SizedBox(height: 30),
                    Center(
                      child: SpinKitFadingCircle(
                        color: CustomStyles.pointGray,
                        size: screenWidth * 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        if (widget.error)
          BottomSheetWidget(
            onClose: () {
              Navigator.pop(context);
            },
          ),
      ],
    );
  }
}
