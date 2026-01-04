import 'package:equatable/equatable.dart';
import '../enums/enums.dart';

class Asset extends Equatable {
  final String id;
  final String propertyId;
  final String name;
  final AssetCategory category;
  final String? locationRoom;
  final String? manufacturer;
  final String? model;
  final String? serialNumber;
  final DateTime? installDate;
  final DateTime? purchaseDate;
  final DateTime? warrantyExpirationDate;
  final double? purchasePrice;
  final String? notes;
  final List<String> photoPaths;
  final String? labelPhotoPath;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Asset({
    required this.id,
    required this.propertyId,
    required this.name,
    required this.category,
    this.locationRoom,
    this.manufacturer,
    this.model,
    this.serialNumber,
    this.installDate,
    this.purchaseDate,
    this.warrantyExpirationDate,
    this.purchasePrice,
    this.notes,
    this.photoPaths = const [],
    this.labelPhotoPath,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isUnderWarranty {
    if (warrantyExpirationDate == null) return false;
    return warrantyExpirationDate!.isAfter(DateTime.now());
  }

  bool get isWarrantyExpiringSoon {
    if (warrantyExpirationDate == null) return false;
    final daysUntilExpiration =
        warrantyExpirationDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiration > 0 && daysUntilExpiration <= 90;
  }

  int? get ageInYears {
    final date = installDate ?? purchaseDate;
    if (date == null) return null;
    return DateTime.now().difference(date).inDays ~/ 365;
  }

  Asset copyWith({
    String? id,
    String? propertyId,
    String? name,
    AssetCategory? category,
    String? locationRoom,
    String? manufacturer,
    String? model,
    String? serialNumber,
    DateTime? installDate,
    DateTime? purchaseDate,
    DateTime? warrantyExpirationDate,
    double? purchasePrice,
    String? notes,
    List<String>? photoPaths,
    String? labelPhotoPath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Asset(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      category: category ?? this.category,
      locationRoom: locationRoom ?? this.locationRoom,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      serialNumber: serialNumber ?? this.serialNumber,
      installDate: installDate ?? this.installDate,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      warrantyExpirationDate:
          warrantyExpirationDate ?? this.warrantyExpirationDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      notes: notes ?? this.notes,
      photoPaths: photoPaths ?? this.photoPaths,
      labelPhotoPath: labelPhotoPath ?? this.labelPhotoPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'name': name,
      'category': category.name,
      'locationRoom': locationRoom,
      'manufacturer': manufacturer,
      'model': model,
      'serialNumber': serialNumber,
      'installDate': installDate?.toIso8601String(),
      'purchaseDate': purchaseDate?.toIso8601String(),
      'warrantyExpirationDate': warrantyExpirationDate?.toIso8601String(),
      'purchasePrice': purchasePrice,
      'notes': notes,
      'photoPaths': photoPaths,
      'labelPhotoPath': labelPhotoPath,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      name: json['name'] as String,
      category: AssetCategory.values.byName(json['category'] as String),
      locationRoom: json['locationRoom'] as String?,
      manufacturer: json['manufacturer'] as String?,
      model: json['model'] as String?,
      serialNumber: json['serialNumber'] as String?,
      installDate: json['installDate'] != null
          ? DateTime.parse(json['installDate'] as String)
          : null,
      purchaseDate: json['purchaseDate'] != null
          ? DateTime.parse(json['purchaseDate'] as String)
          : null,
      warrantyExpirationDate: json['warrantyExpirationDate'] != null
          ? DateTime.parse(json['warrantyExpirationDate'] as String)
          : null,
      purchasePrice: json['purchasePrice'] as double?,
      notes: json['notes'] as String?,
      photoPaths: (json['photoPaths'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      labelPhotoPath: json['labelPhotoPath'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        propertyId,
        name,
        category,
        locationRoom,
        manufacturer,
        model,
        serialNumber,
        installDate,
        purchaseDate,
        warrantyExpirationDate,
        purchasePrice,
        notes,
        photoPaths,
        labelPhotoPath,
        createdAt,
        updatedAt,
      ];
}
