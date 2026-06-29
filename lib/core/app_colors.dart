import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF5B6CFF);
  static const primaryDark = Color(0xFF4A57D6);
  static const secondary = Color(0xFF8C7BFF);
  static const background = Color(0xFFF5F6FA);
  static const cardBg = Color(0xFFFFFFFF);
  static const textMain = Color(0xFF1F2230);
  static const textSub = Color(0xFF8A8D9F);

  static const backgroundDark = Color(0xFF14151D);
  static const cardBgDark = Color(0xFF1F212C);
  static const textMainDark = Color(0xFFF1F2F8);
  static const textSubDark = Color(0xFF8E91A8);
}

extension ThemedColors on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get bg => isDark ? AppColors.backgroundDark : AppColors.background;
  Color get cardBg => isDark ? AppColors.cardBgDark : AppColors.cardBg;
  Color get textMain => isDark ? AppColors.textMainDark : AppColors.textMain;
  Color get textSub => isDark ? AppColors.textSubDark : AppColors.textSub;
}
