import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_provider.dart';
import '../auth/auth_state.dart';
import '../auth/permission_helpers.dart';
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
import '../../features/tax/tax_returns_screen.dart';
import '../../features/clients/create_client_screen.dart';
import '../../features/invoices/create_invoice_screen.dart';
import '../../features/invoices/edit_invoice_screen.dart';
import '../../features/budgets/budgets_screen.dart';
import '../../features/budgets/create_budget_screen.dart';
import '../../features/budgets/budget_detail_screen.dart';
import '../../features/sales/sales_screen.dart';
import '../../features/sales/create_sale_screen.dart';
import '../../features/sales/sale_detail_screen.dart';
import '../../features/permissions/permissions_screen.dart';
import '../../features/catalog/catalog_screen.dart';
import '../../features/catalog/product_detail_screen.dart';
import '../../features/catalog/create_edit_product_screen.dart';
import '../../features/catalog/create_edit_service_screen.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/no_permission_screen.dart';
import '../../features/tasks/tasks_screen.dart';

// ── Route permission requirements ──────────────────────────────────────────────

/// Maps route prefixes to the permission they require.
/// Checked in order — first match wins.
const _routePermissions = <String, String>{
  '/clients/new': Permissions.clientsWrite,
  '/clients/': Permissions.clientsWrite,
  '/invoices/new': Permissions.documentsWrite,
  '/budgets/new': Permissions.documentsWrite,
  '/sales/new': Permissions.documentsWrite,
  '/scan': Permissions.expensesWrite,
  '/tax': Permissions.reportsRead,
  '/catalog/products/new': Permissions.productsWrite,
  '/catalog/products/': Permissions.productsWrite,
  '/catalog/services/new': Permissions.servicesWrite,
  '/catalog/services/': Permissions.servicesWrite,
};

String? _requiredPermission(String location) {
  for (final entry in _routePermissions.entries) {
    if (location.startsWith(entry.key)) return entry.value;
  }
  return null;
}

bool _isSuperadminRoute(String location) =>
    location.startsWith('/permissions');

// ── Router ─────────────────────────────────────────────────────────────────────

final routerProvider = Provider<GoRouter>((ref) {
  // ValueNotifier lets GoRouter re-evaluate redirect on auth changes
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
      final isLoading = authState is AuthLoading || authState is AuthInitial;
      final loc = state.matchedLocation;

      // ── Loading / setup / auth gates ─────────────────────────────────────
      if (isLoading) return null;
      if (isSetup && loc != '/setup') return '/setup';
      if (!isSetup && loc == '/setup') return isLoggedIn ? '/' : '/login';
      if (!isLoggedIn && !isSetup && loc != '/login') return '/login';
      if (isLoggedIn && loc == '/login') return '/';

      // ── Permission gates (only when authenticated) ────────────────────────
      // Use pattern match for Dart type narrowing — no cast needed.
      if (authState is AuthAuthenticated) {
        final user = authState.user;
        final perms = user.permissions.toSet();

        // Superadmin-only routes
        if (_isSuperadminRoute(loc) && user.role != 'superadmin') {
          return '/no-permission';
        }

        // Module-gated routes
        if (loc.startsWith('/tasks') &&
            !user.modules.contains('taskmap')) {
          return '/no-permission';
        }

        // Permission-gated routes
        final required = _requiredPermission(loc);
        if (required != null) {
          final category = required.split('.').first;
          final has =
              perms.contains(required) || perms.contains('$category.*');
          if (!has) return '/no-permission';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/setup',
        builder: (context, _) => const SetupScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, _) => const LoginScreen(),
      ),
      GoRoute(
        path: '/no-permission',
        builder: (context, _) => const NoPermissionScreen(),
      ),

      // ── Full-screen routes (outside the bottom-nav shell) ──────────────────
      // These screens build their own Scaffold + AppBar. Keeping them out of the
      // ShellRoute means no duplicate brand header, no bottom nav, and no
      // floating button overlapping their in-form actions.
      // Declared BEFORE the ShellRoute so static paths (…/new) win over the
      // shell's parametric detail routes (…/:id).
      GoRoute(
        path: '/clients/new',
        builder: (context, _) => const CreateClientScreen(),
      ),
      GoRoute(
        path: '/clients/:id/edit',
        builder: (_, state) {
          final client = state.extra as dynamic;
          return CreateClientScreen(existingClient: client);
        },
      ),
      GoRoute(
        path: '/invoices/new',
        builder: (context, _) => const CreateInvoiceScreen(),
      ),
      GoRoute(
        path: '/invoices/:id/edit',
        builder: (_, state) => EditInvoiceScreen(
          id: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '/budgets/new',
        builder: (context, _) => const CreateBudgetScreen(),
      ),
      GoRoute(
        path: '/budgets/:id',
        builder: (_, state) => BudgetDetailScreen(
          id: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '/sales/new',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return CreateSaleScreen(
            initialBudgetId: extra?['budgetId'] as int?,
            initialClientId: extra?['clientId'] as int?,
          );
        },
      ),
      GoRoute(
        path: '/sales/:id',
        builder: (_, state) => SaleDetailScreen(
          id: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '/catalog/products/new',
        builder: (_, _) => const CreateEditProductScreen(),
      ),
      GoRoute(
        path: '/catalog/products/:id/edit',
        builder: (_, state) {
          final product = state.extra as dynamic;
          return CreateEditProductScreen(existing: product);
        },
      ),
      GoRoute(
        path: '/catalog/products/:id',
        builder: (_, state) => ProductDetailScreen(
          id: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '/catalog/services/new',
        builder: (_, _) => const CreateEditServiceScreen(),
      ),
      GoRoute(
        path: '/catalog/services/:id/edit',
        builder: (_, state) {
          final service = state.extra as dynamic;
          return CreateEditServiceScreen(existing: service);
        },
      ),
      GoRoute(
        path: '/scan',
        builder: (context, _) => const ScanScreen(),
      ),
      GoRoute(
        path: '/scan/review',
        builder: (context, _) => const ScanReviewScreen(),
      ),
      GoRoute(
        path: '/permissions',
        builder: (context, _) => const PermissionsScreen(),
      ),

      // ── Bottom-nav shell (list + landing destinations) ─────────────────────
      ShellRoute(
        builder: (_, state, child) => AppShell(
          // Full request path (not matchedLocation, which collapses sub-routes
          // to their section) so chrome/FAB logic matches the exact screen.
          currentLocation: state.uri.path,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, _) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/clients',
            builder: (context, _) => const ClientsScreen(),
          ),
          GoRoute(
            path: '/clients/:id',
            builder: (_, state) => ClientDetailScreen(
              id: int.parse(state.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: '/invoices',
            builder: (context, _) => const InvoicesScreen(),
          ),
          GoRoute(
            path: '/invoices/:id',
            builder: (_, state) => InvoiceDetailScreen(
              id: int.parse(state.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: '/budgets',
            builder: (context, _) => const BudgetsScreen(),
          ),
          GoRoute(
            path: '/sales',
            builder: (context, _) => const SalesScreen(),
          ),
          GoRoute(
            path: '/purchases',
            builder: (context, _) => const PurchasesScreen(),
          ),
          GoRoute(
            path: '/tax',
            builder: (context, _) => const TaxReturnsScreen(),
          ),
          GoRoute(
            path: '/account',
            builder: (context, _) => const AccountScreen(),
          ),
          GoRoute(
            path: '/catalog',
            builder: (context, _) => const CatalogScreen(),
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, _) => const TasksScreen(),
          ),
        ],
      ),
    ],
  );
});
