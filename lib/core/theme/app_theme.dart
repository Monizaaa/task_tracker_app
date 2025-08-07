import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _lightPrimaryColor = Color(0xFF756EF3);
  static const _darkPrimaryColor = Color(0xFF3580FF);

  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light();
    final themeWithColors = baseTheme.copyWith(
      primaryColor: _lightPrimaryColor,
      scaffoldBackgroundColor: const Color(0xFFFDFDFD), // A slightly off-white
      colorScheme: const ColorScheme.light(
        primary: _lightPrimaryColor,
        secondary: _lightPrimaryColor,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        AppColorsExtension(
          greyColor: Color(0xFF868D95),
          titleColor: Color(0xFF002055),
        ),
      ],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightPrimaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      appBarTheme: baseTheme.appBarTheme.copyWith(
        backgroundColor: _lightPrimaryColor,
        foregroundColor: Colors.white, // For title and icons
      ),
    );
    return _applyFonts(themeWithColors);
  }

  static ThemeData get darkTheme {
    final baseTheme = ThemeData.dark();
    final themeWithColors = baseTheme.copyWith(
      primaryColor: _darkPrimaryColor,
      scaffoldBackgroundColor: const Color(
        0xFF121212,
      ), // Material dark standard
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondary: _darkPrimaryColor,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        AppColorsExtension(
          greyColor: Color(0xFF848A94),
          titleColor: Colors.white,
        ),
      ],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkPrimaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
    return _applyFonts(themeWithColors);
  }

  static ThemeData _applyFonts(ThemeData theme) {
    final locale = Get.locale ?? Get.deviceLocale;
    final textTheme = theme.textTheme;

    if (locale?.languageCode == 'th') {
      return theme.copyWith(textTheme: GoogleFonts.kanitTextTheme(textTheme));
    } else {
      // Default to English/Poppins
      return theme.copyWith(textTheme: GoogleFonts.poppinsTextTheme(textTheme));
    }
  }
}

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({required this.greyColor, required this.titleColor});

  final Color? greyColor;
  final Color? titleColor;

  @override
  AppColorsExtension copyWith({Color? greyColor}) {
    return AppColorsExtension(greyColor: greyColor, titleColor: titleColor);
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      titleColor: Color.lerp(titleColor, other.titleColor, t),
    );
  }
}
