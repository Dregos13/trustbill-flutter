import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_header.dart';
import 'app_bottom_nav.dart';
import '../core/auth/permission_helpers.dart';
import '../core/auth/permission_provider.dart';
import '../core/theme/app_colors.dart';
import '../features/scan/scan_provider.dart';
import '../features/taskmap/shared/tm_colors.dart';

class AppShell extends ConsumerWidget {
  final String currentLocation;
  final Widget child;

  const AppShell({
    super.key,
    required this.currentLocation,
    required this.child,
  });

  /// The shell FAB is reserved for **primary list/landing destinations** only.
  /// Create / edit / detail screens own their submit actions in-body, so the
  /// floating button is hidden there to avoid overlapping their buttons.
  Widget? _buildFab(BuildContext context, WidgetRef ref) {
    switch (currentLocation) {
      // ── /clients → "Nuevo cliente" (requires clients.write) ────────────────
      case '/clients':
        if (!ref.watch(hasPermissionProvider(Permissions.clientsWrite))) {
          return null;
        }
        return FloatingActionButton.extended(
          onPressed: () => context.push('/clients/new'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.person_add),
          label: const Text('Nuevo cliente'),
        );

      // ── /invoices → "Nueva factura" (requires documents.write) ─────────────
      case '/invoices':
        if (!ref.watch(hasPermissionProvider(Permissions.documentsWrite))) {
          return null;
        }
        return FloatingActionButton.extended(
          onPressed: () => context.push('/invoices/new'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: const Text('Nueva factura'),
        );

      // ── /budgets → "Nuevo presupuesto" (requires documents.write) ──────────
      case '/budgets':
        if (!ref.watch(hasPermissionProvider(Permissions.documentsWrite))) {
          return null;
        }
        return FloatingActionButton.extended(
          onPressed: () => context.push('/budgets/new'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: const Text('Nuevo presupuesto'),
        );

      // ── /sales → "Nueva venta" (requires documents.write) ──────────────────
      case '/sales':
        if (!ref.watch(hasPermissionProvider(Permissions.documentsWrite))) {
          return null;
        }
        return FloatingActionButton.extended(
          onPressed: () => context.push('/sales/new'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: const Text('Nueva venta'),
        );

      // ── Inicio + Compras → scanner FAB (requires expenses.write) ───────────
      case '/':
      case '/purchases':
        if (!ref.watch(hasPermissionProvider(Permissions.expensesWrite))) {
          return null;
        }
        return FloatingActionButton(
          onPressed: () => _showScanTypeSheet(context, ref),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          child: const Icon(Icons.document_scanner),
        );

      // ── /tasks → "Nueva tarea" (requires tasks.write) ─────────────────────
      case '/tasks':
        if (!ref.watch(hasPermissionProvider(Permissions.tasksWrite))) {
          return null;
        }
        return FloatingActionButton.extended(
          onPressed: () => context.push('/task/new'),
          backgroundColor: TmColors.accent,
          foregroundColor: const Color(0xFF06212E),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Nueva tarea'),
        );

      // ── Everything else (forms, detail, catalog, tax, account…) → no FAB ───
      default:
        return null;
    }
  }

  void _showScanTypeSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ScanTypeSheet(
        onSelected: (type) {
          ref.read(scanProvider.notifier).setScanType(type);
          context.push('/scan');
        },
      ),
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
            AppHeader(currentLocation: currentLocation),
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

// ── Scan type bottom sheet ────────────────────────────────────────────────────

class _ScanTypeSheet extends StatelessWidget {
  final void Function(ScanType) onSelected;
  const _ScanTypeSheet({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.gray300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '¿Qué quieres escanear?',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Elige el tipo de documento para escanear',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.gray500,
                ),
          ),
          const SizedBox(height: 24),
          _TypeCard(
            icon: Icons.receipt_long,
            color: const Color(0xFF0EA5E9),
            title: 'Gasto',
            subtitle: 'Facturas y tickets de proveedores',
            onTap: () {
              Navigator.of(context).pop();
              onSelected(ScanType.expense);
            },
          ),
          const SizedBox(height: 12),
          _TypeCard(
            icon: Icons.description_outlined,
            color: AppColors.primary,
            title: 'Factura emitida',
            subtitle: 'Facturas que has emitido a clientes',
            onTap: () {
              Navigator.of(context).pop();
              onSelected(ScanType.invoice);
            },
          ),
        ],
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _TypeCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.gray500,
                        ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color.withValues(alpha: 0.6)),
          ],
        ),
      ),
    );
  }
}
