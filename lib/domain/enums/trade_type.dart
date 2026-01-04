enum TradeType {
  hvac,
  plumber,
  electrician,
  generalContractor,
  roofer,
  landscaper,
  painter,
  carpenter,
  handyman,
  applianceRepair,
  pestControl,
  poolService,
  cleaning,
  locksmith,
  windowWashing,
  gutterService,
  chimneySweep,
  inspector,
  other;

  String get displayName {
    switch (this) {
      case TradeType.hvac:
        return 'HVAC Technician';
      case TradeType.plumber:
        return 'Plumber';
      case TradeType.electrician:
        return 'Electrician';
      case TradeType.generalContractor:
        return 'General Contractor';
      case TradeType.roofer:
        return 'Roofer';
      case TradeType.landscaper:
        return 'Landscaper';
      case TradeType.painter:
        return 'Painter';
      case TradeType.carpenter:
        return 'Carpenter';
      case TradeType.handyman:
        return 'Handyman';
      case TradeType.applianceRepair:
        return 'Appliance Repair';
      case TradeType.pestControl:
        return 'Pest Control';
      case TradeType.poolService:
        return 'Pool Service';
      case TradeType.cleaning:
        return 'Cleaning Service';
      case TradeType.locksmith:
        return 'Locksmith';
      case TradeType.windowWashing:
        return 'Window Washing';
      case TradeType.gutterService:
        return 'Gutter Service';
      case TradeType.chimneySweep:
        return 'Chimney Sweep';
      case TradeType.inspector:
        return 'Inspector';
      case TradeType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case TradeType.hvac:
        return 'ac_unit';
      case TradeType.plumber:
        return 'plumbing';
      case TradeType.electrician:
        return 'electrical_services';
      case TradeType.generalContractor:
        return 'engineering';
      case TradeType.roofer:
        return 'roofing';
      case TradeType.landscaper:
        return 'grass';
      case TradeType.painter:
        return 'format_paint';
      case TradeType.carpenter:
        return 'carpenter';
      case TradeType.handyman:
        return 'handyman';
      case TradeType.applianceRepair:
        return 'build';
      case TradeType.pestControl:
        return 'pest_control';
      case TradeType.poolService:
        return 'pool';
      case TradeType.cleaning:
        return 'cleaning_services';
      case TradeType.locksmith:
        return 'lock';
      case TradeType.windowWashing:
        return 'window';
      case TradeType.gutterService:
        return 'water_drop';
      case TradeType.chimneySweep:
        return 'fireplace';
      case TradeType.inspector:
        return 'search';
      case TradeType.other:
        return 'person';
    }
  }
}
