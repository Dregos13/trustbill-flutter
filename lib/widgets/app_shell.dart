import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_header.dart';
import 'app_bottom_nav.dart';
import '../core/auth/permission_helpers.dart';
import '../core/auth/permission_provider.dart';
import '../core/theme/app_colors.dart';
import '../features/scan/scan_provider.dart';

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
      onPressed: () => _showScanTypeSheet(context, ref),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      child: const Icon(Icons.document_scanner),
    );
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
