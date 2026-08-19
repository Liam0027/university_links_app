import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_colors.dart';
import 'services/settings_store.dart';
import 'ui/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: SettingsStore.instance.themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'سراد',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: _buildTheme(Brightness.light),
          darkTheme: _buildTheme(Brightness.dark),
          builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // On Android 15+ (API 35), edge-to-edge is enforced and
              // setNavigationBarColor() is deprecated/ignored for any
              // non-transparent value — so we go fully transparent and let
              // the Scaffold's own background color show through, instead
              // of trying to "match" a solid color (which silently no-ops
              // on newer Android versions).
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: context.isDark
                  ? Brightness.light
                  : Brightness.dark,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarContrastEnforced: false,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: context.isDark
                  ? Brightness.light
                  : Brightness.dark,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            ),
          ),
          home: const MainPage(),
        );
      },
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textMainDark : AppColors.textMain;
    final bgColor = isDark ? AppColors.backgroundDark : AppColors.background;
    final cardColor = isDark ? AppColors.cardBgDark : AppColors.cardBg;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: bgColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        primary: AppColors.primary,
        surface: cardColor,
        onSurface: textColor,
      ),
      cardColor: cardColor,
      fontFamily: 'Vazirmatn',
      textTheme: Typography.material2021().black.apply(
        fontFamily: 'Vazirmatn',
        bodyColor: textColor,
        displayColor: textColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
