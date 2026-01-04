import 'package:equatable/equatable.dart';

class Property extends Equatable {
  final String id;
  final String name;
  final String? address;
  final int? yearBuilt;
  final int? squareFeet;
  final String? notes;
  final String? coverImagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Property({
    required this.id,
    required this.name,
    this.address,
    this.yearBuilt,
    this.squareFeet,
    this.notes,
    this.coverImagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  Property copyWith({
    String? id,
    String? name,
    String? address,
    int? yearBuilt,
    int? squareFeet,
    String? notes,
    String? coverImagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Property(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      yearBuilt: yearBuilt ?? this.yearBuilt,
      squareFeet: squareFeet ?? this.squareFeet,
      notes: notes ?? this.notes,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'yearBuilt': yearBuilt,
      'squareFeet': squareFeet,
      'notes': notes,
      'coverImagePath': coverImagePath,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String?,
      yearBuilt: json['yearBuilt'] as int?,
      squareFeet: json['squareFeet'] as int?,
      notes: json['notes'] as String?,
      coverImagePath: json['coverImagePath'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        yearBuilt,
        squareFeet,
        notes,
        coverImagePath,
        createdAt,
        updatedAt,
      ];
}
