import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../widgets/common_widgets.dart';

class ServiceRecordFormScreen extends ConsumerStatefulWidget {
  final String? recordId;

  const ServiceRecordFormScreen({super.key, this.recordId});

  @override
  ConsumerState<ServiceRecordFormScreen> createState() => _ServiceRecordFormScreenState();
}

class _ServiceRecordFormScreenState extends ConsumerState<ServiceRecordFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _date = DateTime.now();
  String? _contractorId;
  List<String> _selectedAssetIds = [];
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.recordId != null;
    if (_isEditing) {
      _loadRecord();
    }
  }

  Future<void> _loadRecord() async {
    final record = await ref.read(serviceRecordProvider(widget.recordId!).future);
    if (record != null && mounted) {
      setState(() {
        _titleController.text = record.title;
        _descriptionController.text = record.description ?? '';
        _costController.text = record.cost?.toString() ?? '';
        _notesController.text = record.notes ?? '';
        _date = record.date;
        _contractorId = record.contractorId;
        _selectedAssetIds = record.assetIdsList;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final cost = _costController.text.isNotEmpty
          ? double.tryParse(_costController.text)
          : null;

      if (_isEditing) {
        await ref.read(serviceRecordNotifierProvider.notifier).updateServiceRecord(
          id: widget.recordId!,
          date: _date,
          title: _titleController.text,
          description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
          cost: cost,
          contractorId: _contractorId,
          assetIds: _selectedAssetIds,
          notes: _notesController.text.isEmpty ? null : _notesController.text,
        );
      } else {
        await ref.read(serviceRecordNotifierProvider.notifier).createServiceRecord(
              date: _date,
              title: _titleController.text,
              description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
              cost: cost,
              contractorId: _contractorId,
              assetIds: _selectedAssetIds,
              notes: _notesController.text.isEmpty ? null : _notesController.text,
            );
      }

      if (mounted) {
        context.pop();
        showSuccessSnackbar(context, _isEditing ? 'Record updated' : 'Service logged');
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackbar(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final contractorsAsync = ref.watch(contractorsProvider);
    final assetsAsync = ref.watch(assetsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Service Record' : 'Log Service'),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                final confirm = await showConfirmDialog(
                  context,
                  title: 'Delete Record',
                  message: 'Are you sure you want to delete this record?',
                  confirmText: 'Delete',
                  isDestructive: true,
                );
                if (confirm && mounted) {
                  await ref.read(serviceRecordNotifierProvider.notifier)
                      .deleteServiceRecord(widget.recordId!);
                  if (!mounted) return;
                  context.pop();
                  showSuccessSnackbar(context, 'Record deleted');
                }
              },
            ),
          TextButton(
            onPressed: _isLoading ? null : _save,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title *',
                hintText: 'e.g., Furnace tune-up',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title is required';
                }
                return null;
              },
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),

            // Date
            InkWell(
              onTap: _selectDate,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date *',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(formatDate(_date)),
              ),
            ),
            const SizedBox(height: 16),

            // Cost
            TextFormField(
              controller: _costController,
              decoration: const InputDecoration(
                labelText: 'Cost',
                prefixText: '\$ ',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),

            // Contractor
            contractorsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const SizedBox.shrink(),
              data: (contractors) {
                if (contractors.isEmpty) return const SizedBox.shrink();
                return DropdownButtonFormField<String?>(
                  value: _contractorId,
                  decoration: const InputDecoration(
                    labelText: 'Contractor',
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('None'),
                    ),
                    ...contractors.map((c) {
                      return DropdownMenuItem(
                        value: c.id,
                        child: Text(c.displayName),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() => _contractorId = value);
                  },
                );
              },
            ),
            const SizedBox(height: 16),

            // Related Assets
            assetsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const SizedBox.shrink(),
              data: (assets) {
                if (assets.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Related Assets',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: assets.map((asset) {
                        final isSelected = _selectedAssetIds.contains(asset.id);
                        return FilterChip(
                          label: Text(asset.name),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedAssetIds.add(asset.id);
                              } else {
                                _selectedAssetIds.remove(asset.id);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'What was done...',
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),

            // Notes
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                hintText: 'Any additional notes...',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
