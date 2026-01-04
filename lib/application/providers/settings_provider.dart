import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/database.dart';
import '../../domain/enums/theme_color.dart';
import 'database_provider.dart';

final settingsProvider =
    AsyncNotifierProvider<SettingsNotifier, AppSettingsTableData>(
        SettingsNotifier.new);

class SettingsNotifier extends AsyncNotifier<AppSettingsTableData> {
  @override
  Future<AppSettingsTableData> build() async {
    final db = ref.watch(databaseProvider);
    return db.getSettings();
  }

  Future<void> updateSettings(AppSettingsTableCompanion settings) async {
    final db = ref.read(databaseProvider);
    await db.updateSettings(settings);
    ref.invalidateSelf();
  }

  Future<void> setCurrentProperty(String? propertyId) async {
    await updateSettings(
      AppSettingsTableCompanion(
        currentPropertyId: Value(propertyId),
      ),
    );
  }

  Future<void> setThemeMode(ThemeModeSetting mode) async {
    await updateSettings(
      AppSettingsTableCompanion(
        themeMode: Value(mode.name),
      ),
    );
  }

  Future<void> setThemeColor(ThemeColor color) async {
    await updateSettings(
      AppSettingsTableCompanion(
        themeColor: Value(color.name),
      ),
    );
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    await updateSettings(
      AppSettingsTableCompanion(
        notificationsEnabled: Value(enabled),
      ),
    );
  }

  Future<void> completeOnboarding() async {
    await updateSettings(
      AppSettingsTableCompanion(
        hasCompletedOnboarding: const Value(true),
      ),
    );
  }

  Future<void> setLastBackupDate(DateTime date) async {
    await updateSettings(
      AppSettingsTableCompanion(
        lastBackupDate: Value(date),
      ),
    );
  }
}
