import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/database/database.dart';
import '../../domain/enums/enums.dart';
import 'database_provider.dart';
import 'settings_provider.dart';

const _uuid = Uuid();

final documentsProvider = FutureProvider<List<Document>>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) return [];

  final db = ref.watch(databaseProvider);
  return db.getDocumentsByProperty(settings.currentPropertyId!);
});

final documentProvider =
    FutureProvider.family<Document?, String>((ref, id) async {
  final db = ref.watch(databaseProvider);
  return db.getDocument(id);
});

final documentsByAssetProvider =
    FutureProvider.family<List<Document>, String>((ref, assetId) async {
  final db = ref.watch(databaseProvider);
  return db.getDocumentsByAsset(assetId);
});

final documentsByCategoryProvider =
    FutureProvider.family<List<Document>, DocumentCategory>(
        (ref, category) async {
  final documents = await ref.watch(documentsProvider.future);
  return documents.where((d) => d.categoryEnum == category).toList();
});

final recentDocumentsProvider =
    FutureProvider.family<List<Document>, int>((ref, count) async {
  final documents = await ref.watch(documentsProvider.future);
  return documents.take(count).toList();
});

final expiringDocumentsProvider = FutureProvider<List<Document>>((ref) async {
  final documents = await ref.watch(documentsProvider.future);
  return documents.where((d) => d.isExpiringSoon || d.isExpired).toList();
});

class DocumentNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<String> createDocument({
    required String title,
    required DocumentCategory category,
    required String filePath,
    String? linkedAssetId,
    String? notes,
    DateTime? expirationDate,
  }) async {
    final settings = await ref.read(settingsProvider.future);
    if (settings.currentPropertyId == null) {
      throw Exception('No property selected');
    }

    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final id = _uuid.v4();

    await db.insertDocument(DocumentsCompanion(
      id: Value(id),
      propertyId: Value(settings.currentPropertyId!),
      title: Value(title),
      category: Value(category.name),
      filePath: Value(filePath),
      linkedAssetId: Value(linkedAssetId),
      notes: Value(notes),
      expirationDate: Value(expirationDate),
      dateAdded: Value(now),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    ref.invalidate(documentsProvider);
    return id;
  }

  Future<void> updateDocument({
    required String id,
    String? title,
    DocumentCategory? category,
    String? filePath,
    String? linkedAssetId,
    String? notes,
    DateTime? expirationDate,
  }) async {
    final db = ref.read(databaseProvider);
    await db.updateDocumentById(
      id,
      DocumentsCompanion(
        title: title != null ? Value(title) : const Value.absent(),
        category:
            category != null ? Value(category.name) : const Value.absent(),
        filePath: filePath != null ? Value(filePath) : const Value.absent(),
        linkedAssetId: Value(linkedAssetId),
        notes: Value(notes),
        expirationDate: Value(expirationDate),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(documentsProvider);
    ref.invalidate(documentProvider(id));
  }

  Future<void> deleteDocument(String id) async {
    final db = ref.read(databaseProvider);
    await db.deleteDocument(id);
    ref.invalidate(documentsProvider);
  }

  Future<void> linkToAsset(String documentId, String assetId) async {
    final db = ref.read(databaseProvider);
    await db.updateDocumentById(
      documentId,
      DocumentsCompanion(
        linkedAssetId: Value(assetId),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(documentsProvider);
    ref.invalidate(documentProvider(documentId));
  }
}

final documentNotifierProvider =
    AsyncNotifierProvider<DocumentNotifier, void>(DocumentNotifier.new);
