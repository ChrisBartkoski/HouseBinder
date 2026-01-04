import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../domain/enums/enums.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Properties,
  Assets,
  MaintenanceTasks,
  ServiceRecords,
  Contractors,
  Documents,
  AppSettingsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Insert default settings
        await into(appSettingsTable).insert(
          AppSettingsTableCompanion.insert(),
        );
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(appSettingsTable, appSettingsTable.themeColor);
        }
      },
    );
  }

  // Properties
  Future<List<Property>> getAllProperties() async {
    return await select(properties).get();
  }

  Future<Property?> getProperty(String id) async {
    return await (select(properties)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertProperty(PropertiesCompanion property) async {
    await into(properties).insert(property);
  }

  Future<void> updatePropertyById(
      String id, PropertiesCompanion companion) async {
    await (update(properties)..where((t) => t.id.equals(id))).write(companion);
  }

  Future<void> deleteProperty(String id) async {
    await (delete(properties)..where((t) => t.id.equals(id))).go();
  }

  // Assets
  Future<List<Asset>> getAssetsByProperty(String propertyId) async {
    return await (select(assets)
          ..where((t) => t.propertyId.equals(propertyId)))
        .get();
  }

  Future<Asset?> getAsset(String id) async {
    return await (select(assets)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertAsset(AssetsCompanion asset) async {
    await into(assets).insert(asset);
  }

  Future<void> updateAssetById(String id, AssetsCompanion companion) async {
    await (update(assets)..where((t) => t.id.equals(id))).write(companion);
  }

  Future<void> deleteAsset(String id) async {
    await (delete(assets)..where((t) => t.id.equals(id))).go();
  }

  Future<List<Asset>> getAssetsExpiringWarrantySoon(String propertyId) async {
    final now = DateTime.now();
    final ninetyDaysLater = now.add(const Duration(days: 90));
    return await (select(assets)
          ..where((t) =>
              t.propertyId.equals(propertyId) &
              t.warrantyExpirationDate.isBiggerThanValue(now) &
              t.warrantyExpirationDate.isSmallerThanValue(ninetyDaysLater)))
        .get();
  }

  // Maintenance Tasks
  Future<List<MaintenanceTask>> getTasksByProperty(String propertyId) async {
    return await (select(maintenanceTasks)
          ..where((t) =>
              t.propertyId.equals(propertyId) & t.isTemplate.equals(false)))
        .get();
  }

  Future<List<MaintenanceTask>> getOverdueTasks(String propertyId) async {
    final now = DateTime.now();
    return await (select(maintenanceTasks)
          ..where((t) =>
              t.propertyId.equals(propertyId) &
              t.isTemplate.equals(false) &
              t.nextDueDate.isSmallerThanValue(now)))
        .get();
  }

  Future<List<MaintenanceTask>> getUpcomingTasks(
      String propertyId, int days) async {
    final now = DateTime.now();
    final future = now.add(Duration(days: days));
    return await (select(maintenanceTasks)
          ..where((t) =>
              t.propertyId.equals(propertyId) &
              t.isTemplate.equals(false) &
              t.nextDueDate.isBiggerOrEqualValue(now) &
              t.nextDueDate.isSmallerOrEqualValue(future))
          ..orderBy([(t) => OrderingTerm.asc(t.nextDueDate)]))
        .get();
  }

  Future<MaintenanceTask?> getTask(String id) async {
    return await (select(maintenanceTasks)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertTask(MaintenanceTasksCompanion task) async {
    await into(maintenanceTasks).insert(task);
  }

  Future<void> updateTaskById(
      String id, MaintenanceTasksCompanion companion) async {
    await (update(maintenanceTasks)..where((t) => t.id.equals(id)))
        .write(companion);
  }

  Future<void> deleteTask(String id) async {
    await (delete(maintenanceTasks)..where((t) => t.id.equals(id))).go();
  }

  // Service Records
  Future<List<ServiceRecord>> getServiceRecordsByProperty(
      String propertyId) async {
    return await (select(serviceRecords)
          ..where((t) => t.propertyId.equals(propertyId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }

  Future<List<ServiceRecord>> getServiceRecordsByAsset(String assetId) async {
    final rows = await (select(serviceRecords)
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
    return rows.where((row) {
      final assetIds = _parseJsonStringList(row.assetIds);
      return assetIds.contains(assetId);
    }).toList();
  }

  Future<ServiceRecord?> getServiceRecord(String id) async {
    return await (select(serviceRecords)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertServiceRecord(ServiceRecordsCompanion record) async {
    await into(serviceRecords).insert(record);
  }

  Future<void> updateServiceRecordById(
      String id, ServiceRecordsCompanion companion) async {
    await (update(serviceRecords)..where((t) => t.id.equals(id)))
        .write(companion);
  }

  Future<void> deleteServiceRecord(String id) async {
    await (delete(serviceRecords)..where((t) => t.id.equals(id))).go();
  }

  // Contractors
  Future<List<Contractor>> getContractorsByProperty(String propertyId) async {
    return await (select(contractors)
          ..where((t) => t.propertyId.equals(propertyId))
          ..orderBy([
            (t) => OrderingTerm.desc(t.isPreferred),
            (t) => OrderingTerm.asc(t.name)
          ]))
        .get();
  }

  Future<Contractor?> getContractor(String id) async {
    return await (select(contractors)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertContractor(ContractorsCompanion contractor) async {
    await into(contractors).insert(contractor);
  }

  Future<void> updateContractorById(
      String id, ContractorsCompanion companion) async {
    await (update(contractors)..where((t) => t.id.equals(id))).write(companion);
  }

  Future<void> deleteContractor(String id) async {
    await (delete(contractors)..where((t) => t.id.equals(id))).go();
  }

  // Documents
  Future<List<Document>> getDocumentsByProperty(String propertyId) async {
    return await (select(documents)
          ..where((t) => t.propertyId.equals(propertyId))
          ..orderBy([(t) => OrderingTerm.desc(t.dateAdded)]))
        .get();
  }

  Future<List<Document>> getDocumentsByAsset(String assetId) async {
    return await (select(documents)
          ..where((t) => t.linkedAssetId.equals(assetId))
          ..orderBy([(t) => OrderingTerm.desc(t.dateAdded)]))
        .get();
  }

  Future<Document?> getDocument(String id) async {
    return await (select(documents)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertDocument(DocumentsCompanion document) async {
    await into(documents).insert(document);
  }

  Future<void> updateDocumentById(
      String id, DocumentsCompanion companion) async {
    await (update(documents)..where((t) => t.id.equals(id))).write(companion);
  }

  Future<void> deleteDocument(String id) async {
    await (delete(documents)..where((t) => t.id.equals(id))).go();
  }

  // App Settings
  Future<AppSettingsTableData> getSettings() async {
    final row = await select(appSettingsTable).getSingleOrNull();
    if (row == null) {
      // Return default settings
      return AppSettingsTableData(
        id: 1,
        themeMode: 'system',
        themeColor: 'green',
        measurementUnit: 'imperial',
        currency: 'USD',
        currencySymbol: '\$',
        notificationsEnabled: true,
        defaultReminderDays: 3,
        showCompletedTasks: false,
        currentPropertyId: null,
        hasCompletedOnboarding: false,
        lastBackupDate: null,
      );
    }
    return row;
  }

  Future<void> updateSettings(AppSettingsTableCompanion settings) async {
    await update(appSettingsTable).write(settings);
  }

  // Search
  Future<List<Asset>> searchAssets(String propertyId, String query) async {
    final lowerQuery = '%${query.toLowerCase()}%';
    return await (select(assets)
          ..where((t) =>
              t.propertyId.equals(propertyId) &
              (t.name.lower().like(lowerQuery) |
                  t.manufacturer.lower().like(lowerQuery) |
                  t.model.lower().like(lowerQuery) |
                  t.locationRoom.lower().like(lowerQuery))))
        .get();
  }

  Future<List<MaintenanceTask>> searchTasks(
      String propertyId, String query) async {
    final lowerQuery = '%${query.toLowerCase()}%';
    return await (select(maintenanceTasks)
          ..where((t) =>
              t.propertyId.equals(propertyId) &
              t.isTemplate.equals(false) &
              (t.title.lower().like(lowerQuery) |
                  t.description.lower().like(lowerQuery))))
        .get();
  }

  Future<List<Document>> searchDocuments(
      String propertyId, String query) async {
    final lowerQuery = '%${query.toLowerCase()}%';
    return await (select(documents)
          ..where((t) =>
              t.propertyId.equals(propertyId) &
              t.title.lower().like(lowerQuery)))
        .get();
  }

  Future<List<Contractor>> searchContractors(
      String propertyId, String query) async {
    final lowerQuery = '%${query.toLowerCase()}%';
    return await (select(contractors)
          ..where((t) =>
              t.propertyId.equals(propertyId) &
              (t.name.lower().like(lowerQuery) |
                  t.companyName.lower().like(lowerQuery))))
        .get();
  }

  // Statistics
  Future<int> getAssetCount(String propertyId) async {
    final result = await (select(assets)
          ..where((t) => t.propertyId.equals(propertyId)))
        .get();
    return result.length;
  }

  Future<int> getOverdueTaskCount(String propertyId) async {
    final now = DateTime.now();
    final result = await (select(maintenanceTasks)
          ..where((t) =>
              t.propertyId.equals(propertyId) &
              t.isTemplate.equals(false) &
              t.nextDueDate.isSmallerThanValue(now)))
        .get();
    return result.length;
  }

  Future<double> getTotalSpending(String propertyId, {int? lastMonths}) async {
    var query = select(serviceRecords)
      ..where((t) => t.propertyId.equals(propertyId));

    if (lastMonths != null) {
      final startDate =
          DateTime.now().subtract(Duration(days: lastMonths * 30));
      query = query..where((t) => t.date.isBiggerOrEqualValue(startDate));
    }

    final rows = await query.get();
    double total = 0.0;
    for (final row in rows) {
      total += row.cost ?? 0;
    }
    return total;
  }

  // Helper to parse JSON string lists
  List<String> _parseJsonStringList(String json) {
    try {
      return (jsonDecode(json) as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } catch (_) {
      return [];
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'housebinder.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

// Extension methods for Drift data classes to add convenience getters

extension PropertyExtension on Property {
  String get displayAddress => address ?? 'No address';
}

extension AssetExtension on Asset {
  AssetCategory get categoryEnum => AssetCategory.values.byName(category);

  List<String> get photoPathsList {
    try {
      return (jsonDecode(photoPaths) as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } catch (_) {
      return [];
    }
  }

  bool get isWarrantyExpired {
    if (warrantyExpirationDate == null) return false;
    return warrantyExpirationDate!.isBefore(DateTime.now());
  }

  bool get isUnderWarranty {
    if (warrantyExpirationDate == null) return false;
    return warrantyExpirationDate!.isAfter(DateTime.now());
  }

  bool get isWarrantyExpiringSoon {
    if (warrantyExpirationDate == null) return false;
    final now = DateTime.now();
    final ninetyDaysLater = now.add(const Duration(days: 90));
    return warrantyExpirationDate!.isAfter(now) &&
        warrantyExpirationDate!.isBefore(ninetyDaysLater);
  }
}

extension MaintenanceTaskExtension on MaintenanceTask {
  AssetCategory? get categoryEnum =>
      category != null ? AssetCategory.values.byName(category!) : null;

  TaskFrequency get frequencyEnum => TaskFrequency.values.byName(frequency);

  Season? get seasonEnum =>
      season != null ? Season.values.byName(season!) : null;

  List<String> get linkedAssetIdsList {
    try {
      return (jsonDecode(linkedAssetIds) as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } catch (_) {
      return [];
    }
  }

  bool get isOverdue {
    if (nextDueDate == null) return false;
    return nextDueDate!.isBefore(DateTime.now());
  }

  bool get isDueSoon {
    if (nextDueDate == null) return false;
    final now = DateTime.now();
    final sevenDaysLater = now.add(const Duration(days: 7));
    return nextDueDate!.isAfter(now) && nextDueDate!.isBefore(sevenDaysLater);
  }

  int? get intervalDays {
    if (frequency == 'custom') return customIntervalDays;
    return frequencyEnum.daysInterval;
  }

  int? get daysUntilDue {
    if (nextDueDate == null) return null;
    return nextDueDate!.difference(DateTime.now()).inDays;
  }
}

extension ServiceRecordExtension on ServiceRecord {
  List<String> get assetIdsList {
    try {
      return (jsonDecode(assetIds) as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } catch (_) {
      return [];
    }
  }

  List<String> get attachmentPathsList {
    try {
      return (jsonDecode(attachmentPaths) as List<dynamic>)
          .map((e) => e as String)
          .toList();
    } catch (_) {
      return [];
    }
  }
}

extension ContractorExtension on Contractor {
  TradeType get tradeTypeEnum => TradeType.values.byName(tradeType);

  String get displayName {
    if (companyName != null && companyName!.isNotEmpty) {
      return '$companyName ($name)';
    }
    return name;
  }
}

extension DocumentExtension on Document {
  DocumentCategory get categoryEnum =>
      DocumentCategory.values.byName(category);

  bool get isExpired {
    if (expirationDate == null) return false;
    return expirationDate!.isBefore(DateTime.now());
  }

  bool get isExpiringSoon {
    if (expirationDate == null) return false;
    final now = DateTime.now();
    final thirtyDaysLater = now.add(const Duration(days: 30));
    return expirationDate!.isAfter(now) &&
        expirationDate!.isBefore(thirtyDaysLater);
  }

  bool get isPdf {
    final lower = filePath.toLowerCase();
    return lower.endsWith('.pdf');
  }

  bool get isImage {
    final lower = filePath.toLowerCase();
    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp');
  }
}

extension AppSettingsExtension on AppSettingsTableData {
  ThemeModeSetting get themeModeEnum =>
      ThemeModeSetting.values.byName(themeMode);

  ThemeColor get themeColorEnum => ThemeColor.values.byName(themeColor);

  MeasurementUnitSetting get measurementUnitEnum =>
      MeasurementUnitSetting.values.byName(measurementUnit);
}

// Renamed enums to avoid conflicts with Flutter's ThemeMode
enum ThemeModeSetting { system, light, dark }

enum MeasurementUnitSetting { imperial, metric }
