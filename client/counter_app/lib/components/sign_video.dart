import 'package:counter_app/styles/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignVideo extends StatefulWidget {
  final List<String> srcList;
  final bool isOnce;
  final VoidCallback? onVideoEnd;
  final double aspectRatio;
  final VoidCallback? onCompleted;

  const SignVideo({
    super.key,
    required this.srcList,
    this.isOnce = true,
    this.onVideoEnd,
    this.aspectRatio = 1.0,
    this.onCompleted,
  });

  @override
  _SignVideoState createState() => _SignVideoState();
}

class _SignVideoState extends State<SignVideo> {
  late VideoPlayerController _controller;
  int _currentIndex = 0;
  bool _isEnded = false;
  bool _hasCompleted = false;

  @override
  void initState() {
    super.initState();
    _initializeAndPlay(_currentIndex);
  }

  void _initializeAndPlay(int index) {
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.srcList[index]),
      )
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller.play();
      });

    _controller.setLooping(false);

    _controller.addListener(() {
      final position = _controller.value.position;
      final duration = _controller.value.duration;

      if (position >= duration * 0.99 && !_controller.value.isPlaying) {
        _onVideoEnded();
      }
    });
  }

  void _onVideoEnded() {
    if (_isEnded) return; // _onVideoEnded() 중복 호출 방지용

    if (_currentIndex < widget.srcList.length - 1) {
      setState(() {
        _currentIndex++;
        _controller.dispose();
        _initializeAndPlay(_currentIndex);
      });
    } else {
      setState(() {
        _isEnded = true;
      });

      if (widget.onVideoEnd != null) {
        widget.onVideoEnd!();
      }

      if (!_hasCompleted && widget.onCompleted != null) {
        _hasCompleted = true;
        widget.onCompleted!();
      }
    }
  }

  void _handleReplay() {
    setState(() {
      _isEnded = false;
      _hasCompleted = false;
      _currentIndex = 0;
      _controller.dispose();
      _initializeAndPlay(_currentIndex);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEndedAndLoopable = _isEnded && !widget.isOnce;

    final bool isInitialized = _controller.value.isInitialized;

    final Size videoSize =
        isInitialized ? _controller.value.size : const Size(720, 720);

    final double videoAspect = videoSize.width / videoSize.height;

    final double scale =
        widget.aspectRatio == 9 / 16
            ? 0.9 /
                (videoAspect * widget.aspectRatio) // 아바타 영상에 따라 비율 조정해야 함
            : 1.0;

    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.center,
              child: SizedBox(
                width: videoSize.width,
                height: videoSize.height,
                child:
                    isInitialized
                        ? VideoPlayer(_controller)
                        : Container(color: CustomStyles.pointGray),
              ),
            ),
          ),
          if (isEndedAndLoopable) ...[
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha((0.5 * 255).toInt()),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Center(
              child: IconButton(
                iconSize: 76,
                onPressed: _handleReplay,
                icon: SvgPicture.asset(
                  'assets/icons/reload.svg',
                  width: 76,
                  height: 76,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
