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

      // ── /suppliers → "Nuevo proveedor" (requires expenses.write) ─────────
      case '/suppliers':
        if (!ref.watch(hasPermissionProvider(Permissions.expensesWrite))) {
          return null;
        }
        return FloatingActionButton.extended(
          onPressed: () => context.push('/suppliers/new'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.storefront_outlined),
          label: const Text('Nuevo proveedor'),
        );

      // ── Inicio + Compras → hub de acciones (Asistente IA + escanear) ───────
      // Aparece si el usuario puede escanear (expenses.write) O usar el
      // asistente (documents.read). Cada acción se muestra según su permiso.
      case '/':
      case '/purchases':
        {
          final canScan =
              ref.watch(hasPermissionProvider(Permissions.expensesWrite));
          final canAssistant =
              ref.watch(hasPermissionProvider(Permissions.documentsRead));
          if (!canScan && !canAssistant) return null;
          return FloatingActionButton(
            onPressed: () => _showActionHub(
              context,
              ref,
              canScan: canScan,
              canAssistant: canAssistant,
            ),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 4,
            child: const Icon(Icons.auto_awesome),
          );
        }

      // ── /tasks + /map → "Nueva tarea" (requires tasks.write) ──────────────
      case '/tasks':
      case '/map':
        if (!ref.watch(hasPermissionProvider(Permissions.tasksWrite))) {
          return null;
        }
        return FloatingActionButton.extended(
          onPressed: () => context.push('/task/new'),
          backgroundColor: context.tm.accent,
          foregroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF06212E)
              : Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Nueva tarea'),
        );

      // ── Everything else (forms, detail, catalog, tax, account…) → no FAB ───
      default:
        return null;
    }
  }

  void _showActionHub(
    BuildContext context,
    WidgetRef ref, {
    required bool canScan,
    required bool canAssistant,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ActionHubSheet(
        canScan: canScan,
        canAssistant: canAssistant,
        onAssistant: () => context.push('/assistant'),
        onScan: (type) {
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

// ── Action hub bottom sheet (Asistente IA + escanear) ─────────────────────────

class _ActionHubSheet extends StatelessWidget {
  final bool canScan;
  final bool canAssistant;
  final VoidCallback onAssistant;
  final void Function(ScanType) onScan;

  const _ActionHubSheet({
    required this.canScan,
    required this.canAssistant,
    required this.onAssistant,
    required this.onScan,
  });

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gray300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              '¿Qué necesitas?',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 20),

          // ── Asistente IA (héroe) ───────────────────────────────────────────
          if (canAssistant) ...[
            _AssistantHeroCard(
              onTap: () {
                Navigator.of(context).pop();
                onAssistant();
              },
            ),
            if (canScan) const SizedBox(height: 22),
          ],

          // ── Escanear documento ─────────────────────────────────────────────
          if (canScan) ...[
            Text(
              'Escanear documento',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.gray500,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            _TypeCard(
              icon: Icons.receipt_long,
              color: const Color(0xFF0EA5E9),
              title: 'Gasto',
              subtitle: 'Facturas y tickets de proveedores',
              onTap: () {
                Navigator.of(context).pop();
                onScan(ScanType.expense);
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
                onScan(ScanType.invoice);
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _AssistantHeroCard extends StatelessWidget {
  final VoidCallback onTap;
  const _AssistantHeroCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Asistente IA',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'NUEVO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Pídemelo hablando o escribiendo',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
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
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.gray500),
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
