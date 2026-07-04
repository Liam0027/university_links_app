import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF5B6CFF);
  static const secondary = Color(0xFF8C7BFF);

  // Light theme
  static const background = Color(0xFFF5F6FA);
  static const cardBg = Color(0xFFFFFFFF);
  static const textMain = Color(0xFF1F2230);
  static const textSub = Color(0xFF8A8D9F);

  // Dark theme
  static const backgroundDark = Color(0xFF14151D);
  static const cardBgDark = Color(0xFF1F212C);
  static const textMainDark = Color(0xFFF1F2F8);
  static const textSubDark = Color(0xFF8E91A8);
}

/// Helper extension — use context.colors in widgets instead of hardcoded AppColors
extension AppTheme on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get bgColor => isDark ? AppColors.backgroundDark : AppColors.background;
  Color get cardColor => isDark ? AppColors.cardBgDark : AppColors.cardBg;
  Color get textPrimary => isDark ? AppColors.textMainDark : AppColors.textMain;
  Color get textSecondary => isDark ? AppColors.textSubDark : AppColors.textSub;
}
