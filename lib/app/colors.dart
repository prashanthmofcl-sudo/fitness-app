import 'package:flutter/material.dart';

/// Global color tokens for the application.
abstract final class AppColors {
  static const Color primary = Color(0xFF7C3AED);
  static const Color primaryDark = Color(0xFF6D28D9);
  static const Color secondary = Color(0xFFA855F7);
  static const Color accent = Color(0xFFC084FC);
  static const Color gradientEnd = Color(0xFF38BDF8);
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF0F0A1F);
  static const Color darkCard = Color(0xFF1A1333);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1F1B2E);
  static const Color textLight = Color(0xFFF8FAFC);
  static const Color mutedText = Color(0xFF8B88A8);
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Legacy fitness aliases retained for compatibility. Branded UI is purple.
  static const Color fitnessLime = primary;
  static const Color fitnessOlive = primaryDark;
  static const Color fitnessGreenBorder = secondary;
  static const Color onboardingDotInactive = Color(0xFFD9D9D9);
  static const Color positiveSurface = Color(0xFFF5F0FF);
  static const Color waterSurface = Color(0xFFDCEEFF);
  static const Color sleepSurface = Color(0xFFF4EEFF);

  static const List<Color> primaryGradient = [primary, secondary];
  static const List<Color> fitnessGradient = [primary, secondary];

  static const Color lightBorder = Color(0xFFE7E3F3);
  static const Color darkBorder = Color(0xFF332A52);
}
