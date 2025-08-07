import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;
  final double width;
  final double height;

  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.iconPath,
    required this.onPressed,
    this.width = 32,
    this.height = 32,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 58,
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Color(0xFFE9F1FF), width: 1.0),
        ),
        child: SvgPicture.asset(iconPath, height: height, width: width),
      ),
    );
  }
}
