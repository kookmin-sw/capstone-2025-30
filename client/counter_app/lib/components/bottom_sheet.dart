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
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%A1%E1%84%89%E1%85%A6%E1%84%8B%E1%85%AD%2C%E1%84%8B%E1%85%A1%E1%86%AB%E1%84%82%E1%85%A7%E1%86%BC%E1%84%92%E1%85%B5+%E1%84%80%E1%85%A1%E1%84%89%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%84%8B%E1%85%A9.mp4",
      "https://signorderavatarvideo.s3.ap-northeast-2.amazonaws.com/%E1%84%8C%E1%85%AE%E1%84%86%E1%85%AE%E1%86%AB.mp4",
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
