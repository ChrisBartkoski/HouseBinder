import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/database.dart';
import 'database_provider.dart';
import 'settings_provider.dart';

class SearchResult {
  final List<Asset> assets;
  final List<MaintenanceTask> tasks;
  final List<Document> documents;
  final List<Contractor> contractors;

  const SearchResult({
    this.assets = const [],
    this.tasks = const [],
    this.documents = const [],
    this.contractors = const [],
  });

  bool get isEmpty =>
      assets.isEmpty &&
      tasks.isEmpty &&
      documents.isEmpty &&
      contractors.isEmpty;

  int get totalCount =>
      assets.length + tasks.length + documents.length + contractors.length;
}

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<SearchResult>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty || query.length < 2) {
    return const SearchResult();
  }

  final settings = await ref.watch(settingsProvider.future);
  if (settings.currentPropertyId == null) {
    return const SearchResult();
  }

  final db = ref.watch(databaseProvider);
  final propertyId = settings.currentPropertyId!;

  final results = await Future.wait([
    db.searchAssets(propertyId, query),
    db.searchTasks(propertyId, query),
    db.searchDocuments(propertyId, query),
    db.searchContractors(propertyId, query),
  ]);

  return SearchResult(
    assets: results[0] as List<Asset>,
    tasks: results[1] as List<MaintenanceTask>,
    documents: results[2] as List<Document>,
    contractors: results[3] as List<Contractor>,
  );
});
