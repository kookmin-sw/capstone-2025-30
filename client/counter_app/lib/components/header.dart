import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final Widget? centerIcon;
  final String? goTo;

  const Header({super.key, this.centerIcon, this.goTo});

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => _goBack(context),
                  icon: SvgPicture.asset('assets/icons/back.svg'),
                ),
              ],
            ),
          ),

          if (centerIcon != null) centerIcon!,
        ],
      ),
    );
  }
}
