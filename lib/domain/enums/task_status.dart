enum TaskStatus {
  pending,
  upcoming,
  overdue,
  completed,
  skipped;

  String get displayName {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.upcoming:
        return 'Upcoming';
      case TaskStatus.overdue:
        return 'Overdue';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.skipped:
        return 'Skipped';
    }
  }

  String get icon {
    switch (this) {
      case TaskStatus.pending:
        return 'schedule';
      case TaskStatus.upcoming:
        return 'upcoming';
      case TaskStatus.overdue:
        return 'warning';
      case TaskStatus.completed:
        return 'check_circle';
      case TaskStatus.skipped:
        return 'skip_next';
    }
  }
}
