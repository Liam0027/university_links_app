import 'package:flutter/material.dart';
import 'app.dart';
import 'services/favorites_store.dart';
import 'services/settings_store.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoritesStore.instance.load();
  await SettingsStore.instance.load();
  await NotificationService.instance.init();
  await NotificationService.instance.restoreIfNeeded();
  runApp(const App());
}
