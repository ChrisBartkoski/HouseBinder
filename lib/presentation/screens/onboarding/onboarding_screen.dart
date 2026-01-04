import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../application/providers/providers.dart';
import '../../../application/services/template_service.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  // Form data
  final _propertyNameController = TextEditingController();
  final _propertyAddressController = TextEditingController();
  bool _addDefaultTasks = true;
  bool _isCreating = false;

  @override
  void dispose() {
    _pageController.dispose();
    _propertyNameController.dispose();
    _propertyAddressController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finishOnboarding() async {
    if (_propertyNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a property name')),
      );
      return;
    }

    setState(() => _isCreating = true);

    try {
      // Create property
      final property = await ref.read(propertiesProvider.notifier).createProperty(
            name: _propertyNameController.text,
            address: _propertyAddressController.text.isEmpty
                ? null
                : _propertyAddressController.text,
          );

      // Add default maintenance tasks if selected
      if (_addDefaultTasks) {
        final templateService = TemplateService(ref);
        await templateService.addDefaultTasks(property);
      }

      // Mark onboarding as complete
      await ref.read(settingsProvider.notifier).completeOnboarding();

      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCreating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: (_currentPage + 1) / 3,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() => _currentPage = page);
                },
                children: [
                  _WelcomePage(onNext: _nextPage),
                  _PropertySetupPage(
                    nameController: _propertyNameController,
                    addressController: _propertyAddressController,
                    onNext: _nextPage,
                    onBack: _previousPage,
                  ),
                  _TasksSetupPage(
                    addDefaultTasks: _addDefaultTasks,
                    onToggle: (value) {
                      setState(() => _addDefaultTasks = value);
                    },
                    onFinish: _finishOnboarding,
                    onBack: _previousPage,
                    isCreating: _isCreating,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  final VoidCallback onNext;

  const _WelcomePage({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home_work,
            size: 100,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 32),
          Text(
            'Welcome to HouseBinder',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "The owner's manual your home never came with",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          const _FeatureItem(
            icon: Icons.inventory_2,
            title: 'Track Your Home',
            description: 'Manage appliances, warranties, and manuals',
          ),
          const SizedBox(height: 16),
          const _FeatureItem(
            icon: Icons.checklist,
            title: 'Stay on Top of Maintenance',
            description: 'Never miss a filter change or tune-up',
          ),
          const SizedBox(height: 16),
          const _FeatureItem(
            icon: Icons.picture_as_pdf,
            title: 'Generate Reports',
            description: 'Create professional PDF binders for anyone',
          ),
          const Spacer(),
          FilledButton(
            onPressed: onNext,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PropertySetupPage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _PropertySetupPage({
    required this.nameController,
    required this.addressController,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Text(
            'Set Up Your Property',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "Let's start with some basic information about your home",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Property Name *',
              hintText: 'e.g., My Home, Beach House',
              prefixIcon: Icon(Icons.home),
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(
              labelText: 'Address (optional)',
              hintText: 'e.g., 123 Main St',
              prefixIcon: Icon(Icons.location_on),
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const Spacer(),
          Row(
            children: [
              TextButton(
                onPressed: onBack,
                child: const Text('Back'),
              ),
              const Spacer(),
              FilledButton(
                onPressed: onNext,
                child: const Text('Continue'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TasksSetupPage extends StatelessWidget {
  final bool addDefaultTasks;
  final ValueChanged<bool> onToggle;
  final VoidCallback onFinish;
  final VoidCallback onBack;
  final bool isCreating;

  const _TasksSetupPage({
    required this.addDefaultTasks,
    required this.onToggle,
    required this.onFinish,
    required this.onBack,
    required this.isCreating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Text(
            'Maintenance Tasks',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Would you like to add common home maintenance tasks?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 32),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Add Default Tasks'),
                  subtitle: const Text('Includes HVAC, plumbing, safety checks, and more'),
                  value: addDefaultTasks,
                  onChanged: onToggle,
                ),
              ],
            ),
          ),
          if (addDefaultTasks) ...[
            const SizedBox(height: 16),
            Text(
              'Tasks that will be added:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            const _TaskPreviewItem(
              icon: Icons.air,
              title: 'Replace HVAC filters',
              frequency: 'Monthly',
            ),
            const _TaskPreviewItem(
              icon: Icons.smoke_free,
              title: 'Test smoke detectors',
              frequency: 'Monthly',
            ),
            const _TaskPreviewItem(
              icon: Icons.local_fire_department,
              title: 'Furnace tune-up',
              frequency: 'Annually (Fall)',
            ),
            const _TaskPreviewItem(
              icon: Icons.ac_unit,
              title: 'AC tune-up',
              frequency: 'Annually (Spring)',
            ),
            const _TaskPreviewItem(
              icon: Icons.water_drop,
              title: 'Flush water heater',
              frequency: 'Annually',
            ),
            Text(
              '...and 10+ more tasks',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
          const Spacer(),
          Row(
            children: [
              TextButton(
                onPressed: isCreating ? null : onBack,
                child: const Text('Back'),
              ),
              const Spacer(),
              FilledButton(
                onPressed: isCreating ? null : onFinish,
                child: isCreating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Finish Setup'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TaskPreviewItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String frequency;

  const _TaskPreviewItem({
    required this.icon,
    required this.title,
    required this.frequency,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.outline),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          Text(
            frequency,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}
