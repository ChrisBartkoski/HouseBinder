import 'package:equatable/equatable.dart';
import '../enums/enums.dart';

class Document extends Equatable {
  final String id;
  final String propertyId;
  final String title;
  final DocumentCategory category;
  final String filePath;
  final String? linkedAssetId;
  final String? notes;
  final DateTime? expirationDate;
  final DateTime dateAdded;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Document({
    required this.id,
    required this.propertyId,
    required this.title,
    required this.category,
    required this.filePath,
    this.linkedAssetId,
    this.notes,
    this.expirationDate,
    required this.dateAdded,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fileExtension {
    final parts = filePath.split('.');
    if (parts.length > 1) {
      return parts.last.toLowerCase();
    }
    return '';
  }

  bool get isPdf => fileExtension == 'pdf';
  bool get isImage =>
      ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic'].contains(fileExtension);

  bool get isExpired {
    if (expirationDate == null) return false;
    return expirationDate!.isBefore(DateTime.now());
  }

  bool get isExpiringSoon {
    if (expirationDate == null) return false;
    final daysUntilExpiration =
        expirationDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiration > 0 && daysUntilExpiration <= 30;
  }

  Document copyWith({
    String? id,
    String? propertyId,
    String? title,
    DocumentCategory? category,
    String? filePath,
    String? linkedAssetId,
    String? notes,
    DateTime? expirationDate,
    DateTime? dateAdded,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Document(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      title: title ?? this.title,
      category: category ?? this.category,
      filePath: filePath ?? this.filePath,
      linkedAssetId: linkedAssetId ?? this.linkedAssetId,
      notes: notes ?? this.notes,
      expirationDate: expirationDate ?? this.expirationDate,
      dateAdded: dateAdded ?? this.dateAdded,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'title': title,
      'category': category.name,
      'filePath': filePath,
      'linkedAssetId': linkedAssetId,
      'notes': notes,
      'expirationDate': expirationDate?.toIso8601String(),
      'dateAdded': dateAdded.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      title: json['title'] as String,
      category: DocumentCategory.values.byName(json['category'] as String),
      filePath: json['filePath'] as String,
      linkedAssetId: json['linkedAssetId'] as String?,
      notes: json['notes'] as String?,
      expirationDate: json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'] as String)
          : null,
      dateAdded: DateTime.parse(json['dateAdded'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        propertyId,
        title,
        category,
        filePath,
        linkedAssetId,
        notes,
        expirationDate,
        dateAdded,
        createdAt,
        updatedAt,
      ];
}
