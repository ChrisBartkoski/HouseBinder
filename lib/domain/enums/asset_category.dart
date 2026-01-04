enum AssetCategory {
  hvac,
  plumbing,
  electrical,
  kitchen,
  laundry,
  bathroom,
  exterior,
  structural,
  safety,
  entertainment,
  other;

  String get displayName {
    switch (this) {
      case AssetCategory.hvac:
        return 'HVAC';
      case AssetCategory.plumbing:
        return 'Plumbing';
      case AssetCategory.electrical:
        return 'Electrical';
      case AssetCategory.kitchen:
        return 'Kitchen';
      case AssetCategory.laundry:
        return 'Laundry';
      case AssetCategory.bathroom:
        return 'Bathroom';
      case AssetCategory.exterior:
        return 'Exterior';
      case AssetCategory.structural:
        return 'Structural';
      case AssetCategory.safety:
        return 'Safety';
      case AssetCategory.entertainment:
        return 'Entertainment';
      case AssetCategory.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case AssetCategory.hvac:
        return 'ac_unit';
      case AssetCategory.plumbing:
        return 'plumbing';
      case AssetCategory.electrical:
        return 'electrical_services';
      case AssetCategory.kitchen:
        return 'kitchen';
      case AssetCategory.laundry:
        return 'local_laundry_service';
      case AssetCategory.bathroom:
        return 'bathroom';
      case AssetCategory.exterior:
        return 'yard';
      case AssetCategory.structural:
        return 'foundation';
      case AssetCategory.safety:
        return 'health_and_safety';
      case AssetCategory.entertainment:
        return 'tv';
      case AssetCategory.other:
        return 'category';
    }
  }
}
