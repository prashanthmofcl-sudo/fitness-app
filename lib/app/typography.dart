import 'package:flutter/material.dart';

import 'colors.dart';

/// Reusable typography styles backed by the platform's modern system font.
abstract final class AppTypography {
  static const TextStyle heading = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.2,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.mutedText,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static TextTheme textTheme(Color textColor) => TextTheme(
        displaySmall: heading.copyWith(color: textColor),
        headlineSmall: title.copyWith(color: textColor),
        titleMedium: subtitle.copyWith(color: textColor),
        bodyLarge: body.copyWith(color: textColor),
        bodyMedium: body.copyWith(fontSize: 14, color: textColor),
        bodySmall: caption,
        labelLarge: button.copyWith(color: textColor),
      );
}
