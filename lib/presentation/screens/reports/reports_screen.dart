import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../application/services/pdf_service.dart';
import '../../widgets/common_widgets.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  bool _includeAssets = true;
  bool _includeTasks = true;
  bool _includeServiceHistory = true;
  bool _includeContractors = true;
  bool _includeDocumentIndex = true;
  bool _includeWarranties = true;
  int _serviceHistoryMonths = 12;
  bool _isGenerating = false;

  @override
  Widget build(BuildContext context) {
    final propertyAsync = ref.watch(currentPropertyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Report'),
      ),
      body: propertyAsync.when(
        loading: () => const LoadingState(),
        error: (error, _) => ErrorState(message: error.toString()),
        data: (property) {
          if (property == null) {
            return const EmptyState(
              icon: Icons.home_work_outlined,
              title: 'No Property Selected',
              subtitle: 'Select a property first',
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Report type selection
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'House Binder Report',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Generate a comprehensive PDF report for ${property.name}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Sections to include
              const SectionHeader(title: 'Include Sections'),
              Card(
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: const Text('Asset Inventory'),
                      subtitle: const Text('All appliances and systems'),
                      value: _includeAssets,
                      onChanged: (value) {
                        setState(() => _includeAssets = value ?? true);
                      },
                    ),
                    const Divider(height: 1),
                    CheckboxListTile(
                      title: const Text('Warranty Information'),
                      subtitle: const Text('Active and expiring warranties'),
                      value: _includeWarranties,
                      onChanged: (value) {
                        setState(() => _includeWarranties = value ?? true);
                      },
                    ),
                    const Divider(height: 1),
                    CheckboxListTile(
                      title: const Text('Maintenance Tasks'),
                      subtitle: const Text('Upcoming and overdue tasks'),
                      value: _includeTasks,
                      onChanged: (value) {
                        setState(() => _includeTasks = value ?? true);
                      },
                    ),
                    const Divider(height: 1),
                    CheckboxListTile(
                      title: const Text('Service History'),
                      subtitle: const Text('Past service and repairs'),
                      value: _includeServiceHistory,
                      onChanged: (value) {
                        setState(() => _includeServiceHistory = value ?? true);
                      },
                    ),
                    if (_includeServiceHistory) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: DropdownButtonFormField<int>(
                          value: _serviceHistoryMonths,
                          decoration: const InputDecoration(
                            labelText: 'Include history from',
                          ),
                          items: const [
                            DropdownMenuItem(value: 6, child: Text('Last 6 months')),
                            DropdownMenuItem(value: 12, child: Text('Last 12 months')),
                            DropdownMenuItem(value: 24, child: Text('Last 24 months')),
                            DropdownMenuItem(value: -1, child: Text('All time')),
                          ],
                          onChanged: (value) {
                            setState(() => _serviceHistoryMonths = value ?? 12);
                          },
                        ),
                      ),
                    ],
                    const Divider(height: 1),
                    CheckboxListTile(
                      title: const Text('Contractors'),
                      subtitle: const Text('Service provider contact info'),
                      value: _includeContractors,
                      onChanged: (value) {
                        setState(() => _includeContractors = value ?? true);
                      },
                    ),
                    const Divider(height: 1),
                    CheckboxListTile(
                      title: const Text('Document Index'),
                      subtitle: const Text('List of stored documents'),
                      value: _includeDocumentIndex,
                      onChanged: (value) {
                        setState(() => _includeDocumentIndex = value ?? true);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Generate button
              FilledButton.icon(
                onPressed: _isGenerating ? null : _generateReport,
                icon: _isGenerating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.picture_as_pdf),
                label: Text(_isGenerating ? 'Generating...' : 'Generate PDF Report'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 16),

              // Info text
              Text(
                'The report will be saved and can be shared with buyers, insurers, or contractors.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _generateReport() async {
    setState(() => _isGenerating = true);

    try {
      final pdfService = PdfService(ref);
      final path = await pdfService.generateHouseBinderReport(
        includeAssets: _includeAssets,
        includeWarranties: _includeWarranties,
        includeTasks: _includeTasks,
        includeServiceHistory: _includeServiceHistory,
        serviceHistoryMonths: _serviceHistoryMonths,
        includeContractors: _includeContractors,
        includeDocumentIndex: _includeDocumentIndex,
      );

      if (mounted) {
        showSuccessSnackbar(context, 'Report saved to: $path');
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackbar(context, 'Failed to generate report: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }
}
