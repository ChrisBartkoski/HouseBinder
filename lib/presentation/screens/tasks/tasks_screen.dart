import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/enums/enums.dart';
import '../../widgets/common_widgets.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Tasks'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Overdue'),
            Tab(text: 'All'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: tasksAsync.when(
        loading: () => const LoadingState(),
        error: (error, _) => ErrorState(message: error.toString()),
        data: (tasks) {
          if (tasks.isEmpty) {
            return EmptyState(
              icon: Icons.checklist_outlined,
              title: 'No Tasks Yet',
              subtitle: 'Add maintenance tasks to keep your home in top shape',
              action: FilledButton.icon(
                onPressed: () => context.push('/tasks/new'),
                icon: const Icon(Icons.add),
                label: const Text('Add Task'),
              ),
            );
          }

          final overdueTasks = tasks.where((t) => t.isOverdue).toList();
          final upcomingTasks = tasks.where((t) => !t.isOverdue && t.nextDueDate != null).toList();

          return TabBarView(
            controller: _tabController,
            children: [
              // Upcoming
              _TaskList(
                tasks: upcomingTasks,
                emptyMessage: 'No upcoming tasks',
              ),
              // Overdue
              _TaskList(
                tasks: overdueTasks,
                emptyMessage: 'No overdue tasks - great job!',
                showOverdueWarning: true,
              ),
              // All
              _TaskList(
                tasks: tasks,
                emptyMessage: 'No tasks',
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/tasks/new'),
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }
}

class _TaskList extends ConsumerWidget {
  final List<MaintenanceTask> tasks;
  final String emptyMessage;
  final bool showOverdueWarning;

  const _TaskList({
    required this.tasks,
    required this.emptyMessage,
    this.showOverdueWarning = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              showOverdueWarning ? Icons.celebration : Icons.check_circle_outline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return _TaskListTile(task: task);
      },
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

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        // Complete the task
        await ref.read(taskNotifierProvider.notifier).completeTask(task.id);
        if (context.mounted) {
          showSuccessSnackbar(context, 'Task completed');
        }
        return false; // Don't actually dismiss, we're just completing
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.green,
        child: const Icon(Icons.check, color: Colors.white),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isOverdue
              ? Theme.of(context).colorScheme.errorContainer
              : Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            _getFrequencyIcon(task.frequencyEnum),
            color: isOverdue
                ? Theme.of(context).colorScheme.onErrorContainer
                : Theme.of(context).colorScheme.onPrimaryContainer,
            size: 20,
          ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: isOverdue ? FontWeight.bold : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.nextDueDate != null)
              Text(
                daysUntil != null ? formatDaysUntil(daysUntil) : formatDate(task.nextDueDate!),
                style: TextStyle(
                  color: isOverdue ? Theme.of(context).colorScheme.error : null,
                ),
              ),
            Row(
              children: [
                if (task.categoryEnum != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      task.categoryEnum!.displayName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  ),
                Text(
                  task.frequencyEnum.displayName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isOverdue)
              StatusChip(
                label: 'Overdue',
                color: Theme.of(context).colorScheme.error,
                icon: Icons.warning,
              ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) async {
                switch (value) {
                  case 'complete':
                    await ref.read(taskNotifierProvider.notifier).completeTask(task.id);
                    if (context.mounted) {
                      showSuccessSnackbar(context, 'Task completed');
                    }
                    break;
                  case 'skip':
                    await ref.read(taskNotifierProvider.notifier).skipTask(task.id);
                    if (context.mounted) {
                      showSuccessSnackbar(context, 'Task skipped');
                    }
                    break;
                  case 'snooze':
                    await ref.read(taskNotifierProvider.notifier).snoozeTask(task.id, 7);
                    if (context.mounted) {
                      showSuccessSnackbar(context, 'Task snoozed for 1 week');
                    }
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'complete',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline),
                      SizedBox(width: 12),
                      Text('Complete'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'skip',
                  child: Row(
                    children: [
                      Icon(Icons.skip_next_outlined),
                      SizedBox(width: 12),
                      Text('Skip this time'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'snooze',
                  child: Row(
                    children: [
                      Icon(Icons.snooze_outlined),
                      SizedBox(width: 12),
                      Text('Snooze 1 week'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => context.push('/tasks/${task.id}'),
      ),
    );
  }

  IconData _getFrequencyIcon(TaskFrequency frequency) {
    switch (frequency) {
      case TaskFrequency.once:
        return Icons.looks_one;
      case TaskFrequency.weekly:
        return Icons.calendar_view_week;
      case TaskFrequency.biweekly:
        return Icons.calendar_view_week;
      case TaskFrequency.monthly:
        return Icons.calendar_month;
      case TaskFrequency.quarterly:
        return Icons.calendar_today;
      case TaskFrequency.semiannually:
        return Icons.calendar_today;
      case TaskFrequency.annually:
        return Icons.event;
      case TaskFrequency.custom:
        return Icons.schedule;
    }
  }
}
