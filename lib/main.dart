import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'application/providers/providers.dart';
import 'data/database/database.dart';
import 'presentation/navigation/app_router.dart';
import 'presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: HouseBinderApp(),
    ),
  );
}

class HouseBinderApp extends ConsumerWidget {
  const HouseBinderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final settingsAsync = ref.watch(settingsProvider);
    final settings = settingsAsync.asData?.value;

    // Convert our custom ThemeMode to Flutter's ThemeMode
    final themeMode = _toFlutterThemeMode(
      settings?.themeModeEnum ?? ThemeModeSetting.system,
    );
    final seedColor = settings?.themeColorEnum.seedColor ??
        AppTheme.defaultSeedColor;

    return MaterialApp.router(
      title: 'HouseBinder',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(seedColor: seedColor),
      darkTheme: AppTheme.darkTheme(seedColor: seedColor),
      themeMode: themeMode,
      routerConfig: router,
    );
  }

  ThemeMode _toFlutterThemeMode(ThemeModeSetting mode) {
    switch (mode) {
      case ThemeModeSetting.light:
        return ThemeMode.light;
      case ThemeModeSetting.dark:
        return ThemeMode.dark;
      case ThemeModeSetting.system:
        return ThemeMode.system;
    }
  }
}
