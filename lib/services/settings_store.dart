import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsStore {
  SettingsStore._();
  static final SettingsStore instance = SettingsStore._();

  static const _notificationsKey = 'settings_notifications_enabled';
  static const _darkModeKey = 'settings_dark_mode_enabled';

  final ValueNotifier<bool> notificationsEnabled = ValueNotifier<bool>(false);
  final ValueNotifier<bool> darkModeEnabled = ValueNotifier<bool>(false);
  final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.light);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    notificationsEnabled.value = prefs.getBool(_notificationsKey) ?? false;
    final isDark = prefs.getBool(_darkModeKey) ?? false;
    darkModeEnabled.value = isDark;
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
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
  }
}
