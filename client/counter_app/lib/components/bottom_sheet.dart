import 'package:flutter/material.dart';

import '../styles/custom_styles.dart';
import 'package:counter_app/components/sign_video.dart';

class BottomSheetWidget extends StatefulWidget {
  final VoidCallback onClose;

  const BottomSheetWidget({super.key, required this.onClose});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with SingleTickerProviderStateMixin {
  double _dragOffset = 0.0;
  bool _isDragging = false;

  void _onVerticalDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dy > 0) {
      setState(() {
        _dragOffset += details.delta.dy;
      });
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });

    if (_dragOffset > 100) {
      setState(() {
        _dragOffset = 600;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        widget.onClose();
        setState(() {
          _dragOffset = 0;
        });
      });
    } else {
      setState(() {
        _dragOffset = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const videos = [
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%95%88%EB%90%98%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%88%98%EC%96%B4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%80%EC%A7%81%EC%9D%B4%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%ED%95%9C%EA%B8%80.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B3%80%ED%95%98%EB%8B%A4%2C%20%EB%B3%80%ED%99%98.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%8B%A4%ED%8C%A8.mp4",

      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/또%2C 그리고%2C 다시.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/수어.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/움직이다.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/보여주다.mp4",

      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%AC%B8%EC%9D%98.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%A4%91%EC%A7%80%2C%EB%81%84%EB%8B%A4%2C%EB%A9%88%EC%B6%94%EB%8B%A4%2C%EA%B7%B8%EB%A7%8C%2C%EB%A7%88%EB%A5%B4%EB%8B%A4%2C%EC%A0%95%EC%A7%80.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9B%90%ED%95%98%EB%8B%A4%2C%EB%B0%94%EB%9D%BC%EB%8B%A4.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%99%BC%EC%AA%BD.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EC%9C%84.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%B2%84%ED%8A%BC.mp4",
      "https://signlanguagerawvideo.s3.ap-northeast-2.amazonaws.com/%EB%88%84%EB%A5%B4%EB%8B%A4.mp4)",
    ];

    return GestureDetector(
      onTap: widget.onClose,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: CustomStyles.primaryBlack.withAlpha((0.6 * 255).toInt()),
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {},
          onVerticalDragStart: _onVerticalDragStart,
          onVerticalDragUpdate: _onVerticalDragUpdate,
          onVerticalDragEnd: _onVerticalDragEnd,
          child: AnimatedContainer(
            duration:
                _isDragging ? Duration.zero : const Duration(milliseconds: 300),
            transform: Matrix4.translationValues(0, _dragOffset, 0),
            curve: Curves.easeOut,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            decoration: const BoxDecoration(
              color: CustomStyles.primaryWhite,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 4,
                    decoration: BoxDecoration(
                      color: CustomStyles.pointGray,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SignVideo(srcList: videos, isOnce: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
