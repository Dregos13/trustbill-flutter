import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/auth_state.dart';
import '../../core/utils/error_messages.dart';
import '../../core/auth/permission_provider.dart';

// ── Providers ─────────────────────────────────────────────────────────────────

final _companyLogoProvider = FutureProvider.autoDispose<Uint8List?>((
  ref,
) async {
  final endpoints = ref.watch(endpointsProvider);
  return endpoints.getCompanyLogo();
});

final _companySettingsProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
      final endpoints = ref.watch(endpointsProvider);
      return endpoints.getCompanySettings();
    });

// ── Screen ────────────────────────────────────────────────────────────────────

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState is! AuthAuthenticated) {
      return const SizedBox.shrink();
    }

    final user = authState.user;
    final companies = authState.companies;
    final activeCompanyId = authState.activeCompanyId;
    final clientId = authState.clientId;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Cuenta',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: context.appText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user.name,
          style: TextStyle(fontSize: 14, color: context.appTextMuted),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: context.appSurfaceRaised,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.dns_outlined, size: 16, color: context.appTextSubtle),
              const SizedBox(width: 8),
              Text(
                'app.$clientId.trustinfacts.com',
                style: TextStyle(
                  fontSize: 12,
                  color: context.appTextMuted,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ── Datos de la empresa (solo admin/superadmin puede editar) ──
        _CompanyDetailsSection(),
        const SizedBox(height: 24),

        // ── Logo de empresa ────────────────────────────────────────
        _CompanyLogoSection(),
        const SizedBox(height: 24),

        const _AppearanceSection(),
        const SizedBox(height: 24),

        // ── Empresas ───────────────────────────────────────────────
        Text(
          'Empresas',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: context.appText,
          ),
        ),
        const SizedBox(height: 12),
        ...companies.map((company) {
          final isActive = company.id == activeCompanyId;
          return _CompanyCard(
            name: company.name,
            isActive: isActive,
            onTap: isActive
                ? null
                : () async {
                    await ref
                        .read(authProvider.notifier)
                        .switchCompany(company.id);
                  },
          );
        }),
        const SizedBox(height: 32),

        // ── Administración (solo superadmin) ───────────────────────────────
        if (ref.watch(isSuperadminProvider)) ...[
          Text(
            'Administración',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: context.appText,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => context.push('/permissions'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: context.appSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.appBorder),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: context.statusInfoSoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.admin_panel_settings_outlined,
                      size: 18,
                      color: context.statusInfo,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gestión de permisos',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Configura qué puede hacer cada usuario',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: context.appTextSubtle,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],

        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.statusDangerSoft,
              foregroundColor: context.statusDanger,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Cerrar sesion',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppearanceSection extends ConsumerWidget {
  const _AppearanceSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: context.appPrimarySoft,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : themeMode == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.brightness_auto,
                  color: context.appPrimary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Apariencia',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: context.appPrimary,
              selectedForegroundColor: Colors.white,
            ),
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.brightness_auto, size: 16),
                label: Text('Sistema'),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode, size: 16),
                label: Text('Claro'),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode, size: 16),
                label: Text('Oscuro'),
              ),
            ],
            selected: {themeMode},
            onSelectionChanged: (selection) {
              ref
                  .read(themeControllerProvider.notifier)
                  .setThemeMode(selection.first);
            },
          ),
        ],
      ),
    );
  }
}

// ── Datos de empresa (contacto/facturacion, sin fiscalidad ni banco) ───────────

class _CompanyDetailsSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CompanyDetailsSection> createState() =>
      _CompanyDetailsSectionState();
}

class _CompanyDetailsSectionState
    extends ConsumerState<_CompanyDetailsSection> {
  bool _editing = false;
  bool _saving = false;
  final _nameCtrl = TextEditingController();
  final _tradeNameCtrl = TextEditingController();
  final _taxIdCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _postalCodeCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _tradeNameCtrl.dispose();
    _taxIdCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _postalCodeCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  void _startEditing(Map<String, dynamic> settings) {
    _nameCtrl.text = settings['name'] as String? ?? '';
    _tradeNameCtrl.text = settings['tradeName'] as String? ?? '';
    _taxIdCtrl.text = settings['taxId'] as String? ?? '';
    _emailCtrl.text = settings['email'] as String? ?? '';
    _phoneCtrl.text = settings['phone'] as String? ?? '';
    _addressCtrl.text = settings['address'] as String? ?? '';
    _postalCodeCtrl.text = settings['postalCode'] as String? ?? '';
    _cityCtrl.text = settings['city'] as String? ?? '';
    setState(() => _editing = true);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final endpoints = ref.read(endpointsProvider);
      await endpoints.updateCompanySettings({
        'name': _nameCtrl.text.trim(),
        'tradeName': _tradeNameCtrl.text.trim(),
        'taxId': _taxIdCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'phone': _phoneCtrl.text.trim(),
        'address': _addressCtrl.text.trim(),
        'postalCode': _postalCodeCtrl.text.trim(),
        'city': _cityCtrl.text.trim(),
      });
      ref.invalidate(_companySettingsProvider);
      if (!mounted) return;
      setState(() => _editing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Datos de la empresa actualizados.'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            friendlyError(e, fallback: 'No se pudo guardar la empresa.'),
          ),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(_companySettingsProvider);
    final canEdit = ref.watch(isAdminOrAboveProvider);

    return settingsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (settings) =>
          _editing ? _buildEditForm() : _buildReadOnly(settings, canEdit),
    );
  }

  Widget _buildReadOnly(Map<String, dynamic> settings, bool canEdit) {
    String orPending(Object? v) {
      final text = v?.toString().trim() ?? '';
      return text.isEmpty ? 'Pendiente' : text;
    }

    final address = orPending(settings['address']);
    final postalCode = orPending(settings['postalCode']);
    final city = settings['city']?.toString().trim() ?? '';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Datos de la empresa',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: context.appText,
                ),
              ),
              if (canEdit)
                TextButton(
                  onPressed: () => _startEditing(settings),
                  child: const Text('Editar'),
                ),
            ],
          ),
          const SizedBox(height: 6),
          _InfoRow(label: 'Razón social', value: orPending(settings['name'])),
          _InfoRow(
            label: 'Nombre comercial',
            value: orPending(settings['tradeName']),
          ),
          _InfoRow(label: 'CIF/NIF', value: orPending(settings['taxId'])),
          _InfoRow(label: 'Email', value: orPending(settings['email'])),
          _InfoRow(label: 'Teléfono', value: orPending(settings['phone'])),
          _InfoRow(
            label: 'Dirección',
            value: '$address · $postalCode $city'.trim(),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Editar datos de la empresa',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: context.appText,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Razón social'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _tradeNameCtrl,
            decoration: const InputDecoration(labelText: 'Nombre comercial'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _taxIdCtrl,
            decoration: const InputDecoration(labelText: 'CIF/NIF'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _emailCtrl,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _phoneCtrl,
            decoration: const InputDecoration(labelText: 'Teléfono'),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _addressCtrl,
            decoration: const InputDecoration(labelText: 'Dirección'),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _postalCodeCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Código postal',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _cityCtrl,
                  decoration: const InputDecoration(labelText: 'Ciudad'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _saving
                      ? null
                      : () => setState(() => _editing = false),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _saving ? null : _save,
                  child: Text(_saving ? 'Guardando...' : 'Guardar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: context.appTextMuted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: context.appText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Logo section ──────────────────────────────────────────────────────────────

class _CompanyLogoSection extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CompanyLogoSection> createState() =>
      _CompanyLogoSectionState();
}

class _CompanyLogoSectionState extends ConsumerState<_CompanyLogoSection> {
  bool _uploading = false;
  final _picker = ImagePicker();

  Future<void> _pickAndUpload() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
      maxWidth: 800,
    );
    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    final mimeType = picked.mimeType ?? _mimeFromPath(picked.path);

    setState(() => _uploading = true);
    try {
      final endpoints = ref.read(endpointsProvider);
      await endpoints.uploadCompanyLogo(imageBytes: bytes, mimeType: mimeType);

      ref.invalidate(_companyLogoProvider);
      ref.invalidate(_companySettingsProvider);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logo actualizado correctamente.'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            friendlyError(
              e,
              fallback:
                  'No se pudo actualizar el logo. Intenta con otra imagen.',
            ),
          ),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  String _mimeFromPath(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(_companySettingsProvider);
    final logoAsync = ref.watch(_companyLogoProvider);

    final hasLogo = settingsAsync.asData?.value['hasLogo'] == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Logo de empresa',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: context.appText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Se usa en las facturas generadas desde la app.',
          style: TextStyle(fontSize: 12, color: context.appTextMuted),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // Logo preview box
            Container(
              width: 130,
              height: 56,
              decoration: BoxDecoration(
                color: context.appSurfaceRaised,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.appBorder),
              ),
              clipBehavior: Clip.antiAlias,
              child: hasLogo
                  ? logoAsync.when(
                      loading: () => const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      error: (_, _) => Icon(
                        Icons.broken_image_outlined,
                        color: context.appTextSubtle,
                      ),
                      data: (bytes) => bytes != null
                          ? Image.memory(
                              bytes,
                              fit: BoxFit.contain,
                              width: 130,
                              height: 56,
                            )
                          : Icon(
                              Icons.image_outlined,
                              color: context.appTextSubtle,
                            ),
                    )
                  : Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: context.appTextSubtle,
                        size: 28,
                      ),
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!hasLogo)
                    Text(
                      'Sin logo configurado',
                      style: TextStyle(
                        fontSize: 13,
                        color: context.appTextMuted,
                      ),
                    ),
                  if (hasLogo)
                    const Text(
                      'Logo activo',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _uploading ? null : _pickAndUpload,
                      icon: _uploading
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primary,
                              ),
                            )
                          : const Icon(Icons.upload, size: 16),
                      label: Text(
                        _uploading
                            ? 'Subiendo...'
                            : hasLogo
                            ? 'Cambiar logo'
                            : 'Subir logo',
                        style: const TextStyle(fontSize: 13),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'JPEG, PNG o WebP · max 2 MB',
                    style: TextStyle(
                      fontSize: 10,
                      color: context.appTextSubtle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Company card ──────────────────────────────────────────────────────────────

class _CompanyCard extends StatelessWidget {
  final String name;
  final bool isActive;
  final VoidCallback? onTap;

  const _CompanyCard({required this.name, required this.isActive, this.onTap});

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? context.appPrimary : context.appBorder,
            width: isActive ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isActive ? context.appPrimary : context.appBorder,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: TextStyle(
                  color: isActive ? Colors.white : context.appTextMuted,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: context.appText,
                ),
              ),
            ),
            if (isActive)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: context.statusInfoSoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Activa',
                  style: TextStyle(
                    color: context.statusInfo,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
