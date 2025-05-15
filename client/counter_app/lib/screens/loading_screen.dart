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
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A1%B0%EA%B8%88%2C%20%EC%9E%91%EB%8B%A4%2C%20%EC%A0%81%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EA%B8%B0%EB%8B%A4%EB%A6%AC%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A7%81%EC%9B%90.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%AC%B8%EC%9D%98.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%8C%80%EB%8B%B5.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%88%98%EC%96%B4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%ED%9C%B4%EB%8C%80%ED%8F%B0%2C%20%ED%95%B8%EB%93%9C%ED%8F%B0.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B3%B4%EC%97%AC%EC%A3%BC%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9E%A0%EC%8B%9C.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EA%B8%B0%EB%8B%A4%EB%A6%AC%EB%8B%A4.mp4",
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
