import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../../domain/enums/enums.dart';
import '../../widgets/common_widgets.dart';

class ContractorFormScreen extends ConsumerStatefulWidget {
  final String? contractorId;

  const ContractorFormScreen({super.key, this.contractorId});

  @override
  ConsumerState<ContractorFormScreen> createState() => _ContractorFormScreenState();
}

class _ContractorFormScreenState extends ConsumerState<ContractorFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _websiteController = TextEditingController();
  final _notesController = TextEditingController();

  TradeType _tradeType = TradeType.other;
  bool _isPreferred = false;
  bool _isLoading = false;
  bool _isEditing = false;
  Contractor? _existingContractor;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.contractorId != null;
    if (_isEditing) {
      _loadContractor();
    }
  }

  Future<void> _loadContractor() async {
    final contractor = await ref.read(contractorProvider(widget.contractorId!).future);
    if (contractor != null && mounted) {
      setState(() {
        _existingContractor = contractor;
        _nameController.text = contractor.name;
        _companyController.text = contractor.companyName ?? '';
        _tradeType = contractor.tradeTypeEnum;
        _phoneController.text = contractor.phone ?? '';
        _emailController.text = contractor.email ?? '';
        _addressController.text = contractor.address ?? '';
        _websiteController.text = contractor.website ?? '';
        _notesController.text = contractor.notes ?? '';
        _isPreferred = contractor.isPreferred;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (_isEditing && _existingContractor != null) {
        await ref.read(contractorNotifierProvider.notifier).updateContractor(
              id: widget.contractorId!,
              name: _nameController.text,
              companyName: _companyController.text.isEmpty ? null : _companyController.text,
              tradeType: _tradeType,
              phone: _phoneController.text.isEmpty ? null : _phoneController.text,
              email: _emailController.text.isEmpty ? null : _emailController.text,
              address: _addressController.text.isEmpty ? null : _addressController.text,
              website: _websiteController.text.isEmpty ? null : _websiteController.text,
              notes: _notesController.text.isEmpty ? null : _notesController.text,
              isPreferred: _isPreferred,
            );
      } else {
        await ref.read(contractorNotifierProvider.notifier).createContractor(
              name: _nameController.text,
              companyName: _companyController.text.isEmpty ? null : _companyController.text,
              tradeType: _tradeType,
              phone: _phoneController.text.isEmpty ? null : _phoneController.text,
              email: _emailController.text.isEmpty ? null : _emailController.text,
              address: _addressController.text.isEmpty ? null : _addressController.text,
              website: _websiteController.text.isEmpty ? null : _websiteController.text,
              notes: _notesController.text.isEmpty ? null : _notesController.text,
              isPreferred: _isPreferred,
            );
      }

      if (mounted) {
        context.pop();
        showSuccessSnackbar(context, _isEditing ? 'Contractor updated' : 'Contractor added');
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
        title: Text(_isEditing ? 'Edit Contractor' : 'Add Contractor'),
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
            // Name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name *',
                hintText: 'Contact person name',
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

            // Company
            TextFormField(
              controller: _companyController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
                hintText: 'Business name (optional)',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            // Trade Type
            DropdownButtonFormField<TradeType>(
              value: _tradeType,
              decoration: const InputDecoration(
                labelText: 'Trade *',
              ),
              items: TradeType.values.map((trade) {
                return DropdownMenuItem(
                  value: trade,
                  child: Text(trade.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _tradeType = value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Preferred switch
            SwitchListTile(
              title: const Text('Preferred Contractor'),
              subtitle: const Text('Mark as your go-to for this trade'),
              value: _isPreferred,
              onChanged: (value) {
                setState(() => _isPreferred = value);
              },
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),

            // Contact Info Section
            Text(
              'Contact Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.location_on),
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _websiteController,
              decoration: const InputDecoration(
                labelText: 'Website',
                prefixIcon: Icon(Icons.language),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 24),

            // Notes
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
                hintText: 'Any additional notes...',
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
