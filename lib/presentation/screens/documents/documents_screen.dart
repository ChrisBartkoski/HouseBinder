import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../../domain/enums/enums.dart';
import '../../widgets/common_widgets.dart';

class DocumentsScreen extends ConsumerStatefulWidget {
  const DocumentsScreen({super.key});

  @override
  ConsumerState<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends ConsumerState<DocumentsScreen> {
  DocumentCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final documentsAsync = ref.watch(documentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (_) {
                      setState(() => _selectedCategory = null);
                    },
                  ),
                  const SizedBox(width: 8),
                  ...DocumentCategory.values.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(category.displayName),
                        selected: _selectedCategory == category,
                        onSelected: (_) {
                          setState(() => _selectedCategory = category);
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Documents list
          Expanded(
            child: documentsAsync.when(
              loading: () => const LoadingState(),
              error: (error, _) => ErrorState(message: error.toString()),
              data: (documents) {
                var filtered = documents;
                if (_selectedCategory != null) {
                  filtered = documents.where((d) => d.categoryEnum == _selectedCategory).toList();
                }

                if (filtered.isEmpty) {
                  if (documents.isEmpty) {
                    return EmptyState(
                      icon: Icons.folder_outlined,
                      title: 'No Documents',
                      subtitle: 'Add manuals, receipts, warranties, and more',
                      action: FilledButton.icon(
                        onPressed: () => context.push('/documents/new'),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Document'),
                      ),
                    );
                  }
                  return const EmptyState(
                    icon: Icons.search_off,
                    title: 'No Results',
                    subtitle: 'Try a different filter',
                  );
                }

                // Group by category
                final grouped = <DocumentCategory, List<Document>>{};
                for (final doc in filtered) {
                  grouped.putIfAbsent(doc.categoryEnum, () => []).add(doc);
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: grouped.length,
                  itemBuilder: (context, index) {
                    final category = grouped.keys.elementAt(index);
                    final categoryDocs = grouped[category]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(title: category.displayName),
                        ...categoryDocs.map((doc) => _DocumentTile(document: doc)),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/documents/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add Document'),
      ),
    );
  }
}

class _DocumentTile extends ConsumerWidget {
  final Document document;

  const _DocumentTile({required this.document});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Icon(
          _getIcon(),
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: 20,
        ),
      ),
      title: Text(document.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formatDate(document.dateAdded)),
          if (document.expirationDate != null)
            Text(
              document.isExpired
                  ? 'Expired'
                  : document.isExpiringSoon
                      ? 'Expiring soon'
                      : 'Expires ${formatDate(document.expirationDate!)}',
              style: TextStyle(
                color: document.isExpired || document.isExpiringSoon
                    ? Theme.of(context).colorScheme.error
                    : null,
              ),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (document.isExpired || document.isExpiringSoon)
            StatusChip(
              label: document.isExpired ? 'Expired' : 'Expiring',
              color: Theme.of(context).colorScheme.error,
              icon: Icons.warning,
            ),
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () => _openDocument(),
            tooltip: 'Open',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              switch (value) {
                case 'edit':
                  context.push('/documents/${document.id}/edit');
                  break;
                case 'delete':
                  final confirm = await showConfirmDialog(
                    context,
                    title: 'Delete Document',
                    message: 'Are you sure you want to delete "${document.title}"?',
                    confirmText: 'Delete',
                    isDestructive: true,
                  );
                  if (confirm && context.mounted) {
                    await ref.read(documentNotifierProvider.notifier).deleteDocument(document.id);
                    if (context.mounted) {
                      showSuccessSnackbar(context, 'Document deleted');
                    }
                  }
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined),
                    SizedBox(width: 12),
                    Text('Edit'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () => _openDocument(),
    );
  }

  IconData _getIcon() {
    if (document.isPdf) return Icons.picture_as_pdf;
    if (document.isImage) return Icons.image;
    return Icons.insert_drive_file;
  }

  Future<void> _openDocument() async {
    await OpenFilex.open(document.filePath);
  }
}
