import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/database/database.dart';
import '../../domain/enums/enums.dart';
import 'database_provider.dart';
import 'settings_provider.dart';

const _uuid = Uuid();

final tasksProvider = FutureProvider<List<MaintenanceTask>>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) return [];

  final db = ref.watch(databaseProvider);
  final tasks = await db.getTasksByProperty(settings.currentPropertyId!);

  // Sort: overdue first, then by due date
  tasks.sort((a, b) {
    if (a.isOverdue && !b.isOverdue) return -1;
    if (!a.isOverdue && b.isOverdue) return 1;
    if (a.nextDueDate == null && b.nextDueDate == null) return 0;
    if (a.nextDueDate == null) return 1;
    if (b.nextDueDate == null) return -1;
    return a.nextDueDate!.compareTo(b.nextDueDate!);
  });

  return tasks;
});

final taskProvider =
    FutureProvider.family<MaintenanceTask?, String>((ref, id) async {
  final db = ref.watch(databaseProvider);
  return db.getTask(id);
});

final overdueTasksProvider =
    FutureProvider<List<MaintenanceTask>>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) return [];

  final db = ref.watch(databaseProvider);
  return db.getOverdueTasks(settings.currentPropertyId!);
});

final upcomingTasksProvider =
    FutureProvider.family<List<MaintenanceTask>, int>((ref, days) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) return [];

  final db = ref.watch(databaseProvider);
  return db.getUpcomingTasks(settings.currentPropertyId!, days);
});

final overdueTaskCountProvider = FutureProvider<int>((ref) async {
  final tasks = await ref.watch(overdueTasksProvider.future);
  return tasks.length;
});

final tasksByAssetProvider =
    FutureProvider.family<List<MaintenanceTask>, String>((ref, assetId) async {
  final tasks = await ref.watch(tasksProvider.future);
  return tasks.where((t) => t.linkedAssetIdsList.contains(assetId)).toList();
});

class TaskNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<String> createTask({
    required String title,
    String? description,
    String? instructions,
    AssetCategory? category,
    required TaskFrequency frequency,
    int? customIntervalDays,
    Season? season,
    DateTime? nextDueDate,
    List<String>? linkedAssetIds,
    double? estimatedCost,
    int? estimatedTimeMinutes,
    bool reminderEnabled = true,
    int reminderDaysBefore = 3,
    String? notes,
  }) async {
    final settings = await ref.read(settingsProvider.future);
    if (settings.currentPropertyId == null) {
      throw Exception('No property selected');
    }

    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final id = _uuid.v4();

    // Calculate initial due date if not provided
    DateTime? dueDate = nextDueDate;
    if (dueDate == null && frequency != TaskFrequency.once) {
      final interval = frequency == TaskFrequency.custom
          ? customIntervalDays ?? 30
          : frequency.daysInterval ?? 30;
      dueDate = now.add(Duration(days: interval));
    }

    await db.insertTask(MaintenanceTasksCompanion(
      id: Value(id),
      propertyId: Value(settings.currentPropertyId!),
      title: Value(title),
      description: Value(description),
      instructions: Value(instructions),
      category: Value(category?.name),
      frequency: Value(frequency.name),
      customIntervalDays: Value(customIntervalDays),
      season: Value(season?.name),
      nextDueDate: Value(dueDate),
      lastCompletedDate: const Value(null),
      linkedAssetIds: Value(jsonEncode(linkedAssetIds ?? [])),
      estimatedCost: Value(estimatedCost),
      estimatedTimeMinutes: Value(estimatedTimeMinutes),
      reminderEnabled: Value(reminderEnabled),
      reminderDaysBefore: Value(reminderDaysBefore),
      notes: Value(notes),
      isTemplate: const Value(false),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    ref.invalidate(tasksProvider);
    return id;
  }

  Future<void> updateTask({
    required String id,
    String? title,
    String? description,
    String? instructions,
    AssetCategory? category,
    TaskFrequency? frequency,
    int? customIntervalDays,
    Season? season,
    DateTime? nextDueDate,
    List<String>? linkedAssetIds,
    double? estimatedCost,
    int? estimatedTimeMinutes,
    bool? reminderEnabled,
    int? reminderDaysBefore,
    String? notes,
  }) async {
    final db = ref.read(databaseProvider);
    await db.updateTaskById(
      id,
      MaintenanceTasksCompanion(
        title: title != null ? Value(title) : const Value.absent(),
        description: Value(description),
        instructions: Value(instructions),
        category: Value(category?.name),
        frequency:
            frequency != null ? Value(frequency.name) : const Value.absent(),
        customIntervalDays: Value(customIntervalDays),
        season: Value(season?.name),
        nextDueDate: Value(nextDueDate),
        linkedAssetIds: linkedAssetIds != null
            ? Value(jsonEncode(linkedAssetIds))
            : const Value.absent(),
        estimatedCost: Value(estimatedCost),
        estimatedTimeMinutes: Value(estimatedTimeMinutes),
        reminderEnabled:
            reminderEnabled != null ? Value(reminderEnabled) : const Value.absent(),
        reminderDaysBefore:
            reminderDaysBefore != null ? Value(reminderDaysBefore) : const Value.absent(),
        notes: Value(notes),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(tasksProvider);
    ref.invalidate(taskProvider(id));
  }

  Future<void> deleteTask(String id) async {
    final db = ref.read(databaseProvider);
    await db.deleteTask(id);
    ref.invalidate(tasksProvider);
  }

  Future<void> completeTask(String taskId, {String? notes, double? cost}) async {
    final db = ref.read(databaseProvider);
    final task = await db.getTask(taskId);
    if (task == null) return;

    final now = DateTime.now();

    // Calculate next due date for recurring tasks
    DateTime? nextDue;
    if (task.frequencyEnum != TaskFrequency.once) {
      final interval = task.intervalDays ?? 30;
      nextDue = now.add(Duration(days: interval));
    }

    await db.updateTaskById(
      taskId,
      MaintenanceTasksCompanion(
        lastCompletedDate: Value(now),
        nextDueDate: Value(nextDue),
        updatedAt: Value(now),
      ),
    );

    ref.invalidate(tasksProvider);
    ref.invalidate(taskProvider(taskId));
    ref.invalidate(overdueTasksProvider);
  }

  Future<void> skipTask(String taskId) async {
    final db = ref.read(databaseProvider);
    final task = await db.getTask(taskId);
    if (task == null) return;

    final now = DateTime.now();

    // Move to next occurrence without marking complete
    DateTime? nextDue;
    if (task.frequencyEnum != TaskFrequency.once) {
      final interval = task.intervalDays ?? 30;
      nextDue = now.add(Duration(days: interval));
    }

    await db.updateTaskById(
      taskId,
      MaintenanceTasksCompanion(
        nextDueDate: Value(nextDue),
        updatedAt: Value(now),
      ),
    );

    ref.invalidate(tasksProvider);
    ref.invalidate(taskProvider(taskId));
  }

  Future<void> snoozeTask(String taskId, int days) async {
    final db = ref.read(databaseProvider);
    final task = await db.getTask(taskId);
    if (task == null) return;

    final now = DateTime.now();
    final newDueDate = (task.nextDueDate ?? now).add(Duration(days: days));

    await db.updateTaskById(
      taskId,
      MaintenanceTasksCompanion(
        nextDueDate: Value(newDueDate),
        updatedAt: Value(now),
      ),
    );

    ref.invalidate(tasksProvider);
    ref.invalidate(taskProvider(taskId));
  }
}

final taskNotifierProvider =
    AsyncNotifierProvider<TaskNotifier, void>(TaskNotifier.new);
