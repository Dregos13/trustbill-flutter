import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_provider.dart';
import '../auth/auth_state.dart';
import '../../features/setup/setup_screen.dart';
import '../../features/login/login_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/clients/clients_screen.dart';
import '../../features/clients/client_detail_screen.dart';
import '../../features/invoices/invoices_screen.dart';
import '../../features/invoices/invoice_detail_screen.dart';
import '../../features/account/account_screen.dart';
import '../../features/scan/scan_screen.dart';
import '../../features/scan/scan_review_screen.dart';
import '../../features/purchases/purchases_screen.dart';
import '../../widgets/app_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Use a ValueNotifier so GoRouter re-evaluates redirect on auth changes
  // without being recreated itself.
  final authNotifier = ValueNotifier<AuthState>(ref.read(authProvider));
  ref.listen<AuthState>(authProvider, (_, next) {
    authNotifier.value = next;
  });

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = authNotifier.value;
      final isSetup = authState is AuthNeedsSetup;
      final isLoggedIn = authState is AuthAuthenticated;
      final isLoading =
          authState is AuthLoading || authState is AuthInitial;
      final loc = state.matchedLocation;

      if (isLoading) return null;
      if (isSetup && loc != '/setup') return '/setup';
      if (!isSetup && loc == '/setup') return isLoggedIn ? '/' : '/login';
      if (!isLoggedIn && !isSetup && loc != '/login') return '/login';
      if (isLoggedIn && loc == '/login') return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/setup',
        builder: (_, __) => const SetupScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (_, state, child) => AppShell(
          currentLocation: state.matchedLocation,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/clients',
            builder: (_, __) => const ClientsScreen(),
          ),
          GoRoute(
            path: '/clients/:id',
            builder: (_, state) => ClientDetailScreen(
              id: int.parse(state.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: '/invoices',
            builder: (_, __) => const InvoicesScreen(),
          ),
          GoRoute(
            path: '/invoices/:id',
            builder: (_, state) => InvoiceDetailScreen(
              id: int.parse(state.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: '/scan',
            builder: (_, __) => const ScanScreen(),
          ),
          GoRoute(
            path: '/scan/review',
            builder: (_, __) => const ScanReviewScreen(),
          ),
          GoRoute(
            path: '/purchases',
            builder: (_, __) => const PurchasesScreen(),
          ),
          GoRoute(
            path: '/account',
            builder: (_, __) => const AccountScreen(),
          ),
        ],
      ),
    ],
  );
});
