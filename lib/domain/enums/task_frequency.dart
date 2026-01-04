enum TaskFrequency {
  once,
  weekly,
  biweekly,
  monthly,
  quarterly,
  semiannually,
  annually,
  custom;

  String get displayName {
    switch (this) {
      case TaskFrequency.once:
        return 'One-time';
      case TaskFrequency.weekly:
        return 'Weekly';
      case TaskFrequency.biweekly:
        return 'Every 2 Weeks';
      case TaskFrequency.monthly:
        return 'Monthly';
      case TaskFrequency.quarterly:
        return 'Quarterly';
      case TaskFrequency.semiannually:
        return 'Every 6 Months';
      case TaskFrequency.annually:
        return 'Annually';
      case TaskFrequency.custom:
        return 'Custom';
    }
  }

  int? get daysInterval {
    switch (this) {
      case TaskFrequency.once:
        return null;
      case TaskFrequency.weekly:
        return 7;
      case TaskFrequency.biweekly:
        return 14;
      case TaskFrequency.monthly:
        return 30;
      case TaskFrequency.quarterly:
        return 90;
      case TaskFrequency.semiannually:
        return 180;
      case TaskFrequency.annually:
        return 365;
      case TaskFrequency.custom:
        return null;
    }
  }

  DateTime? getNextDueDate(DateTime fromDate) {
    final interval = daysInterval;
    if (interval == null) return null;
    return fromDate.add(Duration(days: interval));
  }
}
