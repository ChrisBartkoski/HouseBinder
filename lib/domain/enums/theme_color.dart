import 'package:flutter/material.dart';

enum ThemeColor {
  green,
  blue,
  purple,
  orange,
  red,
  teal,
  indigo,
  pink,
  brown,
  grey;

  String get displayName {
    switch (this) {
      case ThemeColor.green:
        return 'Forest Green';
      case ThemeColor.blue:
        return 'Ocean Blue';
      case ThemeColor.purple:
        return 'Royal Purple';
      case ThemeColor.orange:
        return 'Sunset Orange';
      case ThemeColor.red:
        return 'Classic Red';
      case ThemeColor.teal:
        return 'Teal';
      case ThemeColor.indigo:
        return 'Indigo';
      case ThemeColor.pink:
        return 'Rose Pink';
      case ThemeColor.brown:
        return 'Earth Brown';
      case ThemeColor.grey:
        return 'Neutral Grey';
    }
  }

  Color get seedColor {
    switch (this) {
      case ThemeColor.green:
        return const Color(0xFF2E7D32);
      case ThemeColor.blue:
        return const Color(0xFF1565C0);
      case ThemeColor.purple:
        return const Color(0xFF7B1FA2);
      case ThemeColor.orange:
        return const Color(0xFFE65100);
      case ThemeColor.red:
        return const Color(0xFFC62828);
      case ThemeColor.teal:
        return const Color(0xFF00796B);
      case ThemeColor.indigo:
        return const Color(0xFF303F9F);
      case ThemeColor.pink:
        return const Color(0xFFC2185B);
      case ThemeColor.brown:
        return const Color(0xFF5D4037);
      case ThemeColor.grey:
        return const Color(0xFF455A64);
    }
  }

  IconData get icon {
    switch (this) {
      case ThemeColor.green:
        return Icons.park;
      case ThemeColor.blue:
        return Icons.water;
      case ThemeColor.purple:
        return Icons.auto_awesome;
      case ThemeColor.orange:
        return Icons.wb_sunny;
      case ThemeColor.red:
        return Icons.favorite;
      case ThemeColor.teal:
        return Icons.waves;
      case ThemeColor.indigo:
        return Icons.nights_stay;
      case ThemeColor.pink:
        return Icons.local_florist;
      case ThemeColor.brown:
        return Icons.terrain;
      case ThemeColor.grey:
        return Icons.lens_blur;
    }
  }
}
