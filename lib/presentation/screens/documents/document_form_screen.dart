import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../../domain/enums/enums.dart';
import '../../widgets/common_widgets.dart';

class DocumentFormScreen extends ConsumerStatefulWidget {
  final String? documentId;

  const DocumentFormScreen({super.key, this.documentId});

  @override
  ConsumerState<DocumentFormScreen> createState() => _DocumentFormScreenState();
}

class _DocumentFormScreenState extends ConsumerState<DocumentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();

  DocumentCategory _category = DocumentCategory.other;
  String? _filePath;
  String? _linkedAssetId;
  DateTime? _expirationDate;
  bool _isLoading = false;
  bool _isEditing = false;
  Document? _existingDocument;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.documentId != null;
    if (_isEditing) {
      _loadDocument();
    }
  }

  Future<void> _loadDocument() async {
    final document = await ref.read(documentProvider(widget.documentId!).future);
    if (document != null && mounted) {
      setState(() {
        _existingDocument = document;
        _titleController.text = document.title;
        _category = document.categoryEnum;
        _filePath = document.filePath;
        _linkedAssetId = document.linkedAssetId;
        _expirationDate = document.expirationDate;
        _notesController.text = document.notes ?? '';
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'gif', 'doc', 'docx', 'txt'],
    );

    if (result != null && result.files.single.path != null) {
      final sourcePath = result.files.single.path!;
      final fileName = result.files.single.name;

      // Copy file to app documents directory
      final appDir = await getApplicationDocumentsDirectory();
      final documentsDir = Directory(p.join(appDir.path, 'HouseBinder', 'documents'));
      if (!await documentsDir.exists()) {
        await documentsDir.create(recursive: true);
      }

      final destPath = p.join(documentsDir.path, '${DateTime.now().millisecondsSinceEpoch}_$fileName');
      await File(sourcePath).copy(destPath);

      setState(() {
        _filePath = destPath;
        if (_titleController.text.isEmpty) {
          _titleController.text = p.basenameWithoutExtension(fileName);
        }
      });
    }
  }

  Future<void> _selectExpirationDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _expirationDate ?? DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 20)),
    );
    if (picked != null) {
      setState(() => _expirationDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_filePath == null && !_isEditing) {
      showErrorSnackbar(context, 'Please select a file');
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isEditing && _existingDocument != null) {
        await ref.read(documentNotifierProvider.notifier).updateDocument(
          id: _existingDocument!.id,
          title: _titleController.text,
          category: _category,
          filePath: _filePath ?? _existingDocument!.filePath,
          linkedAssetId: _linkedAssetId,
          expirationDate: _expirationDate,
          notes: _notesController.text.isEmpty ? null : _notesController.text,
        );
      } else {
        await ref.read(documentNotifierProvider.notifier).createDocument(
              title: _titleController.text,
              category: _category,
              filePath: _filePath!,
              linkedAssetId: _linkedAssetId,
              expirationDate: _expirationDate,
              notes: _notesController.text.isEmpty ? null : _notesController.text,
            );
      }

      if (mounted) {
        context.pop();
        showSuccessSnackbar(context, _isEditing ? 'Document updated' : 'Document added');
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
    final assetsAsync = ref.watch(assetsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Document' : 'Add Document'),
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
            // File picker
            if (!_isEditing || _filePath == null)
              OutlinedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.upload_file),
                label: const Text('Select File'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                ),
              ),

            if (_filePath != null)
              Card(
                child: ListTile(
                  leading: Icon(
                    _getFileIcon(_filePath!),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(p.basename(_filePath!)),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() => _filePath = null),
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title *',
                hintText: 'e.g., Furnace Manual',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title is required';
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            // Category
            DropdownButtonFormField<DocumentCategory>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'Category *',
              ),
              items: DocumentCategory.values.map((category) {
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

            // Linked Asset
            assetsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const SizedBox.shrink(),
              data: (assets) {
                if (assets.isEmpty) return const SizedBox.shrink();
                return DropdownButtonFormField<String?>(
                  value: _linkedAssetId,
                  decoration: const InputDecoration(
                    labelText: 'Linked Asset (optional)',
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('None'),
                    ),
                    ...assets.map((asset) {
                      return DropdownMenuItem(
                        value: asset.id,
                        child: Text(asset.name),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() => _linkedAssetId = value);
                  },
                );
              },
            ),
            const SizedBox(height: 16),

            // Expiration Date
            InkWell(
              onTap: _selectExpirationDate,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Expiration Date (optional)',
                  suffixIcon: _expirationDate != null
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() => _expirationDate = null),
                        )
                      : const Icon(Icons.calendar_today),
                ),
                child: Text(
                  _expirationDate != null ? formatDate(_expirationDate!) : 'Select date',
                  style: TextStyle(
                    color: _expirationDate != null
                        ? Theme.of(context).textTheme.bodyLarge?.color
                        : Theme.of(context).hintColor,
                  ),
                ),
              ),
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
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  IconData _getFileIcon(String path) {
    final ext = p.extension(path).toLowerCase();
    switch (ext) {
      case '.pdf':
        return Icons.picture_as_pdf;
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.gif':
        return Icons.image;
      case '.doc':
      case '.docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }
}
