import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../widgets/common_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertyAsync = ref.watch(currentPropertyProvider);
    final overdueTasksAsync = ref.watch(overdueTasksProvider);
    final upcomingTasksAsync = ref.watch(upcomingTasksProvider(7));
    final expiringWarrantiesAsync = ref.watch(assetsWithExpiringWarrantyProvider);
    final recentRecordsAsync = ref.watch(recentServiceRecordsProvider(5));

    return Scaffold(
      appBar: AppBar(
        title: propertyAsync.when(
          data: (property) => Text(property?.name ?? 'HouseBinder'),
          loading: () => const Text('HouseBinder'),
          error: (_, __) => const Text('HouseBinder'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => context.push('/reports'),
            tooltip: 'Generate Report',
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.go('/settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: propertyAsync.when(
        loading: () => const LoadingState(),
        error: (error, _) => ErrorState(message: error.toString()),
        data: (property) {
          if (property == null) {
            return EmptyState(
              icon: Icons.home_work_outlined,
              title: 'No Property Set Up',
              subtitle: 'Add your first property to get started',
              action: FilledButton.icon(
                onPressed: () => context.go('/settings'),
                icon: const Icon(Icons.add),
                label: const Text('Add Property'),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(overdueTasksProvider);
              ref.invalidate(upcomingTasksProvider(7));
              ref.invalidate(assetsWithExpiringWarrantyProvider);
              ref.invalidate(recentServiceRecordsProvider(5));
            },
            child: ListView(
              padding: const EdgeInsets.only(bottom: 100),
              children: [
                // Quick Actions
                const SectionHeader(title: 'Quick Actions'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _QuickAction(
                        icon: Icons.add_home_outlined,
                        label: 'Add Asset',
                        onTap: () => context.push('/assets/new'),
                      ),
                      _QuickAction(
                        icon: Icons.add_task,
                        label: 'Add Task',
                        onTap: () => context.push('/tasks/new'),
                      ),
                      _QuickAction(
                        icon: Icons.receipt_long_outlined,
                        label: 'Log Service',
                        onTap: () => context.push('/history/new'),
                      ),
                      _QuickAction(
                        icon: Icons.upload_file,
                        label: 'Add Document',
                        onTap: () => context.push('/documents/new'),
                      ),
                    ],
                  ),
                ),

                // Overdue Tasks
                overdueTasksAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (tasks) {
                    if (tasks.isEmpty) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'Overdue Tasks',
                          trailing: TextButton(
                            onPressed: () => context.go('/tasks'),
                            child: const Text('View All'),
                          ),
                        ),
                        ...tasks.take(3).map((task) => _TaskListTile(task: task)),
                      ],
                    );
                  },
                ),

                // Upcoming Tasks
                upcomingTasksAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (tasks) {
                    if (tasks.isEmpty) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'Upcoming This Week',
                          trailing: TextButton(
                            onPressed: () => context.go('/tasks'),
                            child: const Text('View All'),
                          ),
                        ),
                        ...tasks.take(5).map((task) => _TaskListTile(task: task)),
                      ],
                    );
                  },
                ),

                // Expiring Warranties
                expiringWarrantiesAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (assets) {
                    if (assets.isEmpty) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'Warranties Expiring Soon',
                          trailing: TextButton(
                            onPressed: () => context.go('/assets'),
                            child: const Text('View All'),
                          ),
                        ),
                        ...assets.take(3).map((asset) => _WarrantyListTile(asset: asset)),
                      ],
                    );
                  },
                ),

                // Recent Service History
                recentRecordsAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (records) {
                    if (records.isEmpty) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'Recent Service',
                          trailing: TextButton(
                            onPressed: () => context.go('/history'),
                            child: const Text('View All'),
                          ),
                        ),
                        ...records.map((record) => _ServiceRecordTile(record: record)),
                      ],
                    );
                  },
                ),

                // Summary Stats
                const SectionHeader(title: 'Property Summary'),
                _PropertyStats(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskListTile extends ConsumerWidget {
  final MaintenanceTask task;

  const _TaskListTile({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOverdue = task.isOverdue;
    final daysUntil = task.daysUntilDue;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isOverdue
            ? Theme.of(context).colorScheme.errorContainer
            : Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          isOverdue ? Icons.warning : Icons.check_circle_outline,
          color: isOverdue
              ? Theme.of(context).colorScheme.onErrorContainer
              : Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text(task.title),
      subtitle: Text(
        daysUntil != null ? formatDaysUntil(daysUntil) : 'No due date',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              await ref.read(taskNotifierProvider.notifier).completeTask(task.id);
              if (context.mounted) {
                showSuccessSnackbar(context, 'Task completed');
              }
            },
            tooltip: 'Complete',
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => context.push('/tasks/${task.id}'),
    );
  }
}

class _WarrantyListTile extends StatelessWidget {
  final Asset asset;

  const _WarrantyListTile({required this.asset});

  @override
  Widget build(BuildContext context) {
    final daysUntil = asset.warrantyExpirationDate != null
        ? asset.warrantyExpirationDate!.difference(DateTime.now()).inDays
        : null;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        child: Icon(
          Icons.verified_user_outlined,
          color: Theme.of(context).colorScheme.onTertiaryContainer,
        ),
      ),
      title: Text(asset.name),
      subtitle: Text(
        daysUntil != null
            ? 'Warranty expires ${formatDaysUntil(daysUntil).toLowerCase()}'
            : 'No warranty info',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/assets/${asset.id}'),
    );
  }
}

class _ServiceRecordTile extends StatelessWidget {
  final ServiceRecord record;

  const _ServiceRecordTile({required this.record});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: Icon(
          Icons.build_outlined,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
      title: Text(record.title),
      subtitle: Text(formatDate(record.date)),
      trailing: record.cost != null
          ? Text(
              formatCurrency(record.cost!),
              style: Theme.of(context).textTheme.bodyMedium,
            )
          : null,
    );
  }
}

class _PropertyStats extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetCount = ref.watch(assetCountProvider);
    final overdueCount = ref.watch(overdueTaskCountProvider);
    final totalSpending = ref.watch(totalSpendingProvider(12));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              icon: Icons.inventory_2_outlined,
              label: 'Assets',
              value: assetCount.when(
                data: (count) => count.toString(),
                loading: () => '-',
                error: (_, __) => '-',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              icon: Icons.warning_outlined,
              label: 'Overdue',
              value: overdueCount.when(
                data: (count) => count.toString(),
                loading: () => '-',
                error: (_, __) => '-',
              ),
              isWarning: (overdueCount.valueOrNull ?? 0) > 0,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              icon: Icons.payments_outlined,
              label: '12mo Spend',
              value: totalSpending.when(
                data: (amount) => formatCurrency(amount),
                loading: () => '-',
                error: (_, __) => '-',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isWarning;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: isWarning
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isWarning ? Theme.of(context).colorScheme.error : null,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
