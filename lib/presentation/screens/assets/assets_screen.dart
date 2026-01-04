import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../../domain/enums/enums.dart';
import '../../widgets/common_widgets.dart';

class AssetsScreen extends ConsumerStatefulWidget {
  const AssetsScreen({super.key});

  @override
  ConsumerState<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends ConsumerState<AssetsScreen> {
  AssetCategory? _selectedCategory;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final assetsAsync = ref.watch(assetsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filter bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search assets...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: _selectedCategory == null,
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = null;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      ...AssetCategory.values.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(category.displayName),
                            selected: _selectedCategory == category,
                            onSelected: (_) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Assets list
          Expanded(
            child: assetsAsync.when(
              loading: () => const LoadingState(),
              error: (error, _) => ErrorState(message: error.toString()),
              data: (assets) {
                var filteredAssets = assets;

                // Apply category filter
                if (_selectedCategory != null) {
                  filteredAssets = filteredAssets
                      .where((a) => a.categoryEnum == _selectedCategory)
                      .toList();
                }

                // Apply search filter
                if (_searchQuery.isNotEmpty) {
                  final query = _searchQuery.toLowerCase();
                  filteredAssets = filteredAssets.where((a) {
                    return a.name.toLowerCase().contains(query) ||
                        (a.manufacturer?.toLowerCase().contains(query) ?? false) ||
                        (a.model?.toLowerCase().contains(query) ?? false) ||
                        (a.locationRoom?.toLowerCase().contains(query) ?? false);
                  }).toList();
                }

                if (filteredAssets.isEmpty) {
                  if (assets.isEmpty) {
                    return EmptyState(
                      icon: Icons.inventory_2_outlined,
                      title: 'No Assets Yet',
                      subtitle: 'Add your first appliance, system, or equipment',
                      action: FilledButton.icon(
                        onPressed: () => context.push('/assets/new'),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Asset'),
                      ),
                    );
                  }
                  return const EmptyState(
                    icon: Icons.search_off,
                    title: 'No Results',
                    subtitle: 'Try a different search or filter',
                  );
                }

                // Group by category
                final grouped = <AssetCategory, List<Asset>>{};
                for (final asset in filteredAssets) {
                  grouped.putIfAbsent(asset.categoryEnum, () => []).add(asset);
                }

                return ListView.builder(
                  itemCount: grouped.length,
                  itemBuilder: (context, index) {
                    final category = grouped.keys.elementAt(index);
                    final categoryAssets = grouped[category]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(title: category.displayName),
                        ...categoryAssets.map((asset) => _AssetListTile(asset: asset)),
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
        onPressed: () => context.push('/assets/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add Asset'),
      ),
    );
  }
}

class _AssetListTile extends StatelessWidget {
  final Asset asset;

  const _AssetListTile({required this.asset});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLeadingIcon(context),
      title: Text(asset.name),
      subtitle: Text(_buildSubtitle()),
      trailing: _buildTrailing(context),
      onTap: () => context.push('/assets/${asset.id}'),
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    IconData iconData;
    switch (asset.categoryEnum) {
      case AssetCategory.hvac:
        iconData = Icons.ac_unit;
      case AssetCategory.plumbing:
        iconData = Icons.plumbing;
      case AssetCategory.electrical:
        iconData = Icons.electrical_services;
      case AssetCategory.kitchen:
        iconData = Icons.kitchen;
      case AssetCategory.laundry:
        iconData = Icons.local_laundry_service;
      case AssetCategory.bathroom:
        iconData = Icons.bathroom;
      case AssetCategory.exterior:
        iconData = Icons.yard;
      case AssetCategory.structural:
        iconData = Icons.foundation;
      case AssetCategory.safety:
        iconData = Icons.health_and_safety;
      case AssetCategory.entertainment:
        iconData = Icons.tv;
      case AssetCategory.other:
        iconData = Icons.category;
    }

    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Icon(
        iconData,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        size: 20,
      ),
    );
  }

  String _buildSubtitle() {
    final parts = <String>[];
    if (asset.manufacturer != null) {
      parts.add(asset.manufacturer!);
    }
    if (asset.model != null) {
      parts.add(asset.model!);
    }
    if (asset.locationRoom != null) {
      parts.add(asset.locationRoom!);
    }
    return parts.isNotEmpty ? parts.join(' • ') : 'No details';
  }

  Widget? _buildTrailing(BuildContext context) {
    if (asset.isWarrantyExpiringSoon) {
      return StatusChip(
        label: 'Warranty Soon',
        color: Theme.of(context).colorScheme.tertiary,
        icon: Icons.warning_outlined,
      );
    }
    if (asset.isUnderWarranty) {
      return StatusChip(
        label: 'Under Warranty',
        color: Colors.green,
        icon: Icons.verified_user_outlined,
      );
    }
    return const Icon(Icons.chevron_right);
  }
}
