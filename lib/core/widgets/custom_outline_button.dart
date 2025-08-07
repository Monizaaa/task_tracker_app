import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color borderColor;
  final bool active;

  const CustomOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderColor = const Color(0xFF756EF3),
    this.active = true,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor:
            active
                ? Theme.of(context).extension<AppColorsExtension>()?.titleColor!
                : Theme.of(
                      context,
                    ).extension<AppColorsExtension>()?.greyColor ??
                    Colors.grey,
        // The pill shape with fully rounded ends
        shape: const StadiumBorder(),
        // Defines the border's color and thickness
        side: BorderSide(
          color: active ? borderColor : Colors.transparent,
          width: 1.5, // A visually pleasing thickness
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        // Defines all text properties
        textStyle: TextStyle(
          fontWeight: FontWeight.w500, // Medium weight
          fontSize: 14,
          color:
              active
                  ? Theme.of(
                    context,
                  ).extension<AppColorsExtension>()?.titleColor!
                  : Theme.of(
                        context,
                      ).extension<AppColorsExtension>()?.greyColor ??
                      Colors.grey,
        ),
      ),
      child: Center(child: Text(text)),
    );
  }
}
