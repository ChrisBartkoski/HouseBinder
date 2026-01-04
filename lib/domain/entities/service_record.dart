import 'package:equatable/equatable.dart';

class ServiceRecord extends Equatable {
  final String id;
  final String propertyId;
  final DateTime date;
  final String title;
  final String? description;
  final List<String> assetIds;
  final String? taskId;
  final String? contractorId;
  final double? cost;
  final String? notes;
  final List<String> attachmentPaths;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ServiceRecord({
    required this.id,
    required this.propertyId,
    required this.date,
    required this.title,
    this.description,
    this.assetIds = const [],
    this.taskId,
    this.contractorId,
    this.cost,
    this.notes,
    this.attachmentPaths = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  ServiceRecord copyWith({
    String? id,
    String? propertyId,
    DateTime? date,
    String? title,
    String? description,
    List<String>? assetIds,
    String? taskId,
    String? contractorId,
    double? cost,
    String? notes,
    List<String>? attachmentPaths,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ServiceRecord(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      assetIds: assetIds ?? this.assetIds,
      taskId: taskId ?? this.taskId,
      contractorId: contractorId ?? this.contractorId,
      cost: cost ?? this.cost,
      notes: notes ?? this.notes,
      attachmentPaths: attachmentPaths ?? this.attachmentPaths,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'date': date.toIso8601String(),
      'title': title,
      'description': description,
      'assetIds': assetIds,
      'taskId': taskId,
      'contractorId': contractorId,
      'cost': cost,
      'notes': notes,
      'attachmentPaths': attachmentPaths,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ServiceRecord.fromJson(Map<String, dynamic> json) {
    return ServiceRecord(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      description: json['description'] as String?,
      assetIds: (json['assetIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      taskId: json['taskId'] as String?,
      contractorId: json['contractorId'] as String?,
      cost: json['cost'] as double?,
      notes: json['notes'] as String?,
      attachmentPaths: (json['attachmentPaths'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        propertyId,
        date,
        title,
        description,
        assetIds,
        taskId,
        contractorId,
        cost,
        notes,
        attachmentPaths,
        createdAt,
        updatedAt,
      ];
}
