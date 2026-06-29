import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app_colors.dart';
import 'services/settings_store.dart';
import 'ui/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.vazirmatnTextTheme();

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: SettingsStore.instance.themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'لینک‌های دانشگاه',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: AppColors.background,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
            ),
            textTheme: baseTextTheme.apply(
              bodyColor: AppColors.textMain,
              displayColor: AppColors.textMain,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.backgroundDark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              brightness: Brightness.dark,
              primary: AppColors.primary,
            ),
            textTheme: baseTextTheme.apply(
              bodyColor: AppColors.textMainDark,
              displayColor: AppColors.textMainDark,
            ),
          ),
          builder: (context, child) => Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          ),
          home: const MainPage(),
        );
      },
    );
  }
}
