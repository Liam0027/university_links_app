import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'services/favorites_store.dart';
import 'services/settings_store.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Explicitly opt into edge-to-edge so the system nav bar can be made
  // transparent consistently across Android versions.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await FavoritesStore.instance.load();
  await SettingsStore.instance.load();
  await NotificationService.instance.init();
  await NotificationService.instance.restoreIfNeeded();
  runApp(const App());
}
