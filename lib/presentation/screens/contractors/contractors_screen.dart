import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../../domain/enums/enums.dart';
import '../../widgets/common_widgets.dart';

class ContractorsScreen extends ConsumerStatefulWidget {
  const ContractorsScreen({super.key});

  @override
  ConsumerState<ContractorsScreen> createState() => _ContractorsScreenState();
}

class _ContractorsScreenState extends ConsumerState<ContractorsScreen> {
  TradeType? _selectedTrade;

  @override
  Widget build(BuildContext context) {
    final contractorsAsync = ref.watch(contractorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contractors'),
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
                    selected: _selectedTrade == null,
                    onSelected: (_) {
                      setState(() => _selectedTrade = null);
                    },
                  ),
                  const SizedBox(width: 8),
                  ...TradeType.values.take(8).map((trade) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(trade.displayName),
                        selected: _selectedTrade == trade,
                        onSelected: (_) {
                          setState(() => _selectedTrade = trade);
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Contractors list
          Expanded(
            child: contractorsAsync.when(
              loading: () => const LoadingState(),
              error: (error, _) => ErrorState(message: error.toString()),
              data: (contractors) {
                var filtered = contractors;
                if (_selectedTrade != null) {
                  filtered = contractors.where((c) => c.tradeTypeEnum == _selectedTrade).toList();
                }

                if (filtered.isEmpty) {
                  if (contractors.isEmpty) {
                    return EmptyState(
                      icon: Icons.people_outline,
                      title: 'No Contractors',
                      subtitle: 'Add your trusted service providers',
                      action: FilledButton.icon(
                        onPressed: () => context.push('/contractors/new'),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Contractor'),
                      ),
                    );
                  }
                  return const EmptyState(
                    icon: Icons.search_off,
                    title: 'No Results',
                    subtitle: 'Try a different filter',
                  );
                }

                // Separate preferred contractors
                final preferred = filtered.where((c) => c.isPreferred).toList();
                final others = filtered.where((c) => !c.isPreferred).toList();

                return ListView(
                  padding: const EdgeInsets.only(bottom: 100),
                  children: [
                    if (preferred.isNotEmpty) ...[
                      const SectionHeader(title: 'Preferred'),
                      ...preferred.map((c) => _ContractorTile(contractor: c)),
                    ],
                    if (others.isNotEmpty) ...[
                      SectionHeader(title: preferred.isNotEmpty ? 'Others' : 'All Contractors'),
                      ...others.map((c) => _ContractorTile(contractor: c)),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/contractors/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add Contractor'),
      ),
    );
  }
}

class _ContractorTile extends ConsumerWidget {
  final Contractor contractor;

  const _ContractorTile({required this.contractor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: contractor.isPreferred
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Icon(
          _getTradeIcon(contractor.tradeTypeEnum),
          color: contractor.isPreferred
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onSurfaceVariant,
          size: 20,
        ),
      ),
      title: Row(
        children: [
          Expanded(child: Text(contractor.displayName)),
          if (contractor.isPreferred)
            Icon(
              Icons.star,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
        ],
      ),
      subtitle: Text(contractor.tradeTypeEnum.displayName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (contractor.phone != null)
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () => _makeCall(contractor.phone!),
              tooltip: 'Call',
            ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => context.push('/contractors/${contractor.id}'),
    );
  }

  IconData _getTradeIcon(TradeType? trade) {
    switch (trade) {
      case TradeType.hvac:
        return Icons.ac_unit;
      case TradeType.plumber:
        return Icons.plumbing;
      case TradeType.electrician:
        return Icons.electrical_services;
      case TradeType.generalContractor:
        return Icons.engineering;
      case TradeType.roofer:
        return Icons.roofing;
      case TradeType.landscaper:
        return Icons.grass;
      case TradeType.painter:
        return Icons.format_paint;
      case TradeType.carpenter:
        return Icons.carpenter;
      case TradeType.handyman:
        return Icons.handyman;
      default:
        return Icons.person;
    }
  }

  Future<void> _makeCall(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
