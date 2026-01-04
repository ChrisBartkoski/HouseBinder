import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../../domain/enums/enums.dart';
import '../../widgets/common_widgets.dart';

class AssetFormScreen extends ConsumerStatefulWidget {
  final String? assetId;

  const AssetFormScreen({super.key, this.assetId});

  @override
  ConsumerState<AssetFormScreen> createState() => _AssetFormScreenState();
}

class _AssetFormScreenState extends ConsumerState<AssetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _modelController = TextEditingController();
  final _serialController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  AssetCategory _category = AssetCategory.other;
  DateTime? _installDate;
  DateTime? _purchaseDate;
  DateTime? _warrantyExpiration;
  bool _isLoading = false;
  bool _isEditing = false;
  Asset? _existingAsset;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.assetId != null;
    if (_isEditing) {
      _loadAsset();
    }
  }

  Future<void> _loadAsset() async {
    final asset = await ref.read(assetProvider(widget.assetId!).future);
    if (asset != null && mounted) {
      setState(() {
        _existingAsset = asset;
        _nameController.text = asset.name;
        _category = asset.categoryEnum;
        _locationController.text = asset.locationRoom ?? '';
        _manufacturerController.text = asset.manufacturer ?? '';
        _modelController.text = asset.model ?? '';
        _serialController.text = asset.serialNumber ?? '';
        _priceController.text = asset.purchasePrice?.toString() ?? '';
        _notesController.text = asset.notes ?? '';
        _installDate = asset.installDate;
        _purchaseDate = asset.purchaseDate;
        _warrantyExpiration = asset.warrantyExpirationDate;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _manufacturerController.dispose();
    _modelController.dispose();
    _serialController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(String field) async {
    DateTime? currentDate;
    switch (field) {
      case 'install':
        currentDate = _installDate;
        break;
      case 'purchase':
        currentDate = _purchaseDate;
        break;
      case 'warranty':
        currentDate = _warrantyExpiration;
        break;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        switch (field) {
          case 'install':
            _installDate = picked;
            break;
          case 'purchase':
            _purchaseDate = picked;
            break;
          case 'warranty':
            _warrantyExpiration = picked;
            break;
        }
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final price = _priceController.text.isNotEmpty
          ? double.tryParse(_priceController.text)
          : null;

      if (_isEditing && _existingAsset != null) {
        await ref.read(assetNotifierProvider.notifier).updateAsset(
              id: widget.assetId!,
              name: _nameController.text,
              category: _category,
              locationRoom: _locationController.text.isEmpty ? null : _locationController.text,
              manufacturer: _manufacturerController.text.isEmpty ? null : _manufacturerController.text,
              model: _modelController.text.isEmpty ? null : _modelController.text,
              serialNumber: _serialController.text.isEmpty ? null : _serialController.text,
              purchasePrice: price,
              notes: _notesController.text.isEmpty ? null : _notesController.text,
              installDate: _installDate,
              purchaseDate: _purchaseDate,
              warrantyExpirationDate: _warrantyExpiration,
            );
      } else {
        await ref.read(assetNotifierProvider.notifier).createAsset(
              name: _nameController.text,
              category: _category,
              locationRoom: _locationController.text.isEmpty ? null : _locationController.text,
              manufacturer: _manufacturerController.text.isEmpty ? null : _manufacturerController.text,
              model: _modelController.text.isEmpty ? null : _modelController.text,
              serialNumber: _serialController.text.isEmpty ? null : _serialController.text,
              purchasePrice: price,
              notes: _notesController.text.isEmpty ? null : _notesController.text,
              installDate: _installDate,
              purchaseDate: _purchaseDate,
              warrantyExpirationDate: _warrantyExpiration,
            );
      }

      if (mounted) {
        context.pop();
        showSuccessSnackbar(context, _isEditing ? 'Asset updated' : 'Asset added');
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Asset' : 'Add Asset'),
        actions: [
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
            // Basic Info
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name *',
                hintText: 'e.g., Basement Furnace',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            // Category
            DropdownButtonFormField<AssetCategory>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'Category *',
              ),
              items: AssetCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _category = value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Location
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location/Room',
                hintText: 'e.g., Basement, Kitchen',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 24),

            // Manufacturer Info Section
            Text(
              'Manufacturer Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _manufacturerController,
              decoration: const InputDecoration(
                labelText: 'Manufacturer',
                hintText: 'e.g., Carrier, GE, Samsung',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _modelController,
              decoration: const InputDecoration(
                labelText: 'Model Number',
                hintText: 'e.g., 24ACC636A003',
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _serialController,
              decoration: const InputDecoration(
                labelText: 'Serial Number',
              ),
            ),
            const SizedBox(height: 24),

            // Dates Section
            Text(
              'Dates',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            _DatePickerField(
              label: 'Install Date',
              value: _installDate,
              onTap: () => _selectDate('install'),
              onClear: () => setState(() => _installDate = null),
            ),
            const SizedBox(height: 16),

            _DatePickerField(
              label: 'Purchase Date',
              value: _purchaseDate,
              onTap: () => _selectDate('purchase'),
              onClear: () => setState(() => _purchaseDate = null),
            ),
            const SizedBox(height: 16),

            _DatePickerField(
              label: 'Warranty Expiration',
              value: _warrantyExpiration,
              onTap: () => _selectDate('warranty'),
              onClear: () => setState(() => _warrantyExpiration = null),
            ),
            const SizedBox(height: 24),

            // Cost Section
            Text(
              'Cost',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Purchase Price',
                prefixText: '\$ ',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 24),

            // Notes Section
            Text(
              'Notes',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                hintText: 'Any additional information...',
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final VoidCallback onClear;

  const _DatePickerField({
    required this.label,
    required this.value,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: value != null
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: onClear,
                )
              : const Icon(Icons.calendar_today),
        ),
        child: Text(
          value != null ? formatDate(value!) : 'Select date',
          style: TextStyle(
            color: value != null
                ? Theme.of(context).textTheme.bodyLarge?.color
                : Theme.of(context).hintColor,
          ),
        ),
      ),
    );
  }
}
