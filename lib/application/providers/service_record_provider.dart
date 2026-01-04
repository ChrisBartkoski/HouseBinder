import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/database/database.dart';
import 'database_provider.dart';
import 'settings_provider.dart';

const _uuid = Uuid();

final serviceRecordsProvider =
    FutureProvider<List<ServiceRecord>>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) return [];

  final db = ref.watch(databaseProvider);
  return db.getServiceRecordsByProperty(settings.currentPropertyId!);
});

final serviceRecordProvider =
    FutureProvider.family<ServiceRecord?, String>((ref, id) async {
  final db = ref.watch(databaseProvider);
  return db.getServiceRecord(id);
});

final serviceRecordsByAssetProvider =
    FutureProvider.family<List<ServiceRecord>, String>((ref, assetId) async {
  final db = ref.watch(databaseProvider);
  return db.getServiceRecordsByAsset(assetId);
});

final recentServiceRecordsProvider =
    FutureProvider.family<List<ServiceRecord>, int>((ref, count) async {
  final records = await ref.watch(serviceRecordsProvider.future);
  return records.take(count).toList();
});

final totalSpendingProvider =
    FutureProvider.family<double, int?>((ref, months) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) return 0;

  final db = ref.watch(databaseProvider);
  return db.getTotalSpending(settings.currentPropertyId!, lastMonths: months);
});

class ServiceRecordNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<String> createServiceRecord({
    required DateTime date,
    required String title,
    String? description,
    List<String>? assetIds,
    String? taskId,
    String? contractorId,
    double? cost,
    String? notes,
    List<String>? attachmentPaths,
  }) async {
    final settings = await ref.read(settingsProvider.future);
    if (settings.currentPropertyId == null) {
      throw Exception('No property selected');
    }

    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final id = _uuid.v4();

    await db.insertServiceRecord(ServiceRecordsCompanion(
      id: Value(id),
      propertyId: Value(settings.currentPropertyId!),
      date: Value(date),
      title: Value(title),
      description: Value(description),
      assetIds: Value(jsonEncode(assetIds ?? [])),
      taskId: Value(taskId),
      contractorId: Value(contractorId),
      cost: Value(cost),
      notes: Value(notes),
      attachmentPaths: Value(jsonEncode(attachmentPaths ?? [])),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    ref.invalidate(serviceRecordsProvider);
    return id;
  }

  Future<void> updateServiceRecord({
    required String id,
    DateTime? date,
    String? title,
    String? description,
    List<String>? assetIds,
    String? taskId,
    String? contractorId,
    double? cost,
    String? notes,
    List<String>? attachmentPaths,
  }) async {
    final db = ref.read(databaseProvider);
    await db.updateServiceRecordById(
      id,
      ServiceRecordsCompanion(
        date: date != null ? Value(date) : const Value.absent(),
        title: title != null ? Value(title) : const Value.absent(),
        description: Value(description),
        assetIds:
            assetIds != null ? Value(jsonEncode(assetIds)) : const Value.absent(),
        taskId: Value(taskId),
        contractorId: Value(contractorId),
        cost: Value(cost),
        notes: Value(notes),
        attachmentPaths: attachmentPaths != null
            ? Value(jsonEncode(attachmentPaths))
            : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(serviceRecordsProvider);
    ref.invalidate(serviceRecordProvider(id));
  }

  Future<void> deleteServiceRecord(String id) async {
    final db = ref.read(databaseProvider);
    await db.deleteServiceRecord(id);
    ref.invalidate(serviceRecordsProvider);
  }

  Future<void> addAttachment(String recordId, String attachmentPath) async {
    final db = ref.read(databaseProvider);
    final record = await db.getServiceRecord(recordId);
    if (record == null) return;

    final updatedPaths = [...record.attachmentPathsList, attachmentPath];
    await db.updateServiceRecordById(
      recordId,
      ServiceRecordsCompanion(
        attachmentPaths: Value(jsonEncode(updatedPaths)),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(serviceRecordsProvider);
    ref.invalidate(serviceRecordProvider(recordId));
  }
}

final serviceRecordNotifierProvider =
    AsyncNotifierProvider<ServiceRecordNotifier, void>(
        ServiceRecordNotifier.new);
