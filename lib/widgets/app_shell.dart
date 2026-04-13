import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_header.dart';
import 'app_bottom_nav.dart';
import '../core/auth/permission_helpers.dart';
import '../core/auth/permission_provider.dart';
import '../core/theme/app_colors.dart';

class AppShell extends ConsumerWidget {
  final String currentLocation;
  final Widget child;

  const AppShell({
    super.key,
    required this.currentLocation,
    required this.child,
  });

  Widget? _buildFab(BuildContext context, WidgetRef ref) {
    // ── /clients → "Nuevo cliente" (requires clients.write) ──────────────────
    if (currentLocation == '/clients') {
      final can = ref.watch(hasPermissionProvider(Permissions.clientsWrite));
      if (!can) return null;
      return FloatingActionButton.extended(
        onPressed: () => context.push('/clients/new'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add),
        label: const Text('Nuevo cliente'),
      );
    }

    // ── /invoices → "Nueva factura" (requires documents.write) ───────────────
    if (currentLocation == '/invoices') {
      final can = ref.watch(hasPermissionProvider(Permissions.documentsWrite));
      if (!can) return null;
      return FloatingActionButton.extended(
        onPressed: () => context.push('/invoices/new'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nueva factura'),
      );
    }

    // ── default → scanner FAB (requires expenses.write) ──────────────────────
    final canScan = ref.watch(hasPermissionProvider(Permissions.expensesWrite));
    if (!canScan) return null;
    return FloatingActionButton(
      onPressed: () => context.push('/scan'),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      child: const Icon(Icons.document_scanner),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: currentLocation == '/',
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          context.go('/');
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const AppHeader(),
            Expanded(child: child),
          ],
        ),
        floatingActionButton: _buildFab(context, ref),
        bottomNavigationBar: AppBottomNav(
          currentLocation: currentLocation,
          onNavigate: (path) => context.go(path),
        ),
      ),
    );
  }
}
