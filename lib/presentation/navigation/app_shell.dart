import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/providers.dart';

class AppShell extends ConsumerWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  static const _destinations = [
    _NavDestination(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
      path: '/home',
    ),
    _NavDestination(
      icon: Icons.inventory_2_outlined,
      selectedIcon: Icons.inventory_2,
      label: 'Assets',
      path: '/assets',
    ),
    _NavDestination(
      icon: Icons.checklist_outlined,
      selectedIcon: Icons.checklist,
      label: 'Tasks',
      path: '/tasks',
    ),
    _NavDestination(
      icon: Icons.history_outlined,
      selectedIcon: Icons.history,
      label: 'History',
      path: '/history',
    ),
    _NavDestination(
      icon: Icons.people_outline,
      selectedIcon: Icons.people,
      label: 'Contractors',
      path: '/contractors',
    ),
    _NavDestination(
      icon: Icons.folder_outlined,
      selectedIcon: Icons.folder,
      label: 'Documents',
      path: '/documents',
    ),
  ];

  int _getSelectedIndex(String location) {
    for (int i = 0; i < _destinations.length; i++) {
      if (location.startsWith(_destinations[i].path)) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final selectedIndex = _getSelectedIndex(location);
    final overdueCount = ref.watch(overdueTaskCountProvider).valueOrNull ?? 0;
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 800;
    final isVeryWide = width >= 1200;

    return Scaffold(
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              extended: isVeryWide,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                context.go(_destinations[index].path);
              },
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: isVeryWide
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_work,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'HouseBinder',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      )
                    : Icon(
                        Icons.home_work,
                        color: Theme.of(context).colorScheme.primary,
                      ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () => context.go('/settings'),
                  tooltip: 'Settings',
                ),
              ),
              destinations: _destinations.map((dest) {
                Widget icon = Icon(dest.icon);
                Widget selectedIcon = Icon(dest.selectedIcon);

                // Add badge for tasks if there are overdue items
                if (dest.path == '/tasks' && overdueCount > 0) {
                  icon = Badge.count(count: overdueCount, child: icon);
                  selectedIcon =
                      Badge.count(count: overdueCount, child: selectedIcon);
                }

                return NavigationRailDestination(
                  icon: icon,
                  selectedIcon: selectedIcon,
                  label: Text(dest.label),
                );
              }).toList(),
            ),
          if (isWide) const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: selectedIndex > 4 ? 0 : selectedIndex,
              onDestinationSelected: (index) {
                if (index < _destinations.length) {
                  context.go(_destinations[index].path);
                }
              },
              destinations: _destinations.take(5).map((dest) {
                Widget icon = Icon(dest.icon);
                Widget selectedIcon = Icon(dest.selectedIcon);

                if (dest.path == '/tasks' && overdueCount > 0) {
                  icon = Badge.count(count: overdueCount, child: icon);
                  selectedIcon =
                      Badge.count(count: overdueCount, child: selectedIcon);
                }

                return NavigationDestination(
                  icon: icon,
                  selectedIcon: selectedIcon,
                  label: dest.label,
                );
              }).toList(),
            ),
    );
  }
}

class _NavDestination {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String path;

  const _NavDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.path,
  });
}
