import 'package:equatable/equatable.dart';
import '../enums/enums.dart';

class Contractor extends Equatable {
  final String id;
  final String propertyId;
  final String name;
  final String? companyName;
  final TradeType tradeType;
  final String? phone;
  final String? email;
  final String? address;
  final String? website;
  final String? notes;
  final bool isPreferred;
  final double? rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Contractor({
    required this.id,
    required this.propertyId,
    required this.name,
    this.companyName,
    required this.tradeType,
    this.phone,
    this.email,
    this.address,
    this.website,
    this.notes,
    this.isPreferred = false,
    this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  String get displayName {
    if (companyName != null && companyName!.isNotEmpty) {
      return '$companyName ($name)';
    }
    return name;
  }

  Contractor copyWith({
    String? id,
    String? propertyId,
    String? name,
    String? companyName,
    TradeType? tradeType,
    String? phone,
    String? email,
    String? address,
    String? website,
    String? notes,
    bool? isPreferred,
    double? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Contractor(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      companyName: companyName ?? this.companyName,
      tradeType: tradeType ?? this.tradeType,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      website: website ?? this.website,
      notes: notes ?? this.notes,
      isPreferred: isPreferred ?? this.isPreferred,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'name': name,
      'companyName': companyName,
      'tradeType': tradeType.name,
      'phone': phone,
      'email': email,
      'address': address,
      'website': website,
      'notes': notes,
      'isPreferred': isPreferred,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Contractor.fromJson(Map<String, dynamic> json) {
    return Contractor(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      name: json['name'] as String,
      companyName: json['companyName'] as String?,
      tradeType: TradeType.values.byName(json['tradeType'] as String),
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      website: json['website'] as String?,
      notes: json['notes'] as String?,
      isPreferred: json['isPreferred'] as bool? ?? false,
      rating: json['rating'] as double?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        propertyId,
        name,
        companyName,
        tradeType,
        phone,
        email,
        address,
        website,
        notes,
        isPreferred,
        rating,
        createdAt,
        updatedAt,
      ];
}
