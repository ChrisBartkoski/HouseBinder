import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../../domain/enums/enums.dart';
import '../../widgets/common_widgets.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  final String? taskId;

  const TaskFormScreen({super.key, this.taskId});

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _customDaysController = TextEditingController();
  final _costController = TextEditingController();
  final _timeController = TextEditingController();
  final _notesController = TextEditingController();

  TaskFrequency _frequency = TaskFrequency.monthly;
  AssetCategory? _category;
  Season? _season;
  DateTime? _nextDueDate;
  bool _reminderEnabled = true;
  int _reminderDaysBefore = 3;
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.taskId != null;
    if (_isEditing) {
      _loadTask();
    }
  }

  Future<void> _loadTask() async {
    final task = await ref.read(taskProvider(widget.taskId!).future);
    if (task != null && mounted) {
      setState(() {
        _titleController.text = task.title;
        _descriptionController.text = task.description ?? '';
        _instructionsController.text = task.instructions ?? '';
        _frequency = task.frequencyEnum;
        _customDaysController.text = task.customIntervalDays?.toString() ?? '';
        _category = task.categoryEnum;
        _season = task.seasonEnum;
        _nextDueDate = task.nextDueDate;
        _costController.text = task.estimatedCost?.toString() ?? '';
        _timeController.text = task.estimatedTimeMinutes?.toString() ?? '';
        _notesController.text = task.notes ?? '';
        _reminderEnabled = task.reminderEnabled;
        _reminderDaysBefore = task.reminderDaysBefore;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _instructionsController.dispose();
    _customDaysController.dispose();
    _costController.dispose();
    _timeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _nextDueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() => _nextDueDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final customDays = _frequency == TaskFrequency.custom
          ? int.tryParse(_customDaysController.text)
          : null;
      final cost = _costController.text.isNotEmpty
          ? double.tryParse(_costController.text)
          : null;
      final time = _timeController.text.isNotEmpty
          ? int.tryParse(_timeController.text)
          : null;

      if (_isEditing) {
        await ref.read(taskNotifierProvider.notifier).updateTask(
          id: widget.taskId!,
          title: _titleController.text,
          description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
          instructions: _instructionsController.text.isEmpty ? null : _instructionsController.text,
          frequency: _frequency,
          customIntervalDays: customDays,
          category: _category,
          season: _season,
          nextDueDate: _nextDueDate,
          estimatedCost: cost,
          estimatedTimeMinutes: time,
          notes: _notesController.text.isEmpty ? null : _notesController.text,
          reminderEnabled: _reminderEnabled,
          reminderDaysBefore: _reminderDaysBefore,
        );
      } else {
        await ref.read(taskNotifierProvider.notifier).createTask(
              title: _titleController.text,
              description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
              instructions: _instructionsController.text.isEmpty ? null : _instructionsController.text,
              frequency: _frequency,
              customIntervalDays: customDays,
              category: _category,
              season: _season,
              nextDueDate: _nextDueDate,
              estimatedCost: cost,
              estimatedTimeMinutes: time,
              notes: _notesController.text.isEmpty ? null : _notesController.text,
              reminderEnabled: _reminderEnabled,
              reminderDaysBefore: _reminderDaysBefore,
            );
      }

      if (mounted) {
        context.pop();
        showSuccessSnackbar(context, _isEditing ? 'Task updated' : 'Task added');
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
        title: Text(_isEditing ? 'Edit Task' : 'Add Task'),
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
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Name *',
                hintText: 'e.g., Replace furnace filter',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task name is required';
                }
                return null;
              },
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),

            // Frequency
            DropdownButtonFormField<TaskFrequency>(
              value: _frequency,
              decoration: const InputDecoration(
                labelText: 'Frequency *',
              ),
              items: TaskFrequency.values.map((freq) {
                return DropdownMenuItem(
                  value: freq,
                  child: Text(freq.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _frequency = value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Custom interval (only if custom frequency)
            if (_frequency == TaskFrequency.custom)
              TextFormField(
                controller: _customDaysController,
                decoration: const InputDecoration(
                  labelText: 'Custom Interval (days) *',
                ),
                keyboardType: TextInputType.number,
                validator: _frequency == TaskFrequency.custom
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter interval in days';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      }
                    : null,
              ),
            if (_frequency == TaskFrequency.custom) const SizedBox(height: 16),

            // Due Date
            InkWell(
              onTap: _selectDueDate,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'First Due Date',
                  suffixIcon: _nextDueDate != null
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() => _nextDueDate = null),
                        )
                      : const Icon(Icons.calendar_today),
                ),
                child: Text(
                  _nextDueDate != null ? formatDate(_nextDueDate!) : 'Select date',
                  style: TextStyle(
                    color: _nextDueDate != null
                        ? Theme.of(context).textTheme.bodyLarge?.color
                        : Theme.of(context).hintColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category
            DropdownButtonFormField<AssetCategory?>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'Category (optional)',
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('None'),
                ),
                ...AssetCategory.values.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat.displayName),
                  );
                }),
              ],
              onChanged: (value) {
                setState(() => _category = value);
              },
            ),
            const SizedBox(height: 16),

            // Season
            DropdownButtonFormField<Season?>(
              value: _season,
              decoration: const InputDecoration(
                labelText: 'Season (optional)',
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Any'),
                ),
                ...Season.values.map((season) {
                  return DropdownMenuItem(
                    value: season,
                    child: Text(season.displayName),
                  );
                }),
              ],
              onChanged: (value) {
                setState(() => _season = value);
              },
            ),
            const SizedBox(height: 24),

            // Description
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Brief description of the task...',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _instructionsController,
              decoration: const InputDecoration(
                labelText: 'Instructions',
                hintText: 'Step-by-step instructions...',
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),

            // Estimates
            Text(
              'Estimates',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      labelText: 'Time (minutes)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _costController,
                    decoration: const InputDecoration(
                      labelText: 'Cost',
                      prefixText: '\$ ',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Reminder
            Text(
              'Reminder',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            SwitchListTile(
              title: const Text('Enable Reminder'),
              value: _reminderEnabled,
              onChanged: (value) {
                setState(() => _reminderEnabled = value);
              },
              contentPadding: EdgeInsets.zero,
            ),

            if (_reminderEnabled)
              DropdownButtonFormField<int>(
                value: _reminderDaysBefore,
                decoration: const InputDecoration(
                  labelText: 'Remind me before due date',
                ),
                items: [1, 2, 3, 5, 7, 14].map((days) {
                  return DropdownMenuItem(
                    value: days,
                    child: Text('$days day${days > 1 ? 's' : ''} before'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _reminderDaysBefore = value);
                  }
                },
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
