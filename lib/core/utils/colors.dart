import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color errorLight = Color(0xFFFFF3F8);
  static const Color errorDefault = Color(0xFFED405C);
  static const Color warningDefault = Color(0xFFDB9308);
  static const Color successBG = Color(0xFFDFFFF6);
  static const Color primaryActive = Color(0xFF0094D7);
  static const Color primarySecondary = Color(0xFF1FB3F8);
  static const Color primaryTextColor = Color(0xFF242F40);
  static const Color green = Color(0xFF2AD062);

  static const Color body = Color(0xFF394455);
  static const Color placeHolder = Color(0xFFA0A3BD);
  static const Color textNeutral = Color(0xFF5F738C);
  static const Color splashBg = Color(0xFF0094D7);

  static LinearGradient getLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        color[300]!,
        color[200]!,
        color[100]!,
      ],
      stops: const [
        0.4,
        0.7,
        0.9,
      ],
    );
  }

  static LinearGradient getDarkLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        color[400]!,
        color[300]!,
        color[200]!,
      ],
      stops: const [
        0.4,
        0.6,
        1,
      ],
    );
  }
}
