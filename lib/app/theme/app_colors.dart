import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF6C3FC8);
  static const accent = Color(0xFFFF4D8D);

  static const backgroundBlack = Color(0xFF08060D);
  static const backgroundPurple = Color(0xFF140D24);
  static const surfaceDark = Color(0xFF1B1528);

  static const glassWhite = Color(0x14FFFFFF);
  static const glassBorder = Color(0x2EFFFFFF);

  static const white = Color(0xFFFFFFFF);
  static const secondaryText = Color(0xFFB9B1C8);
  static const mutedText = Color(0xFF817891);

  static const success = Color(0xFF38D39F);
  static const warning = Color(0xFFFFB547);
  static const error = Color(0xFFFF5C70);

  static const primaryGradient = LinearGradient(
    colors: [
      primary,
      accent,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const backgroundGradient = LinearGradient(
    colors: [
      Color(0xFF241040),
      backgroundBlack,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const matchGlow = LinearGradient(
    colors: [
      accent,
      Color(0xFF8A5CF6),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}