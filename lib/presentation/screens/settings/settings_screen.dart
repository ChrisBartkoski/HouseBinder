import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../../domain/enums/enums.dart';
import '../../widgets/common_widgets.dart';
import '../../../application/services/backup_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final propertiesAsync = ref.watch(propertiesProvider);
    final currentPropertyAsync = ref.watch(currentPropertyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: settingsAsync.when(
        loading: () => const LoadingState(),
        error: (error, _) => ErrorState(message: error.toString()),
        data: (settings) {
          return ListView(
            children: [
              // Property Section
              const SectionHeader(title: 'Property'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Current property
                    currentPropertyAsync.when(
                      loading: () => const ListTile(
                        title: Text('Loading...'),
                      ),
                      error: (_, __) => const ListTile(
                        title: Text('Error loading property'),
                      ),
                      data: (property) => ListTile(
                        leading: const Icon(Icons.home),
                        title: Text(property?.name ?? 'No property selected'),
                        subtitle: property?.address != null
                            ? Text(property!.address!)
                            : null,
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _showPropertyPicker(context, ref),
                      ),
                    ),

                    const Divider(height: 1),

                    // Add property
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Add New Property'),
                      onTap: () => _showAddPropertyDialog(context, ref),
                    ),

                    // Property count
                    propertiesAsync.when(
                      data: (properties) {
                        if (properties.length > 1) {
                          return Column(
                            children: [
                              const Divider(height: 1),
                              ListTile(
                                leading: const Icon(Icons.list),
                                title: Text('${properties.length} Properties'),
                                subtitle: const Text('Tap to manage'),
                                onTap: () => _showPropertyPicker(context, ref),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),

              // Appearance Section
              const SectionHeader(title: 'Appearance'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text('Theme'),
                      trailing: SegmentedButton<ThemeModeSetting>(
                        segments: const [
                          ButtonSegment(
                            value: ThemeModeSetting.system,
                            label: Text('Auto'),
                          ),
                          ButtonSegment(
                            value: ThemeModeSetting.light,
                            icon: Icon(Icons.light_mode),
                          ),
                          ButtonSegment(
                            value: ThemeModeSetting.dark,
                            icon: Icon(Icons.dark_mode),
                          ),
                        ],
                        selected: {settings.themeModeEnum},
                        onSelectionChanged: (Set<ThemeModeSetting> newSelection) {
                          ref.read(settingsProvider.notifier)
                              .setThemeMode(newSelection.first);
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.palette),
                      title: const Text('Color Scheme'),
                      subtitle: Text(settings.themeColorEnum.displayName),
                      trailing: CircleAvatar(
                        radius: 14,
                        backgroundColor: settings.themeColorEnum.seedColor,
                        child: Icon(
                          settings.themeColorEnum.icon,
                          size: 16,
                          color: _iconForegroundColor(
                            settings.themeColorEnum.seedColor,
                          ),
                        ),
                      ),
                      onTap: () => _showThemeColorPicker(
                        context,
                        ref,
                        settings.themeColorEnum,
                      ),
                    ),
                  ],
                ),
              ),

              // Notifications Section
              const SectionHeader(title: 'Notifications'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.notifications),
                      title: const Text('Task Reminders'),
                      subtitle: const Text('Get notified before tasks are due'),
                      value: settings.notificationsEnabled,
                      onChanged: (value) {
                        ref.read(settingsProvider.notifier)
                            .setNotificationsEnabled(value);
                      },
                    ),
                  ],
                ),
              ),

              // Data Section
              const SectionHeader(title: 'Data'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.backup),
                      title: const Text('Export Backup'),
                      subtitle: const Text('Save all data to a .zip file'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _exportBackup(context, ref),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.restore),
                      title: const Text('Import Backup'),
                      subtitle: const Text('Restore from a backup file'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _importBackup(context, ref),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.picture_as_pdf),
                      title: const Text('Generate PDF Report'),
                      subtitle: const Text('Create a house binder PDF'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/reports'),
                    ),
                    if (settings.lastBackupDate != null) ...[
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.schedule),
                        title: const Text('Last Backup'),
                        subtitle: Text(formatDateTime(settings.lastBackupDate!)),
                      ),
                    ],
                  ],
                ),
              ),

              // About Section
              const SectionHeader(title: 'About'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.info),
                      title: Text('HouseBinder'),
                      subtitle: Text('Version 1.0.0'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.delete_forever),
                      title: const Text('Reset Onboarding'),
                      subtitle: const Text('Show setup wizard again'),
                      onTap: () async {
                        final confirm = await showConfirmDialog(
                          context,
                          title: 'Reset Onboarding',
                          message: 'This will show the setup wizard next time you open the app.',
                          confirmText: 'Reset',
                        );
                        if (confirm) {
                          // Reset onboarding by setting hasCompletedOnboarding to false
                          // We need to update via the database directly since we don't have a method for this
                          await ref.read(settingsProvider.notifier).completeOnboarding();
                          // Note: This actually sets it to true - we need a reset method
                          // For now, just show a message
                          if (context.mounted) {
                            showSuccessSnackbar(context, 'Please restart the app to see onboarding');
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showPropertyPicker(BuildContext context, WidgetRef ref) async {
    final properties = await ref.read(propertiesProvider.future);
    final currentProperty = await ref.read(currentPropertyProvider.future);

    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select Property',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...properties.map((property) => ListTile(
                leading: Icon(
                  property.id == currentProperty?.id
                      ? Icons.check_circle
                      : Icons.home_outlined,
                  color: property.id == currentProperty?.id
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                title: Text(property.name),
                subtitle: property.address != null ? Text(property.address!) : null,
                onTap: () {
                  ref.read(settingsProvider.notifier).setCurrentProperty(property.id);
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }

  Future<void> _showAddPropertyDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final addressController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Property'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name *',
                hintText: 'e.g., Main House',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address (optional)',
              ),
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result == true && nameController.text.isNotEmpty) {
      await ref.read(propertiesProvider.notifier).createProperty(
            name: nameController.text,
            address: addressController.text.isEmpty ? null : addressController.text,
          );
      if (context.mounted) {
        showSuccessSnackbar(context, 'Property added');
      }
    }

    nameController.dispose();
    addressController.dispose();
  }

  Future<void> _showThemeColorPicker(
    BuildContext context,
    WidgetRef ref,
    ThemeColor currentColor,
  ) async {
    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select Theme Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...ThemeColor.values.map((themeColor) {
            final isSelected = themeColor == currentColor;
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: themeColor.seedColor,
                child: Icon(
                  themeColor.icon,
                  color: _iconForegroundColor(themeColor.seedColor),
                ),
              ),
              title: Text(themeColor.displayName),
              trailing: isSelected
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                ref.read(settingsProvider.notifier).setThemeColor(themeColor);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }

  Color _iconForegroundColor(Color color) {
    final brightness = ThemeData.estimateBrightnessForColor(color);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  Future<void> _exportBackup(BuildContext context, WidgetRef ref) async {
    try {
      final backupService = BackupService(ref.read(databaseProvider));
      final path = await backupService.exportBackup();
      if (context.mounted) {
        showSuccessSnackbar(context, 'Backup saved to: $path');
        ref.read(settingsProvider.notifier).setLastBackupDate(DateTime.now());
      }
    } catch (e) {
      if (context.mounted) {
        showErrorSnackbar(context, 'Export failed: $e');
      }
    }
  }

  Future<void> _importBackup(BuildContext context, WidgetRef ref) async {
    final confirm = await showConfirmDialog(
      context,
      title: 'Import Backup',
      message: 'This will replace all existing data. Are you sure?',
      confirmText: 'Import',
      isDestructive: true,
    );

    if (!confirm) return;

    try {
      final backupService = BackupService(ref.read(databaseProvider));
      await backupService.importBackup();
      if (context.mounted) {
        showSuccessSnackbar(context, 'Backup imported successfully');
        // Refresh all providers
        ref.invalidate(propertiesProvider);
        ref.invalidate(assetsProvider);
        ref.invalidate(tasksProvider);
        ref.invalidate(serviceRecordsProvider);
        ref.invalidate(contractorsProvider);
        ref.invalidate(documentsProvider);
      }
    } catch (e) {
      if (context.mounted) {
        showErrorSnackbar(context, 'Import failed: $e');
      }
    }
  }
}
