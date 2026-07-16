import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/permission_helpers.dart';
import '../../core/models/user_permissions.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/error_messages.dart';

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
      body: usersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              friendlyError(e, fallback: 'No se pudieron cargar los usuarios. Intenta de nuevo.'),
              textAlign: TextAlign.center,
              style: TextStyle(color: context.statusDanger),
            ),
          ),
        ),
        data: (users) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Permisos de usuarios',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: context.appText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Gestiona qué secciones puede usar cada miembro del equipo.',
              style: TextStyle(fontSize: 13, color: context.appTextMuted),
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
    final roleColor = _roleColor(context, user.role);

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
          color: context.appSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.appBorder),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: context.appPrimarySoft,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: TextStyle(
                  color: context.appPrimary,
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
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: context.appText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.email,
                    style: TextStyle(
                        fontSize: 12, color: context.appTextMuted),
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
                color: roleColor.withValues(alpha: 0.12),
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
              Icon(Icons.chevron_right,
                  size: 18, color: context.appTextSubtle),
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

  Color _roleColor(BuildContext context, String role) {
    switch (role) {
      case 'superadmin':
        return context.statusDanger;
      case 'admin':
        return context.statusWarning;
      default:
        return context.appPrimary;
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
        SnackBar(
          content: const Text('Permisos actualizados correctamente.'),
          backgroundColor: context.statusSuccess,
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(friendlyError(e, fallback: 'No se pudieron guardar los permisos. Intenta de nuevo.')),
          backgroundColor: context.statusDanger,
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.appSurface,
        foregroundColor: context.appText,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              size: 18, color: context.appTextMuted),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: context.appText,
              ),
            ),
            Text(
              widget.user.email,
              style: TextStyle(
                  fontSize: 11, color: context.appTextMuted),
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
                    color: context.appPrimarySoft,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: context.appPrimary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          size: 16, color: context.appPrimary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Los cambios tienen efecto en el próximo inicio de sesión del usuario.',
                          style: TextStyle(
                              fontSize: 12, color: context.appPrimary),
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
                  backgroundColor: context.appPrimary,
                  foregroundColor: context.onPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _saving
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: context.onPrimary),
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
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: context.appTextSubtle,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.appBorder),
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
                      style: TextStyle(
                        fontSize: 14,
                        color: context.appText,
                      ),
                    ),
                    value: isOn,
                    activeThumbColor: context.appPrimary,
                    activeTrackColor: context.appPrimarySoft,
                    onChanged: (v) => onToggle(def.key, v),
                  ),
                  if (!isLast)
                    Divider(
                        height: 1, indent: 16, color: context.appBorder),
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
