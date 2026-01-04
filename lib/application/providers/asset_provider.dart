import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/database/database.dart';
import '../../domain/enums/enums.dart';
import 'database_provider.dart';
import 'settings_provider.dart';

const _uuid = Uuid();

final assetsProvider = FutureProvider<List<Asset>>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) return [];

  final db = ref.watch(databaseProvider);
  return db.getAssetsByProperty(settings.currentPropertyId!);
});

final assetProvider = FutureProvider.family<Asset?, String>((ref, id) async {
  final db = ref.watch(databaseProvider);
  return db.getAsset(id);
});

final assetsByCategoryProvider =
    FutureProvider.family<List<Asset>, AssetCategory>((ref, category) async {
  final assets = await ref.watch(assetsProvider.future);
  return assets.where((a) => a.categoryEnum == category).toList();
});

final assetsWithExpiringWarrantyProvider =
    FutureProvider<List<Asset>>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) return [];

  final db = ref.watch(databaseProvider);
  return db.getAssetsExpiringWarrantySoon(settings.currentPropertyId!);
});

final assetCountProvider = FutureProvider<int>((ref) async {
  final assets = await ref.watch(assetsProvider.future);
  return assets.length;
});

class AssetNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<String> createAsset({
    required String name,
    required AssetCategory category,
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
  }) async {
    final settings = await ref.read(settingsProvider.future);
    if (settings.currentPropertyId == null) {
      throw Exception('No property selected');
    }

    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final id = _uuid.v4();

    await db.insertAsset(AssetsCompanion(
      id: Value(id),
      propertyId: Value(settings.currentPropertyId!),
      name: Value(name),
      category: Value(category.name),
      locationRoom: Value(locationRoom),
      manufacturer: Value(manufacturer),
      model: Value(model),
      serialNumber: Value(serialNumber),
      installDate: Value(installDate),
      purchaseDate: Value(purchaseDate),
      warrantyExpirationDate: Value(warrantyExpirationDate),
      purchasePrice: Value(purchasePrice),
      notes: Value(notes),
      photoPaths: Value(jsonEncode(photoPaths ?? [])),
      labelPhotoPath: Value(labelPhotoPath),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    ref.invalidate(assetsProvider);
    return id;
  }

  Future<void> updateAsset({
    required String id,
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
  }) async {
    final db = ref.read(databaseProvider);
    await db.updateAssetById(
      id,
      AssetsCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        category: category != null ? Value(category.name) : const Value.absent(),
        locationRoom: Value(locationRoom),
        manufacturer: Value(manufacturer),
        model: Value(model),
        serialNumber: Value(serialNumber),
        installDate: Value(installDate),
        purchaseDate: Value(purchaseDate),
        warrantyExpirationDate: Value(warrantyExpirationDate),
        purchasePrice: Value(purchasePrice),
        notes: Value(notes),
        photoPaths:
            photoPaths != null ? Value(jsonEncode(photoPaths)) : const Value.absent(),
        labelPhotoPath: Value(labelPhotoPath),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(assetsProvider);
    ref.invalidate(assetProvider(id));
  }

  Future<void> deleteAsset(String id) async {
    final db = ref.read(databaseProvider);
    await db.deleteAsset(id);
    ref.invalidate(assetsProvider);
  }

  Future<void> addPhotoToAsset(String assetId, String photoPath) async {
    final db = ref.read(databaseProvider);
    final asset = await db.getAsset(assetId);
    if (asset == null) return;

    final updatedPhotos = [...asset.photoPathsList, photoPath];
    await db.updateAssetById(
      assetId,
      AssetsCompanion(
        photoPaths: Value(jsonEncode(updatedPhotos)),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(assetsProvider);
    ref.invalidate(assetProvider(assetId));
  }

  Future<void> setLabelPhoto(String assetId, String photoPath) async {
    final db = ref.read(databaseProvider);
    await db.updateAssetById(
      assetId,
      AssetsCompanion(
        labelPhotoPath: Value(photoPath),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(assetsProvider);
    ref.invalidate(assetProvider(assetId));
  }
}

final assetNotifierProvider =
    AsyncNotifierProvider<AssetNotifier, void>(AssetNotifier.new);
