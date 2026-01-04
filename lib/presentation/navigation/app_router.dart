import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/providers.dart';
import '../screens/home/home_screen.dart';
import '../screens/assets/assets_screen.dart';
import '../screens/assets/asset_detail_screen.dart';
import '../screens/assets/asset_form_screen.dart';
import '../screens/tasks/tasks_screen.dart';
import '../screens/tasks/task_detail_screen.dart';
import '../screens/tasks/task_form_screen.dart';
import '../screens/service_history/service_history_screen.dart';
import '../screens/service_history/service_record_form_screen.dart';
import '../screens/contractors/contractors_screen.dart';
import '../screens/contractors/contractor_detail_screen.dart';
import '../screens/contractors/contractor_form_screen.dart';
import '../screens/documents/documents_screen.dart';
import '../screens/documents/document_form_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/reports/reports_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import 'app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final settingsAsync = ref.watch(settingsProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    redirect: (context, state) {
      final settings = settingsAsync.valueOrNull;
      if (settings == null) return null;

      // Redirect to onboarding if not completed
      if (!settings.hasCompletedOnboarding &&
          state.matchedLocation != '/onboarding') {
        return '/onboarding';
      }

      // Redirect away from onboarding if already completed
      if (settings.hasCompletedOnboarding &&
          state.matchedLocation == '/onboarding') {
        return '/home';
      }

      return null;
    },
    routes: [
      // Onboarding (outside shell)
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Main app shell
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/assets',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AssetsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'new',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const AssetFormScreen(),
              ),
              GoRoute(
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return AssetDetailScreen(assetId: id);
                },
                routes: [
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return AssetFormScreen(assetId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/tasks',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TasksScreen(),
            ),
            routes: [
              GoRoute(
                path: 'new',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const TaskFormScreen(),
              ),
              GoRoute(
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return TaskDetailScreen(taskId: id);
                },
                routes: [
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return TaskFormScreen(taskId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/history',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ServiceHistoryScreen(),
            ),
            routes: [
              GoRoute(
                path: 'new',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const ServiceRecordFormScreen(),
              ),
              GoRoute(
                path: ':id/edit',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return ServiceRecordFormScreen(recordId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/contractors',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ContractorsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'new',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const ContractorFormScreen(),
              ),
              GoRoute(
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return ContractorDetailScreen(contractorId: id);
                },
                routes: [
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return ContractorFormScreen(contractorId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/documents',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DocumentsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'new',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const DocumentFormScreen(),
              ),
              GoRoute(
                path: ':id/edit',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return DocumentFormScreen(documentId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),

      // Full-screen routes
      GoRoute(
        path: '/search',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/reports',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ReportsScreen(),
      ),
    ],
  );
});
