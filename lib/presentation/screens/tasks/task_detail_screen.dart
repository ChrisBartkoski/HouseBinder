import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../widgets/common_widgets.dart';

class TaskDetailScreen extends ConsumerWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskAsync = ref.watch(taskProvider(taskId));

    return taskAsync.when(
      loading: () => const Scaffold(body: LoadingState()),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(message: error.toString()),
      ),
      data: (task) {
        if (task == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const ErrorState(message: 'Task not found'),
          );
        }

        final isOverdue = task.isOverdue;

        return Scaffold(
          appBar: AppBar(
            title: Text(task.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => context.push('/tasks/$taskId/edit'),
                tooltip: 'Edit',
              ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'delete') {
                    final confirm = await showConfirmDialog(
                      context,
                      title: 'Delete Task',
                      message: 'Are you sure you want to delete "${task.title}"?',
                      confirmText: 'Delete',
                      isDestructive: true,
                    );
                    if (confirm && context.mounted) {
                      await ref.read(taskNotifierProvider.notifier).deleteTask(taskId);
                      if (context.mounted) {
                        context.pop();
                        showSuccessSnackbar(context, 'Task deleted');
                      }
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red),
                        SizedBox(width: 12),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              // Status Banner
              if (isOverdue)
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'This task is overdue!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onErrorContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Quick Actions
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () async {
                          await ref.read(taskNotifierProvider.notifier).completeTask(taskId);
                          if (context.mounted) {
                            showSuccessSnackbar(context, 'Task completed');
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Complete'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () async {
                        await ref.read(taskNotifierProvider.notifier).snoozeTask(taskId, 7);
                        if (context.mounted) {
                          showSuccessSnackbar(context, 'Task snoozed for 1 week');
                        }
                      },
                      icon: const Icon(Icons.snooze),
                      label: const Text('Snooze'),
                    ),
                  ],
                ),
              ),

              // Details
              const SectionHeader(title: 'Details'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    InfoRow(
                      icon: Icons.repeat,
                      label: 'Frequency',
                      value: task.frequencyEnum.displayName,
                    ),
                    if (task.nextDueDate != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.calendar_today,
                        label: 'Due Date',
                        value: formatDate(task.nextDueDate!),
                      ),
                    ],
                    if (task.categoryEnum != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.category,
                        label: 'Category',
                        value: task.categoryEnum?.displayName ?? 'None',
                      ),
                    ],
                    if (task.seasonEnum != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.wb_sunny,
                        label: 'Season',
                        value: task.seasonEnum?.displayName ?? 'None',
                      ),
                    ],
                    if (task.lastCompletedDate != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.history,
                        label: 'Last Completed',
                        value: formatDate(task.lastCompletedDate!),
                      ),
                    ],
                  ],
                ),
              ),

              // Estimates
              if (task.estimatedCost != null || task.estimatedTimeMinutes != null) ...[
                const SectionHeader(title: 'Estimates'),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      if (task.estimatedTimeMinutes != null)
                        InfoRow(
                          icon: Icons.schedule,
                          label: 'Estimated Time',
                          value: '${task.estimatedTimeMinutes} minutes',
                        ),
                      if (task.estimatedCost != null) ...[
                        if (task.estimatedTimeMinutes != null) const Divider(height: 1),
                        InfoRow(
                          icon: Icons.payments,
                          label: 'Estimated Cost',
                          value: formatCurrency(task.estimatedCost!),
                        ),
                      ],
                    ],
                  ),
                ),
              ],

              // Description
              if (task.description != null && task.description!.isNotEmpty) ...[
                const SectionHeader(title: 'Description'),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(task.description!),
                  ),
                ),
              ],

              // Instructions
              if (task.instructions != null && task.instructions!.isNotEmpty) ...[
                const SectionHeader(title: 'Instructions'),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(task.instructions!),
                  ),
                ),
              ],

              // Notes
              if (task.notes != null && task.notes!.isNotEmpty) ...[
                const SectionHeader(title: 'Notes'),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(task.notes!),
                  ),
                ),
              ],

              // Reminder Settings
              const SectionHeader(title: 'Reminder'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: InfoRow(
                  icon: Icons.notifications,
                  label: 'Reminder',
                  value: task.reminderEnabled
                      ? '${task.reminderDaysBefore} days before due'
                      : 'Disabled',
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/history/new'),
            icon: const Icon(Icons.add),
            label: const Text('Log Service'),
          ),
        );
      },
    );
  }
}
