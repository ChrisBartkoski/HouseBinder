import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../widgets/common_widgets.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: const InputDecoration(
            hintText: 'Search assets, tasks, documents...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                ref.read(searchQueryProvider.notifier).state = '';
              },
            ),
        ],
      ),
      body: searchResults.when(
        loading: () => const LoadingState(),
        error: (error, _) => ErrorState(message: error.toString()),
        data: (results) {
          if (results.isEmpty) {
            if (_searchController.text.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Start typing to search'),
                  ],
                ),
              );
            }
            if (_searchController.text.length < 2) {
              return const Center(
                child: Text('Type at least 2 characters'),
              );
            }
            return const EmptyState(
              icon: Icons.search_off,
              title: 'No Results',
              subtitle: 'Try a different search term',
            );
          }

          return ListView(
            children: [
              // Assets
              if (results.assets.isNotEmpty) ...[
                SectionHeader(
                  title: 'Assets (${results.assets.length})',
                ),
                ...results.assets.map((asset) => ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.inventory_2)),
                      title: Text(asset.name),
                      subtitle: Text([
                        asset.categoryEnum.displayName,
                        if (asset.manufacturer != null) asset.manufacturer,
                      ].join(' • ')),
                      onTap: () {
                        context.pop();
                        context.push('/assets/${asset.id}');
                      },
                    )),
              ],

              // Tasks
              if (results.tasks.isNotEmpty) ...[
                SectionHeader(
                  title: 'Tasks (${results.tasks.length})',
                ),
                ...results.tasks.map((task) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: task.isOverdue
                            ? Theme.of(context).colorScheme.errorContainer
                            : null,
                        child: Icon(
                          Icons.checklist,
                          color: task.isOverdue
                              ? Theme.of(context).colorScheme.onErrorContainer
                              : null,
                        ),
                      ),
                      title: Text(task.title),
                      subtitle: Text(task.frequencyEnum.displayName),
                      trailing: task.isOverdue
                          ? const StatusChip(
                              label: 'Overdue',
                              color: Colors.red,
                            )
                          : null,
                      onTap: () {
                        context.pop();
                        context.push('/tasks/${task.id}');
                      },
                    )),
              ],

              // Documents
              if (results.documents.isNotEmpty) ...[
                SectionHeader(
                  title: 'Documents (${results.documents.length})',
                ),
                ...results.documents.map((doc) => ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          doc.isPdf
                              ? Icons.picture_as_pdf
                              : doc.isImage
                                  ? Icons.image
                                  : Icons.insert_drive_file,
                        ),
                      ),
                      title: Text(doc.title),
                      subtitle: Text(doc.categoryEnum.displayName),
                      onTap: () {
                        context.pop();
                        context.push('/documents/${doc.id}/edit');
                      },
                    )),
              ],

              // Contractors
              if (results.contractors.isNotEmpty) ...[
                SectionHeader(
                  title: 'Contractors (${results.contractors.length})',
                ),
                ...results.contractors.map((contractor) => ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(contractor.displayName),
                      subtitle: Text(contractor.tradeTypeEnum.displayName),
                      trailing: contractor.isPreferred
                          ? Icon(Icons.star, color: Theme.of(context).colorScheme.primary)
                          : null,
                      onTap: () {
                        context.pop();
                        context.push('/contractors/${contractor.id}');
                      },
                    )),
              ],
            ],
          );
        },
      ),
    );
  }
}
