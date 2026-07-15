import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsStore {
  SettingsStore._();
  static final SettingsStore instance = SettingsStore._();

  static const String _notificationsKey = 'settings_notifications_enabled';
  static const String _darkModeKey = 'settings_dark_mode_enabled';
  // Tracks whether the user has manually set the theme at least once.
  // Before first manual change, theme follows the device system setting.
  static const String _darkModeSetByUserKey = 'settings_dark_mode_set_by_user';

  final ValueNotifier<bool> notificationsEnabled = ValueNotifier<bool>(true);
  final ValueNotifier<bool> darkModeEnabled = ValueNotifier<bool>(false);
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(
    ThemeMode.system,
  );

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    // Notifications: default is true
    notificationsEnabled.value = prefs.getBool(_notificationsKey) ?? true;

    final setByUser = prefs.getBool(_darkModeSetByUserKey) ?? false;
    if (setByUser) {
      // User has manually chosen — respect their choice
      final isDark = prefs.getBool(_darkModeKey) ?? false;
      darkModeEnabled.value = isDark;
      themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    } else {
      // First launch — follow device system theme
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final isDark = brightness == Brightness.dark;
      darkModeEnabled.value = isDark;
      themeMode.value = ThemeMode.system;
    }
  }

  Future<void> setNotificationsEnabled(bool value) async {
    notificationsEnabled.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, value);
  }

  Future<void> setDarkModeEnabled(bool value) async {
    darkModeEnabled.value = value;
    themeMode.value = value ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, value);
    // Mark that the user has manually chosen — no longer follow system theme
    await prefs.setBool(_darkModeSetByUserKey, true);
  }
}
