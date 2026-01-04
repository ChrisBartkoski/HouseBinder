import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums/enums.dart';
import '../providers/providers.dart';

class TemplateService {
  final WidgetRef _ref;

  TemplateService(this._ref);

  Future<void> addDefaultTasks(String propertyId) async {
    final notifier = _ref.read(taskNotifierProvider.notifier);

    // Set current property temporarily to create tasks
    await _ref.read(settingsProvider.notifier).setCurrentProperty(propertyId);

    final now = DateTime.now();

    // Monthly Tasks
    await notifier.createTask(
      title: 'Replace HVAC filter',
      description: 'Check and replace the HVAC air filter if dirty',
      instructions: '''1. Turn off the HVAC system
2. Locate the filter (usually in return air duct or near blower)
3. Remove the old filter, noting airflow direction
4. Insert new filter with arrows pointing toward the blower
5. Turn the system back on''',
      category: AssetCategory.hvac,
      frequency: TaskFrequency.monthly,
      estimatedTimeMinutes: 10,
      estimatedCost: 15,
      nextDueDate: _nextMonthFirstDay(now),
    );

    await notifier.createTask(
      title: 'Test smoke and CO detectors',
      description: 'Press the test button on all smoke and carbon monoxide detectors',
      instructions: '''1. Press and hold the test button on each detector
2. Wait for the alarm to sound
3. Replace batteries if needed
4. Clean with a soft brush or vacuum if dusty''',
      category: AssetCategory.safety,
      frequency: TaskFrequency.monthly,
      estimatedTimeMinutes: 15,
      nextDueDate: _nextMonthFirstDay(now),
    );

    await notifier.createTask(
      title: 'Run garbage disposal with ice',
      description: 'Clean garbage disposal with ice cubes to keep blades sharp',
      instructions: '''1. Fill disposal with ice cubes
2. Run cold water
3. Turn on disposal until ice is cleared
4. Optionally add citrus peels for freshness''',
      category: AssetCategory.kitchen,
      frequency: TaskFrequency.monthly,
      estimatedTimeMinutes: 5,
      nextDueDate: _nextMonthFirstDay(now),
    );

    // Quarterly Tasks
    await notifier.createTask(
      title: 'Test GFCI outlets',
      description: 'Test all GFCI outlets in bathrooms, kitchen, and outdoor areas',
      instructions: '''1. Press the TEST button - outlet should lose power
2. Press the RESET button - power should return
3. If outlet doesn't respond, consider replacement
4. Test with a lamp or voltage tester''',
      category: AssetCategory.electrical,
      frequency: TaskFrequency.quarterly,
      estimatedTimeMinutes: 15,
      nextDueDate: _addMonths(now, 3),
    );

    await notifier.createTask(
      title: 'Clean dryer vent',
      description: 'Clean lint from dryer vent hose and exterior vent',
      instructions: '''1. Unplug dryer and disconnect vent hose
2. Use a vent brush to clean the hose
3. Clean the exterior vent flap
4. Reconnect everything securely
5. Run empty cycle to test airflow''',
      category: AssetCategory.laundry,
      frequency: TaskFrequency.quarterly,
      estimatedTimeMinutes: 30,
      estimatedCost: 0,
      nextDueDate: _addMonths(now, 3),
    );

    await notifier.createTask(
      title: 'Clean range hood filter',
      description: 'Remove and clean or replace range hood filter',
      instructions: '''1. Remove filter from range hood
2. Soak in hot water with degreaser
3. Scrub with brush if needed
4. Rinse and dry completely
5. Replace filter''',
      category: AssetCategory.kitchen,
      frequency: TaskFrequency.quarterly,
      estimatedTimeMinutes: 20,
      nextDueDate: _addMonths(now, 3),
    );

    // Semi-Annual Tasks
    await notifier.createTask(
      title: 'Flush water heater',
      description: 'Drain sediment from water heater to improve efficiency',
      instructions: '''1. Turn off water heater (gas valve or breaker)
2. Turn off cold water supply
3. Connect hose to drain valve
4. Open drain valve and pressure relief valve
5. Flush until water runs clear
6. Close valves and refill tank
7. Turn water heater back on''',
      category: AssetCategory.plumbing,
      frequency: TaskFrequency.semiannually,
      estimatedTimeMinutes: 45,
      nextDueDate: _addMonths(now, 6),
    );

    await notifier.createTask(
      title: 'Deep clean refrigerator coils',
      description: 'Clean condenser coils to improve refrigerator efficiency',
      instructions: '''1. Unplug refrigerator
2. Locate coils (back or bottom)
3. Use coil brush or vacuum to remove dust
4. Clean surrounding area
5. Plug refrigerator back in''',
      category: AssetCategory.kitchen,
      frequency: TaskFrequency.semiannually,
      estimatedTimeMinutes: 30,
      nextDueDate: _addMonths(now, 6),
    );

    // Annual Tasks - Spring
    await notifier.createTask(
      title: 'Schedule AC tune-up',
      description: 'Professional air conditioning maintenance before summer',
      instructions: '''1. Schedule appointment with HVAC technician
2. Technician will inspect refrigerant levels
3. Clean evaporator and condenser coils
4. Check electrical connections
5. Lubricate moving parts''',
      category: AssetCategory.hvac,
      frequency: TaskFrequency.annually,
      season: Season.spring,
      estimatedTimeMinutes: 60,
      estimatedCost: 150,
      nextDueDate: _nextSpring(now),
    );

    await notifier.createTask(
      title: 'Clean gutters',
      description: 'Remove debris from gutters and check downspouts',
      instructions: '''1. Set up ladder safely
2. Remove leaves and debris by hand or scoop
3. Flush gutters with hose
4. Check downspouts for clogs
5. Repair any loose sections''',
      category: AssetCategory.exterior,
      frequency: TaskFrequency.semiannually,
      season: Season.spring,
      estimatedTimeMinutes: 60,
      nextDueDate: _nextSpring(now),
    );

    await notifier.createTask(
      title: 'Check exterior drainage',
      description: 'Ensure water drains away from foundation',
      instructions: '''1. Walk around foundation during rain
2. Check that ground slopes away from house
3. Extend downspouts if needed
4. Clear any debris from drainage areas
5. Consider French drain if issues persist''',
      category: AssetCategory.exterior,
      frequency: TaskFrequency.annually,
      season: Season.spring,
      estimatedTimeMinutes: 30,
      nextDueDate: _nextSpring(now),
    );

    // Annual Tasks - Fall
    await notifier.createTask(
      title: 'Schedule furnace tune-up',
      description: 'Professional heating system maintenance before winter',
      instructions: '''1. Schedule appointment with HVAC technician
2. Technician will inspect heat exchanger
3. Check and adjust burners
4. Test safety controls
5. Change filter if needed''',
      category: AssetCategory.hvac,
      frequency: TaskFrequency.annually,
      season: Season.fall,
      estimatedTimeMinutes: 60,
      estimatedCost: 150,
      nextDueDate: _nextFall(now),
    );

    await notifier.createTask(
      title: 'Winterize outdoor faucets',
      description: 'Disconnect hoses and prepare outdoor faucets for freezing',
      instructions: '''1. Disconnect and drain all garden hoses
2. Turn off interior shutoff valves
3. Open outdoor faucets to drain
4. Install faucet covers if available
5. Drain sprinkler system if applicable''',
      category: AssetCategory.plumbing,
      frequency: TaskFrequency.annually,
      season: Season.fall,
      estimatedTimeMinutes: 30,
      nextDueDate: _nextFall(now),
    );

    await notifier.createTask(
      title: 'Check and seal windows/doors',
      description: 'Inspect weatherstripping and caulking around windows and doors',
      instructions: '''1. Inspect weatherstripping on all doors
2. Check caulking around windows
3. Replace worn weatherstripping
4. Re-caulk gaps as needed
5. Consider window film for drafty windows''',
      category: AssetCategory.structural,
      frequency: TaskFrequency.annually,
      season: Season.fall,
      estimatedTimeMinutes: 60,
      estimatedCost: 30,
      nextDueDate: _nextFall(now),
    );

    await notifier.createTask(
      title: 'Replace smoke detector batteries',
      description: 'Replace batteries in all smoke and CO detectors',
      instructions: '''1. Remove detector from ceiling
2. Open battery compartment
3. Replace with fresh batteries
4. Test each detector
5. Note date of replacement''',
      category: AssetCategory.safety,
      frequency: TaskFrequency.annually,
      season: Season.fall,
      estimatedTimeMinutes: 20,
      estimatedCost: 20,
      nextDueDate: _nextFall(now),
    );

    await notifier.createTask(
      title: 'Inspect roof',
      description: 'Visual inspection of roof for damage or wear',
      instructions: '''1. Safely inspect from ground with binoculars
2. Look for missing or damaged shingles
3. Check flashings around vents and chimneys
4. Look for moss or debris buildup
5. Schedule professional inspection if issues found''',
      category: AssetCategory.exterior,
      frequency: TaskFrequency.annually,
      estimatedTimeMinutes: 20,
      nextDueDate: _nextFall(now),
    );

    // Winter Tasks
    await notifier.createTask(
      title: 'Check attic insulation',
      description: 'Inspect attic for adequate insulation and ice dam prevention',
      instructions: '''1. Access attic safely
2. Check insulation depth (should be 10-14 inches)
3. Look for gaps or compressed areas
4. Check for moisture or mold
5. Add insulation if needed''',
      category: AssetCategory.structural,
      frequency: TaskFrequency.annually,
      season: Season.winter,
      estimatedTimeMinutes: 30,
      nextDueDate: _nextWinter(now),
    );
  }

  DateTime _nextMonthFirstDay(DateTime from) {
    if (from.month == 12) {
      return DateTime(from.year + 1, 1, 1);
    }
    return DateTime(from.year, from.month + 1, 1);
  }

  DateTime _addMonths(DateTime from, int months) {
    var newMonth = from.month + months;
    var newYear = from.year;
    while (newMonth > 12) {
      newMonth -= 12;
      newYear++;
    }
    return DateTime(newYear, newMonth, from.day);
  }

  DateTime _nextSpring(DateTime from) {
    // Spring is March-May, target April 1
    var year = from.year;
    if (from.month >= 4) {
      year++;
    }
    return DateTime(year, 4, 1);
  }

  DateTime _nextFall(DateTime from) {
    // Fall is September-November, target October 1
    var year = from.year;
    if (from.month >= 10) {
      year++;
    }
    return DateTime(year, 10, 1);
  }

  DateTime _nextWinter(DateTime from) {
    // Winter is December-February, target January 1
    var year = from.year;
    if (from.month >= 1 && from.month <= 2) {
      // Already in winter, target next year
      year++;
    } else if (from.month >= 3) {
      year++;
    }
    return DateTime(year, 1, 1);
  }
}
