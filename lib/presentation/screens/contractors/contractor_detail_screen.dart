import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../application/providers/providers.dart';
import '../../../data/database/database.dart';
import '../../widgets/common_widgets.dart';

class ContractorDetailScreen extends ConsumerWidget {
  final String contractorId;

  const ContractorDetailScreen({super.key, required this.contractorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contractorAsync = ref.watch(contractorProvider(contractorId));

    return contractorAsync.when(
      loading: () => const Scaffold(body: LoadingState()),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: ErrorState(message: error.toString()),
      ),
      data: (contractor) {
        if (contractor == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const ErrorState(message: 'Contractor not found'),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(contractor.displayName),
            actions: [
              IconButton(
                icon: Icon(
                  contractor.isPreferred ? Icons.star : Icons.star_border,
                  color: contractor.isPreferred ? Colors.amber : null,
                ),
                onPressed: () async {
                  await ref.read(contractorNotifierProvider.notifier)
                      .togglePreferred(contractorId);
                },
                tooltip: contractor.isPreferred ? 'Remove from preferred' : 'Mark as preferred',
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => context.push('/contractors/$contractorId/edit'),
                tooltip: 'Edit',
              ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'delete') {
                    final confirm = await showConfirmDialog(
                      context,
                      title: 'Delete Contractor',
                      message: 'Are you sure you want to delete "${contractor.displayName}"?',
                      confirmText: 'Delete',
                      isDestructive: true,
                    );
                    if (confirm && context.mounted) {
                      await ref.read(contractorNotifierProvider.notifier)
                          .deleteContractor(contractorId);
                      if (context.mounted) {
                        context.pop();
                        showSuccessSnackbar(context, 'Contractor deleted');
                      }
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red),
                        SizedBox(width: 12),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              // Quick Actions
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (contractor.phone != null) ...[
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => _makeCall(contractor.phone!),
                          icon: const Icon(Icons.phone),
                          label: const Text('Call'),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (contractor.email != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _sendEmail(contractor.email!),
                          icon: const Icon(Icons.email),
                          label: const Text('Email'),
                        ),
                      ),
                  ],
                ),
              ),

              // Contact Info
              const SectionHeader(title: 'Contact Information'),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    InfoRow(
                      icon: Icons.work,
                      label: 'Trade',
                      value: contractor.tradeTypeEnum.displayName,
                    ),
                    if (contractor.companyName != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.business,
                        label: 'Company',
                        value: contractor.companyName!,
                      ),
                    ],
                    if (contractor.phone != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: contractor.phone!,
                        onTap: () => _makeCall(contractor.phone!),
                      ),
                    ],
                    if (contractor.email != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: contractor.email!,
                        onTap: () => _sendEmail(contractor.email!),
                      ),
                    ],
                    if (contractor.address != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.location_on,
                        label: 'Address',
                        value: contractor.address!,
                      ),
                    ],
                    if (contractor.website != null) ...[
                      const Divider(height: 1),
                      InfoRow(
                        icon: Icons.language,
                        label: 'Website',
                        value: contractor.website!,
                        onTap: () => _openUrl(contractor.website!),
                      ),
                    ],
                  ],
                ),
              ),

              // Notes
              if (contractor.notes != null && contractor.notes!.isNotEmpty) ...[
                const SectionHeader(title: 'Notes'),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(contractor.notes!),
                  ),
                ),
              ],
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/history/new'),
            icon: const Icon(Icons.add),
            label: const Text('Log Service'),
          ),
        );
      },
    );
  }

  Future<void> _makeCall(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openUrl(String url) async {
    var urlString = url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      urlString = 'https://$url';
    }
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
