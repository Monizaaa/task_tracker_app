import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hideBackButton;
  final IconData? actionButtonIcon;
  final void Function()? onActionButtonPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.hideBackButton = false,
    this.actionButtonIcon,
    this.onActionButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      color: Colors.transparent, // Assumes a white or light screen background
      child: Stack(
        children: [
          if (!hideBackButton)
            GestureDetector(
              onTap: () {
                // Standard back navigation
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white, // Fill color from selection colors
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE9F1FF), // Stroke color
                    width: 1.5, // A visually pleasing width for the stroke
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color:
                      Theme.of(context)
                          .extension<AppColorsExtension>()!
                          .titleColor, // Icon color from selection colors
                  size: 20,
                ),
              ),
            ),
          if (onActionButtonPressed != null && actionButtonIcon != null)
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: onActionButtonPressed,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white, // Fill color from selection colors
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE9F1FF), // Stroke color
                      width: 1.5, // A visually pleasing width for the stroke
                    ),
                  ),
                  child: Icon(
                    actionButtonIcon,
                    color:
                        Theme.of(context)
                            .extension<AppColorsExtension>()!
                            .titleColor, // Icon color from selection colors
                    size: 28,
                  ),
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 42,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize:
                          18, // Assuming same style as previous HeaderTitle
                      fontWeight: FontWeight.w500,

                      color:
                          Theme.of(
                            context,
                          ).extension<AppColorsExtension>()!.titleColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height
}
