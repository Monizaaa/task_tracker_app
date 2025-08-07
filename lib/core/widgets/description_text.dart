import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  const DescriptionText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.left, // Default alignment
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        // Typography
        fontSize: 14.0,
        fontWeight: FontWeight.w400, // Regular
        height: 24.0 / 14.0, // Line height (24) / Font size (14)
        letterSpacing: 0.0,

        // Fill Color: #868D95
        color: const Color(0xFF868D95),
      ),
    );
  }
}
