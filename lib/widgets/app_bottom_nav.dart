import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/auth/permission_helpers.dart';
import '../core/auth/permission_provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme_tokens.dart';

// ── Tab definition ─────────────────────────────────────────────────────────────

class _TabDef {
  final String route;
  final String routePrefix;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  /// null = always visible (no permission required)
  final String? requiredPermission;
  /// null = no module gate; non-null = module must be in user.modules
  final String? requiredModule;

  const _TabDef({
    required this.route,
    required this.routePrefix,
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.requiredPermission,
    this.requiredModule,
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
    route: '/catalog',
    routePrefix: '/catalog',
    icon: Icons.inventory_2_outlined,
    activeIcon: Icons.inventory_2,
    label: 'Catálogo',
    requiredPermission: Permissions.productsRead,
  ),
  _TabDef(
    route: '/tasks',
    routePrefix: '/tasks',
    icon: Icons.map_outlined,
    activeIcon: Icons.map,
    label: 'Tareas',
    requiredPermission: Permissions.tasksRead,
    requiredModule: 'taskmap',
  ),
];

const _maxPinnedTabs = 4;

// ── Provider: visible tabs ─────────────────────────────────────────────────────

/// List of tabs visible to the current user based on their permissions and enabled modules.
final visibleTabsProvider = Provider<List<_TabDef>>((ref) {
  final perms = ref.watch(permissionsProvider);
  return _allTabs.where((tab) {
    if (tab.requiredModule != null &&
        !ref.read(hasModuleProvider(tab.requiredModule!))) {
      return false;
    }
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

  bool _matchesTab(_TabDef tab, String loc) {
    if (tab.route == '/') return loc == '/';
    return loc.startsWith(tab.routePrefix);
  }

  int _currentIndex(List<_TabDef> pinned, List<_TabDef> overflow) {
    var loc = currentLocation;
    if (loc.startsWith('/budgets') || loc.startsWith('/sales')) {
      loc = '/invoices';
    }
    for (int i = 0; i < pinned.length; i++) {
      if (_matchesTab(pinned[i], loc)) return i;
    }
    // If current route is in overflow, highlight "Más" tab
    final inOverflow = overflow.any((t) => _matchesTab(t, loc));
    if (inOverflow) return pinned.length; // "Más" index
    return 0;
  }

  void _showMoreSheet(
    BuildContext context,
    List<_TabDef> overflow,
    String currentLocation,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _MoreSheet(
        tabs: overflow,
        currentLocation: currentLocation,
        onNavigate: (route) {
          Navigator.of(context).pop();
          onNavigate(route);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = ref.watch(visibleTabsProvider);

    final pinned = tabs.length <= _maxPinnedTabs
        ? tabs
        : tabs.sublist(0, _maxPinnedTabs);
    final overflow = tabs.length <= _maxPinnedTabs
        ? <_TabDef>[]
        : tabs.sublist(_maxPinnedTabs);

    final activeIdx = _currentIndex(pinned, overflow);
    final overflowActive = overflow.isNotEmpty && activeIdx == pinned.length;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
            children: [
              ...pinned.asMap().entries.map((entry) => _NavItem(
                    icon: entry.value.icon,
                    activeIcon: entry.value.activeIcon,
                    label: entry.value.label,
                    isActive: entry.key == activeIdx,
                    onTap: () => onNavigate(entry.value.route),
                  )),
              if (overflow.isNotEmpty)
                _NavItem(
                  icon: Icons.more_horiz,
                  activeIcon: Icons.more_horiz,
                  label: 'Más',
                  isActive: overflowActive,
                  onTap: () =>
                      _showMoreSheet(context, overflow, currentLocation),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── More bottom sheet ──────────────────────────────────────────────────────────

class _MoreSheet extends StatelessWidget {
  final List<_TabDef> tabs;
  final String currentLocation;
  final ValueChanged<String> onNavigate;

  const _MoreSheet({
    required this.tabs,
    required this.currentLocation,
    required this.onNavigate,
  });

  bool _isActive(_TabDef tab) {
    var loc = currentLocation;
    if (loc.startsWith('/budgets') || loc.startsWith('/sales')) {
      loc = '/invoices';
    }
    if (tab.route == '/') return loc == '/';
    return loc.startsWith(tab.routePrefix);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: context.appBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          ...tabs.map((tab) {
            final active = _isActive(tab);
            final color = active ? AppColors.primary : context.appText;
            return InkWell(
              onTap: () => onNavigate(tab.route),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: Row(
                  children: [
                    Icon(
                      active ? tab.activeIcon : tab.icon,
                      color: color,
                      size: 22,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      tab.label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            active ? FontWeight.w700 : FontWeight.w500,
                        color: color,
                      ),
                    ),
                    if (active) ...[
                      const Spacer(),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
        ],
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
