import 'package:equatable/equatable.dart';

enum ThemeMode { system, light, dark }

enum MeasurementUnit { imperial, metric }

class AppSettings extends Equatable {
  final ThemeMode themeMode;
  final MeasurementUnit measurementUnit;
  final String currency;
  final String currencySymbol;
  final bool notificationsEnabled;
  final int defaultReminderDays;
  final bool showCompletedTasks;
  final String? currentPropertyId;
  final bool hasCompletedOnboarding;
  final DateTime? lastBackupDate;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.measurementUnit = MeasurementUnit.imperial,
    this.currency = 'USD',
    this.currencySymbol = '\$',
    this.notificationsEnabled = true,
    this.defaultReminderDays = 3,
    this.showCompletedTasks = false,
    this.currentPropertyId,
    this.hasCompletedOnboarding = false,
    this.lastBackupDate,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    MeasurementUnit? measurementUnit,
    String? currency,
    String? currencySymbol,
    bool? notificationsEnabled,
    int? defaultReminderDays,
    bool? showCompletedTasks,
    String? currentPropertyId,
    bool? hasCompletedOnboarding,
    DateTime? lastBackupDate,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      measurementUnit: measurementUnit ?? this.measurementUnit,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      defaultReminderDays: defaultReminderDays ?? this.defaultReminderDays,
      showCompletedTasks: showCompletedTasks ?? this.showCompletedTasks,
      currentPropertyId: currentPropertyId ?? this.currentPropertyId,
      hasCompletedOnboarding:
          hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      lastBackupDate: lastBackupDate ?? this.lastBackupDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.name,
      'measurementUnit': measurementUnit.name,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'notificationsEnabled': notificationsEnabled,
      'defaultReminderDays': defaultReminderDays,
      'showCompletedTasks': showCompletedTasks,
      'currentPropertyId': currentPropertyId,
      'hasCompletedOnboarding': hasCompletedOnboarding,
      'lastBackupDate': lastBackupDate?.toIso8601String(),
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      themeMode: ThemeMode.values.byName(json['themeMode'] as String? ?? 'system'),
      measurementUnit: MeasurementUnit.values
          .byName(json['measurementUnit'] as String? ?? 'imperial'),
      currency: json['currency'] as String? ?? 'USD',
      currencySymbol: json['currencySymbol'] as String? ?? '\$',
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      defaultReminderDays: json['defaultReminderDays'] as int? ?? 3,
      showCompletedTasks: json['showCompletedTasks'] as bool? ?? false,
      currentPropertyId: json['currentPropertyId'] as String?,
      hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool? ?? false,
      lastBackupDate: json['lastBackupDate'] != null
          ? DateTime.parse(json['lastBackupDate'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        measurementUnit,
        currency,
        currencySymbol,
        notificationsEnabled,
        defaultReminderDays,
        showCompletedTasks,
        currentPropertyId,
        hasCompletedOnboarding,
        lastBackupDate,
      ];
}
