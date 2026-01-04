import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../domain/entities/entities.dart';
import '../../widgets/common_widgets.dart';

class ServiceHistoryScreen extends ConsumerWidget {
  const ServiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(serviceRecordsProvider);
    final totalSpending = ref.watch(totalSpendingProvider(12));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: recordsAsync.when(
        loading: () => const LoadingState(),
        error: (error, _) => ErrorState(message: error.toString()),
        data: (records) {
          if (records.isEmpty) {
            return EmptyState(
              icon: Icons.history_outlined,
              title: 'No Service Records',
              subtitle: 'Log your first service or repair',
              action: FilledButton.icon(
                onPressed: () => context.push('/history/new'),
                icon: const Icon(Icons.add),
                label: const Text('Log Service'),
              ),
            );
          }

          // Group records by month/year
          final grouped = <String, List<ServiceRecord>>{};
          for (final record in records) {
            final key = '${record.date.year}-${record.date.month.toString().padLeft(2, '0')}';
            grouped.putIfAbsent(key, () => []).add(record);
          }

          return Column(
            children: [
              // Stats summary
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              records.length.toString(),
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            Text(
                              'Total Records',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                            ),
                          ],
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        Column(
                          children: [
                            totalSpending.when(
                              data: (amount) => Text(
                                formatCurrency(amount),
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              loading: () => const CircularProgressIndicator(),
                              error: (_, __) => const Text('-'),
                            ),
                            Text(
                              'Last 12 Months',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Records list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: grouped.length,
                  itemBuilder: (context, index) {
                    final key = grouped.keys.elementAt(index);
                    final monthRecords = grouped[key]!;
                    final date = DateTime.parse('$key-01');
                    final monthTotal = monthRecords.fold(0.0, (sum, r) => sum + (r.cost ?? 0));

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: _formatMonthYear(date),
                          trailing: Text(
                            formatCurrency(monthTotal),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        ...monthRecords.map((record) => _ServiceRecordTile(record: record)),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/history/new'),
        icon: const Icon(Icons.add),
        label: const Text('Log Service'),
      ),
    );
  }

  String _formatMonthYear(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}

class _ServiceRecordTile extends ConsumerWidget {
  final ServiceRecord record;

  const _ServiceRecordTile({required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        child: Icon(
          Icons.build_outlined,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          size: 20,
        ),
      ),
      title: Text(record.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formatDate(record.date)),
          if (record.description != null)
            Text(
              record.description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
        ],
      ),
      trailing: record.cost != null
          ? Text(
              formatCurrency(record.cost!),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            )
          : null,
      onTap: () => context.push('/history/${record.id}/edit'),
    );
  }
}
