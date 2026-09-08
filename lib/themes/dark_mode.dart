import 'package:chatapp/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DarkMode {
  ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkThemePrimary,
      surface: AppColors.darkThemeBg,
      onSurface: AppColors.darkThemeForeground,
      secondary: AppColors.darkThemeForegroundSecondary,
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
