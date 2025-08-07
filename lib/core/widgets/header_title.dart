import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';

class HeaderTitle extends StatelessWidget {
  final String title;

  const HeaderTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.left,
      // Use GoogleFonts.poppins() to apply the font and styles
      style: TextStyle(
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 25.0,
        height: 1.0, // Line-height (25) / Font-size (25) = 1.0
        letterSpacing: 0.0,

        // Fill Color: #002055
        color: Theme.of(context).extension<AppColorsExtension>()!.titleColor,
      ),
    );
  }
}
