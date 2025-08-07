import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final double height;
  final String? prefixIcon;
  final Size iconSize;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.height = 60.0, // Height from design
    this.prefixIcon,
    this.iconSize = const Size(24, 24),
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        style: const TextStyle(
          color: Color(0xFF333333),
        ), // Style for user-entered text
        decoration: InputDecoration(
          prefixIcon:
              prefixIcon != null
                  ? Padding(
                    padding: EdgeInsets.all(iconSize.width / 2),
                    child: SvgPicture.asset(
                      prefixIcon!,
                      height: iconSize.height,
                      width: iconSize.width,
                    ),
                  )
                  : null,
          // Placeholder/Hint Text Style
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF848A94), // Placeholder text color
            fontSize: 16,
          ),

          // Fill Color
          filled: true,
          fillColor: Colors.white,

          // Padding
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 21.0,
          ),

          // Border Style
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0), // Corner radius
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: Color(0xFFE9F1FF), // Stroke color
              width: 1.0, // Stroke weight
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color:
                  Theme.of(
                    context,
                  ).primaryColor, // Use theme's primary color for focus
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
