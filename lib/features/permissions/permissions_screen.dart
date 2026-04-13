import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/permission_helpers.dart';
import '../../core/models/user_permissions.dart';
import '../../core/theme/app_colors.dart';

// ── Providers ──────────────────────────────────────────────────────────────────

final _usersProvider = FutureProvider.autoDispose<List<UserWithPermissions>>(
  (ref) async {
    final endpoints = ref.watch(endpointsProvider);
    return endpoints.getUsers();
  },
);

// ── Permissions screen (user list) ────────────────────────────────────────────

class PermissionsScreen extends ConsumerWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(_usersProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: usersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Error al cargar usuarios: $e',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ),
        data: (users) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Permisos de usuarios',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Gestiona qué secciones puede usar cada miembro del equipo.',
              style: TextStyle(fontSize: 13, color: AppColors.gray500),
            ),
            const SizedBox(height: 20),
            ...users.map((user) => _UserPermissionCard(user: user)),
          ],
        ),
      ),
    );
  }
}

// ── User card ──────────────────────────────────────────────────────────────────

class _UserPermissionCard extends StatelessWidget {
  final UserWithPermissions user;

  const _UserPermissionCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final initial = user.name.isNotEmpty ? user.name[0].toUpperCase() : '?';
    final roleLabel = _roleLabel(user.role);
    final roleColor = _roleColor(user.role);

    return GestureDetector(
      onTap: user.hasImplicitPermissions
          ? null
          : () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => _UserPermissionsDetail(user: user),
                ),
              );
            },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.gray200),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primaryBg,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Name + email
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.email,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.gray500),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Role badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: roleColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                roleLabel,
                style: TextStyle(
                  color: roleColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (!user.hasImplicitPermissions) ...[
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right,
                  size: 18, color: AppColors.gray400),
            ],
          ],
        ),
      ),
    );
  }

  String _roleLabel(String role) {
    switch (role) {
      case 'superadmin':
        return 'Superadmin';
      case 'admin':
        return 'Admin';
      default:
        return 'Usuario';
    }
  }

  Color _roleColor(String role) {
    switch (role) {
      case 'superadmin':
        return AppColors.danger;
      case 'admin':
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }
}

// ── User permissions detail screen ────────────────────────────────────────────

class _UserPermissionsDetail extends ConsumerStatefulWidget {
  final UserWithPermissions user;

  const _UserPermissionsDetail({required this.user});

  @override
  ConsumerState<_UserPermissionsDetail> createState() =>
      _UserPermissionsDetailState();
}

class _UserPermissionsDetailState
    extends ConsumerState<_UserPermissionsDetail> {
  late Set<String> _selected;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.user.permissions.toSet();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final endpoints = ref.read(endpointsProvider);
      await endpoints.updateUserPermissions(
          widget.user.id, _selected.toList());

      // Invalidate the users list so it refreshes on back
      ref.invalidate(_usersProvider);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permisos actualizados correctamente.'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar: $e'),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: AppColors.gray700),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.gray900,
              ),
            ),
            Text(
              widget.user.email,
              style: const TextStyle(
                  fontSize: 11, color: AppColors.gray500),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Info notice
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline,
                          size: 16, color: AppColors.primary),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Los cambios tienen efecto en el próximo inicio de sesión del usuario.',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Permission groups
                ...permissionCatalog.map(
                  (group) => _PermissionGroupSection(
                    group: group,
                    selected: _selected,
                    onToggle: (key, value) {
                      setState(() {
                        if (value) {
                          _selected.add(key);
                        } else {
                          _selected.remove(key);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Save button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Text(
                        'Guardar cambios',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Permission group section ───────────────────────────────────────────────────

class _PermissionGroupSection extends StatelessWidget {
  final PermissionGroup group;
  final Set<String> selected;
  final void Function(String key, bool value) onToggle;

  const _PermissionGroupSection({
    required this.group,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            group.title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.gray400,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gray200),
          ),
          child: Column(
            children: group.permissions.asMap().entries.map((entry) {
              final idx = entry.key;
              final def = entry.value;
              final isLast = idx == group.permissions.length - 1;
              final isOn = selected.contains(def.key);

              return Column(
                children: [
                  SwitchListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 2),
                    title: Text(
                      def.label,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.gray900,
                      ),
                    ),
                    value: isOn,
                    activeThumbColor: AppColors.primary,
                    activeTrackColor: AppColors.primaryBg,
                    onChanged: (v) => onToggle(def.key, v),
                  ),
                  if (!isLast)
                    const Divider(
                        height: 1, indent: 16, color: AppColors.gray100),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
