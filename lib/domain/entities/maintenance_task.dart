import 'package:equatable/equatable.dart';
import '../enums/enums.dart';

class MaintenanceTask extends Equatable {
  final String id;
  final String propertyId;
  final String title;
  final String? description;
  final String? instructions;
  final AssetCategory? category;
  final TaskFrequency frequency;
  final int? customIntervalDays;
  final Season? season;
  final DateTime? nextDueDate;
  final DateTime? lastCompletedDate;
  final List<String> linkedAssetIds;
  final double? estimatedCost;
  final int? estimatedTimeMinutes;
  final bool reminderEnabled;
  final int reminderDaysBefore;
  final String? notes;
  final bool isTemplate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MaintenanceTask({
    required this.id,
    required this.propertyId,
    required this.title,
    this.description,
    this.instructions,
    this.category,
    required this.frequency,
    this.customIntervalDays,
    this.season,
    this.nextDueDate,
    this.lastCompletedDate,
    this.linkedAssetIds = const [],
    this.estimatedCost,
    this.estimatedTimeMinutes,
    this.reminderEnabled = true,
    this.reminderDaysBefore = 3,
    this.notes,
    this.isTemplate = false,
    required this.createdAt,
    required this.updatedAt,
  });

  TaskStatus get status {
    if (lastCompletedDate != null && nextDueDate == null) {
      return TaskStatus.completed;
    }
    if (nextDueDate == null) {
      return TaskStatus.pending;
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDate =
        DateTime(nextDueDate!.year, nextDueDate!.month, nextDueDate!.day);

    if (dueDate.isBefore(today)) {
      return TaskStatus.overdue;
    } else if (dueDate.difference(today).inDays <= 7) {
      return TaskStatus.upcoming;
    }
    return TaskStatus.pending;
  }

  bool get isOverdue => status == TaskStatus.overdue;

  int? get daysUntilDue {
    if (nextDueDate == null) return null;
    return nextDueDate!.difference(DateTime.now()).inDays;
  }

  int get intervalDays {
    if (frequency == TaskFrequency.custom) {
      return customIntervalDays ?? 30;
    }
    return frequency.daysInterval ?? 0;
  }

  MaintenanceTask copyWith({
    String? id,
    String? propertyId,
    String? title,
    String? description,
    String? instructions,
    AssetCategory? category,
    TaskFrequency? frequency,
    int? customIntervalDays,
    Season? season,
    DateTime? nextDueDate,
    DateTime? lastCompletedDate,
    List<String>? linkedAssetIds,
    double? estimatedCost,
    int? estimatedTimeMinutes,
    bool? reminderEnabled,
    int? reminderDaysBefore,
    String? notes,
    bool? isTemplate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MaintenanceTask(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      title: title ?? this.title,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      category: category ?? this.category,
      frequency: frequency ?? this.frequency,
      customIntervalDays: customIntervalDays ?? this.customIntervalDays,
      season: season ?? this.season,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
      linkedAssetIds: linkedAssetIds ?? this.linkedAssetIds,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      estimatedTimeMinutes: estimatedTimeMinutes ?? this.estimatedTimeMinutes,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      notes: notes ?? this.notes,
      isTemplate: isTemplate ?? this.isTemplate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'title': title,
      'description': description,
      'instructions': instructions,
      'category': category?.name,
      'frequency': frequency.name,
      'customIntervalDays': customIntervalDays,
      'season': season?.name,
      'nextDueDate': nextDueDate?.toIso8601String(),
      'lastCompletedDate': lastCompletedDate?.toIso8601String(),
      'linkedAssetIds': linkedAssetIds,
      'estimatedCost': estimatedCost,
      'estimatedTimeMinutes': estimatedTimeMinutes,
      'reminderEnabled': reminderEnabled,
      'reminderDaysBefore': reminderDaysBefore,
      'notes': notes,
      'isTemplate': isTemplate,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory MaintenanceTask.fromJson(Map<String, dynamic> json) {
    return MaintenanceTask(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
      category: json['category'] != null
          ? AssetCategory.values.byName(json['category'] as String)
          : null,
      frequency: TaskFrequency.values.byName(json['frequency'] as String),
      customIntervalDays: json['customIntervalDays'] as int?,
      season: json['season'] != null
          ? Season.values.byName(json['season'] as String)
          : null,
      nextDueDate: json['nextDueDate'] != null
          ? DateTime.parse(json['nextDueDate'] as String)
          : null,
      lastCompletedDate: json['lastCompletedDate'] != null
          ? DateTime.parse(json['lastCompletedDate'] as String)
          : null,
      linkedAssetIds: (json['linkedAssetIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      estimatedCost: json['estimatedCost'] as double?,
      estimatedTimeMinutes: json['estimatedTimeMinutes'] as int?,
      reminderEnabled: json['reminderEnabled'] as bool? ?? true,
      reminderDaysBefore: json['reminderDaysBefore'] as int? ?? 3,
      notes: json['notes'] as String?,
      isTemplate: json['isTemplate'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        propertyId,
        title,
        description,
        instructions,
        category,
        frequency,
        customIntervalDays,
        season,
        nextDueDate,
        lastCompletedDate,
        linkedAssetIds,
        estimatedCost,
        estimatedTimeMinutes,
        reminderEnabled,
        reminderDaysBefore,
        notes,
        isTemplate,
        createdAt,
        updatedAt,
      ];
}
