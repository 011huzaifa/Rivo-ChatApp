import 'package:chatapp/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LightMode {
  ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.lightThemePrimary,
      surface: AppColors.lightThemeBg,
      onSurface: AppColors.lightThemeForeground,
      secondary: AppColors.lightThemeForegroundSecondary,
      tertiary: AppColors.lightThemeTertiaryColor
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 22,
        color: AppColors.lightThemeForeground,
        // fontWeight: FontWeight(600),
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.lightThemeForeground,
      ),
    ),
  );
}
