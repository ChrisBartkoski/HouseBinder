import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/database/database.dart';
import '../../domain/enums/enums.dart';
import 'database_provider.dart';
import 'settings_provider.dart';

const _uuid = Uuid();

final contractorsProvider = FutureProvider<List<Contractor>>((ref) async {
  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) return [];

  final db = ref.watch(databaseProvider);
  return db.getContractorsByProperty(settings.currentPropertyId!);
});

final contractorProvider =
    FutureProvider.family<Contractor?, String>((ref, id) async {
  final db = ref.watch(databaseProvider);
  return db.getContractor(id);
});

final contractorsByTradeProvider =
    FutureProvider.family<List<Contractor>, TradeType>((ref, tradeType) async {
  final contractors = await ref.watch(contractorsProvider.future);
  return contractors.where((c) => c.tradeTypeEnum == tradeType).toList();
});

final preferredContractorsProvider =
    FutureProvider<List<Contractor>>((ref) async {
  final contractors = await ref.watch(contractorsProvider.future);
  return contractors.where((c) => c.isPreferred).toList();
});

class ContractorNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<String> createContractor({
    required String name,
    String? companyName,
    required TradeType tradeType,
    String? phone,
    String? email,
    String? address,
    String? website,
    String? notes,
    bool isPreferred = false,
    double? rating,
  }) async {
    final settings = await ref.read(settingsProvider.future);
    if (settings.currentPropertyId == null) {
      throw Exception('No property selected');
    }

    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final id = _uuid.v4();

    await db.insertContractor(ContractorsCompanion(
      id: Value(id),
      propertyId: Value(settings.currentPropertyId!),
      name: Value(name),
      companyName: Value(companyName),
      tradeType: Value(tradeType.name),
      phone: Value(phone),
      email: Value(email),
      address: Value(address),
      website: Value(website),
      notes: Value(notes),
      isPreferred: Value(isPreferred),
      rating: Value(rating),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    ref.invalidate(contractorsProvider);
    return id;
  }

  Future<void> updateContractor({
    required String id,
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
  }) async {
    final db = ref.read(databaseProvider);
    await db.updateContractorById(
      id,
      ContractorsCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        companyName: Value(companyName),
        tradeType:
            tradeType != null ? Value(tradeType.name) : const Value.absent(),
        phone: Value(phone),
        email: Value(email),
        address: Value(address),
        website: Value(website),
        notes: Value(notes),
        isPreferred:
            isPreferred != null ? Value(isPreferred) : const Value.absent(),
        rating: Value(rating),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(contractorsProvider);
    ref.invalidate(contractorProvider(id));
  }

  Future<void> deleteContractor(String id) async {
    final db = ref.read(databaseProvider);
    await db.deleteContractor(id);
    ref.invalidate(contractorsProvider);
  }

  Future<void> togglePreferred(String contractorId) async {
    final db = ref.read(databaseProvider);
    final contractor = await db.getContractor(contractorId);
    if (contractor == null) return;

    await db.updateContractorById(
      contractorId,
      ContractorsCompanion(
        isPreferred: Value(!contractor.isPreferred),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(contractorsProvider);
    ref.invalidate(contractorProvider(contractorId));
  }

  Future<void> setRating(String contractorId, double rating) async {
    final db = ref.read(databaseProvider);
    await db.updateContractorById(
      contractorId,
      ContractorsCompanion(
        rating: Value(rating),
        updatedAt: Value(DateTime.now()),
      ),
    );
    ref.invalidate(contractorsProvider);
    ref.invalidate(contractorProvider(contractorId));
  }
}

final contractorNotifierProvider =
    AsyncNotifierProvider<ContractorNotifier, void>(ContractorNotifier.new);
