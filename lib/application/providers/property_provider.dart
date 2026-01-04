import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/database/database.dart';
import 'database_provider.dart';
import 'settings_provider.dart';

const _uuid = Uuid();

final propertiesProvider =
    AsyncNotifierProvider<PropertiesNotifier, List<Property>>(
        PropertiesNotifier.new);

class PropertiesNotifier extends AsyncNotifier<List<Property>> {
  @override
  Future<List<Property>> build() async {
    final db = ref.watch(databaseProvider);
    return db.getAllProperties();
  }

  Future<String> createProperty({
    required String name,
    String? address,
    int? yearBuilt,
    int? squareFeet,
    String? notes,
    String? coverImagePath,
  }) async {
    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final id = _uuid.v4();

    await db.insertProperty(PropertiesCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      yearBuilt: Value(yearBuilt),
      squareFeet: Value(squareFeet),
      notes: Value(notes),
      coverImagePath: Value(coverImagePath),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    // If this is the first property, set it as current
    final settings = await ref.read(settingsProvider.future);
    if (settings.currentPropertyId == null) {
      await ref.read(settingsProvider.notifier).setCurrentProperty(id);
    }

    ref.invalidateSelf();
    return id;
  }

  Future<void> updateProperty({
    required String id,
    String? name,
    String? address,
    int? yearBuilt,
    int? squareFeet,
    String? notes,
    String? coverImagePath,
  }) async {
    final db = ref.read(databaseProvider);
    await db.updatePropertyById(
      id,
      PropertiesCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        address: Value(address),
        yearBuilt: Value(yearBuilt),
        squareFeet: Value(squareFeet),
        notes: Value(notes),
        coverImagePath: Value(coverImagePath),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidateSelf();
  }

  Future<void> deleteProperty(String id) async {
    final db = ref.read(databaseProvider);
    await db.deleteProperty(id);

    // If deleted property was current, select another
    final settings = await ref.read(settingsProvider.future);
    if (settings.currentPropertyId == id) {
      final remaining = await db.getAllProperties();
      final newCurrentId = remaining.isNotEmpty ? remaining.first.id : null;
      await ref.read(settingsProvider.notifier).setCurrentProperty(newCurrentId);
    }

    ref.invalidateSelf();
  }
}

final currentPropertyProvider = FutureProvider<Property?>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) return null;

  final db = ref.watch(databaseProvider);
  return db.getProperty(settings.currentPropertyId!);
});

final propertyProvider =
    FutureProvider.family<Property?, String>((ref, id) async {
  final db = ref.watch(databaseProvider);
  return db.getProperty(id);
});
