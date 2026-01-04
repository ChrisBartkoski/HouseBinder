import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../widgets/common_widgets.dart';

class AssetDetailScreen extends ConsumerWidget {
  final String assetId;

  const AssetDetailScreen({super.key, required this.assetId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetAsync = ref.watch(assetProvider(assetId));
    final tasksAsync = ref.watch(tasksByAssetProvider(assetId));
    final recordsAsync = ref.watch(serviceRecordsByAssetProvider(assetId));
    final documentsAsync = ref.watch(documentsByAssetProvider(assetId));

    return assetAsync.when(
      loading: () => const Scaffold(body: LoadingState()),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(message: error.toString()),
      ),
      data: (asset) {
        if (asset == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const ErrorState(message: 'Asset not found'),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(asset.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => context.push('/assets/$assetId/edit'),
                tooltip: 'Edit',
              ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'delete') {
                    final confirm = await showConfirmDialog(
                      context,
                      title: 'Delete Asset',
                      message: 'Are you sure you want to delete "${asset.name}"?',
                      confirmText: 'Delete',
                      isDestructive: true,
                    );
                    if (confirm && context.mounted) {
                      await ref.read(assetNotifierProvider.notifier).deleteAsset(assetId);
                      if (context.mounted) {
                        context.pop();
                        showSuccessSnackbar(context, 'Asset deleted');
                      }
                    }
                  }
                },
                itemBuilder: (context) => [
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
          body: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              // Basic Info Section
              const SectionHeader(title: 'Details'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    InfoRow(
                      icon: Icons.category,
                      label: 'Category',
                      value: asset.categoryEnum.displayName,
                    ),
                    const Divider(height: 1),
                    if (asset.locationRoom != null)
                      InfoRow(
                        icon: Icons.room,
                        label: 'Location',
                        value: asset.locationRoom!,
                      ),
                    if (asset.manufacturer != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.business,
                        label: 'Manufacturer',
                        value: asset.manufacturer!,
                      ),
                    ],
                    if (asset.model != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.label,
                        label: 'Model',
                        value: asset.model!,
                      ),
                    ],
                    if (asset.serialNumber != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.numbers,
                        label: 'Serial Number',
                        value: asset.serialNumber!,
                      ),
                    ],
                  ],
                ),
              ),

              // Dates Section
              if (asset.installDate != null ||
                  asset.purchaseDate != null ||
                  asset.warrantyExpirationDate != null) ...[
                const SectionHeader(title: 'Dates'),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      if (asset.installDate != null)
                        InfoRow(
                          icon: Icons.build,
                          label: 'Install Date',
                          value: formatDate(asset.installDate!),
                        ),
                      if (asset.purchaseDate != null) ...[
                        if (asset.installDate != null) const Divider(height: 1),
                        InfoRow(
                          icon: Icons.shopping_cart,
                          label: 'Purchase Date',
                          value: formatDate(asset.purchaseDate!),
                        ),
                      ],
                      if (asset.warrantyExpirationDate != null) ...[
                        const Divider(height: 1),
                        InfoRow(
                          icon: Icons.verified_user,
                          label: 'Warranty Expires',
                          value: formatDate(asset.warrantyExpirationDate!),
                        ),
                      ],
                    ],
                  ),
                ),
                if (asset.isUnderWarranty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: StatusChip(
                      label: asset.isWarrantyExpiringSoon
                          ? 'Warranty expires soon!'
                          : 'Under warranty',
                      color: asset.isWarrantyExpiringSoon
                          ? Colors.orange
                          : Colors.green,
                      icon: Icons.verified_user,
                    ),
                  ),
              ],

              // Cost Section
              if (asset.purchasePrice != null) ...[
                const SectionHeader(title: 'Cost'),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: InfoRow(
                    icon: Icons.payments,
                    label: 'Purchase Price',
                    value: formatCurrency(asset.purchasePrice!),
                  ),
                ),
              ],

              // Notes Section
              if (asset.notes != null && asset.notes!.isNotEmpty) ...[
                const SectionHeader(title: 'Notes'),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(asset.notes!),
                  ),
                ),
              ],

              // Related Tasks
              tasksAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (tasks) {
                  if (tasks.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(title: 'Maintenance Tasks'),
                      ...tasks.map((task) => ListTile(
                            leading: Icon(
                              task.isOverdue ? Icons.warning : Icons.check_circle_outline,
                              color: task.isOverdue ? Colors.red : null,
                            ),
                            title: Text(task.title),
                            subtitle: task.nextDueDate != null
                                ? Text(formatDate(task.nextDueDate!))
                                : null,
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push('/tasks/${task.id}'),
                          )),
                    ],
                  );
                },
              ),

              // Service History
              recordsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (records) {
                  if (records.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(title: 'Service History'),
                      ...records.take(5).map((record) => ListTile(
                            leading: const Icon(Icons.build_outlined),
                            title: Text(record.title),
                            subtitle: Text(formatDate(record.date)),
                            trailing: record.cost != null
                                ? Text(formatCurrency(record.cost!))
                                : null,
                          )),
                    ],
                  );
                },
              ),

              // Documents
              documentsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (documents) {
                  if (documents.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(title: 'Documents'),
                      ...documents.map((doc) => ListTile(
                            leading: Icon(_getDocumentIcon(doc)),
                            title: Text(doc.title),
                            subtitle: Text(doc.categoryEnum.displayName),
                            trailing: const Icon(Icons.chevron_right),
                          )),
                    ],
                  );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/history/new'),
            icon: const Icon(Icons.add),
            label: const Text('Log Service'),
          ),
        );
      },
    );
  }

  IconData _getDocumentIcon(Document doc) {
    if (doc.isPdf) return Icons.picture_as_pdf;
    if (doc.isImage) return Icons.image;
    return Icons.insert_drive_file;
  }
}
