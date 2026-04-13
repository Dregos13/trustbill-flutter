import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/auth/permission_helpers.dart';
import '../core/auth/permission_provider.dart';
import '../core/theme/app_colors.dart';

// ── Tab definition ─────────────────────────────────────────────────────────────

class _TabDef {
  final String route;
  final String routePrefix;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  /// null = always visible (no permission required)
  final String? requiredPermission;

  const _TabDef({
    required this.route,
    required this.routePrefix,
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.requiredPermission,
  });
}

const _allTabs = [
  _TabDef(
    route: '/',
    routePrefix: '/',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    label: 'Inicio',
    requiredPermission: Permissions.reportsRead,
  ),
  _TabDef(
    route: '/clients',
    routePrefix: '/clients',
    icon: Icons.people_outline,
    activeIcon: Icons.people,
    label: 'Clientes',
    requiredPermission: Permissions.clientsRead,
  ),
  _TabDef(
    route: '/invoices',
    routePrefix: '/invoices',
    icon: Icons.description_outlined,
    activeIcon: Icons.description,
    label: 'Facturas',
    requiredPermission: Permissions.documentsRead,
  ),
  _TabDef(
    route: '/purchases',
    routePrefix: '/purchases',
    icon: Icons.shopping_bag_outlined,
    activeIcon: Icons.shopping_bag,
    label: 'Compras',
    requiredPermission: Permissions.expensesRead,
  ),
  _TabDef(
    route: '/account',
    routePrefix: '/account',
    icon: Icons.settings_outlined,
    activeIcon: Icons.settings,
    label: 'Cuenta',
    requiredPermission: null, // always visible
  ),
];

// ── Provider: visible tabs ─────────────────────────────────────────────────────

/// List of tabs visible to the current user based on their permissions.
final visibleTabsProvider = Provider<List<_TabDef>>((ref) {
  final perms = ref.watch(permissionsProvider);
  return _allTabs.where((tab) {
    if (tab.requiredPermission == null) return true;
    final key = tab.requiredPermission!;
    final category = key.split('.').first;
    return perms.contains(key) || perms.contains('$category.*');
  }).toList();
});

// ── Widget ─────────────────────────────────────────────────────────────────────

class AppBottomNav extends ConsumerWidget {
  final String currentLocation;
  final ValueChanged<String> onNavigate;

  const AppBottomNav({
    super.key,
    required this.currentLocation,
    required this.onNavigate,
  });

  int _currentIndex(List<_TabDef> tabs) {
    for (int i = 0; i < tabs.length; i++) {
      final tab = tabs[i];
      if (tab.route == '/' && currentLocation == '/') return i;
      if (tab.route != '/' && currentLocation.startsWith(tab.routePrefix)) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = ref.watch(visibleTabsProvider);
    final activeIdx = _currentIndex(tabs);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabs
                .asMap()
                .entries
                .map((entry) => _NavItem(
                      icon: entry.value.icon,
                      activeIcon: entry.value.activeIcon,
                      label: entry.value.label,
                      isActive: entry.key == activeIdx,
                      onTap: () => onNavigate(entry.value.route),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

// ── Nav item ───────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.gray400;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
