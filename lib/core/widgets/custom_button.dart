import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 57.0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // Use primary color from the theme
          color:
              isLoading
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.7)
                  : Theme.of(context).primaryColor,
          // Corner Radius: 16
          borderRadius: BorderRadius.circular(16.0),
          // Drop Shadow
          boxShadow: [
            BoxShadow(
              // Y-Offset: 4
              offset: const Offset(0, 4),
              // Blur: 4
              blurRadius: 4.0,
              // Spread: 0
              spreadRadius: 0.0,
              // Color: black at 25% opacity
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        child:
            isLoading
                ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
      ),
    );
  }
}
