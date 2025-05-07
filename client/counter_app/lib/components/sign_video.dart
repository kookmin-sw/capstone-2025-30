import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignVideo extends StatefulWidget {
  final List<String> srcList;
  final bool isOnce;
  final VoidCallback? onVideoEnd;
  final double aspectRatio;

  const SignVideo({
    super.key,
    required this.srcList,
    this.isOnce = false,
    this.onVideoEnd,
    this.aspectRatio = 1.0,
  });

  @override
  _SignVideoState createState() => _SignVideoState();
}

class _SignVideoState extends State<SignVideo> {
  late VideoPlayerController _controller;
  int _currentIndex = 0;
  bool _isEnded = false;

  @override
  void initState() {
    super.initState();
    _initializeAndPlay(_currentIndex);
  }

  void _initializeAndPlay(int index) {
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.srcList[index]))
          ..initialize().then((_) {
            setState(() {});
            _controller.play();
          })
          ..setLooping(false)
          ..addListener(() {
            if (_controller.value.position == _controller.value.duration &&
                !_controller.value.isPlaying) {
              _onVideoEnded();
            }
          });
  }

  void _onVideoEnded() {
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
      if (widget.isOnce && widget.onVideoEnd != null) {
        widget.onVideoEnd!();
      }
    }
  }

  void _handleReplay() {
    setState(() {
      _isEnded = false;
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

    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final videoSize = _controller.value.size;
    final double videoAspect = videoSize.width / videoSize.height;

    final double scale =
        widget.aspectRatio == 9 / 16
            ? 0.6 / (videoAspect * widget.aspectRatio)
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
                child: VideoPlayer(_controller),
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
