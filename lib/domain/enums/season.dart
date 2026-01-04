enum Season {
  spring,
  summer,
  fall,
  winter,
  any;

  String get displayName {
    switch (this) {
      case Season.spring:
        return 'Spring';
      case Season.summer:
        return 'Summer';
      case Season.fall:
        return 'Fall';
      case Season.winter:
        return 'Winter';
      case Season.any:
        return 'Any Season';
    }
  }

  String get icon {
    switch (this) {
      case Season.spring:
        return 'local_florist';
      case Season.summer:
        return 'wb_sunny';
      case Season.fall:
        return 'eco';
      case Season.winter:
        return 'ac_unit';
      case Season.any:
        return 'calendar_today';
    }
  }

  List<int> get months {
    switch (this) {
      case Season.spring:
        return [3, 4, 5];
      case Season.summer:
        return [6, 7, 8];
      case Season.fall:
        return [9, 10, 11];
      case Season.winter:
        return [12, 1, 2];
      case Season.any:
        return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    }
  }

  static Season fromMonth(int month) {
    if ([3, 4, 5].contains(month)) return Season.spring;
    if ([6, 7, 8].contains(month)) return Season.summer;
    if ([9, 10, 11].contains(month)) return Season.fall;
    return Season.winter;
  }
}
