import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../styles/custom_styles.dart';

class Header extends StatelessWidget {
  final Widget? centerIcon;
  final bool showSendButton;
  final VoidCallback? onSend;
  final String? goTo;
  final bool hideBackButton;

  const Header({
    super.key,
    this.centerIcon,
    this.showSendButton = false,
    this.onSend,
    this.goTo,
    this.hideBackButton = false,
  });

  void _goBack(BuildContext context) {
    if (goTo != null) {
      Navigator.pushNamed(context, goTo!);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              hideBackButton
                  ? const SizedBox(width: 48)
                  : IconButton(
                    onPressed: () => _goBack(context),
                    icon: SvgPicture.asset('assets/icons/back.svg'),
                  ),
              showSendButton
                  ? TextButton(
                    onPressed: onSend,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/video_send.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '전송',
                          style: CustomStyles.fontHead16.copyWith(
                            color: CustomStyles.primaryWhite,
                          ),
                        ),
                      ],
                    ),
                  )
                  : const SizedBox(width: 48),
            ],
          ),
          if (centerIcon != null) centerIcon!,
        ],
      ),
    );
  }
}
