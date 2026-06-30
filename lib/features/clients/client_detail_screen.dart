import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/client.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import 'create_client_screen.dart';

final clientDetailProvider = FutureProvider.autoDispose.family<Client, int>((
  ref,
  id,
) async {
  final endpoints = ref.read(endpointsProvider);
  return endpoints.getClient(id);
});

class ClientDetailScreen extends ConsumerWidget {
  final int id;

  const ClientDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientAsync = ref.watch(clientDetailProvider(id));

    return clientAsync.when(
      loading: () => const LoadingIndicator(),
      error: (err, _) => EmptyState(
        message: err is ApiError ? err.message : 'Error al cargar el cliente',
      ),
      data: (client) => _buildContent(context, ref, client),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, Client client) {
    final initial = client.name.isNotEmpty ? client.name[0].toUpperCase() : '?';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/clients');
                }
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: context.appSurfaceRaised,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 18,
                  color: context.appTextMuted,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: context.appPrimarySoft,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: TextStyle(
                  color: context.appPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: context.appText,
                    ),
                  ),
                  Text(
                    client.taxId,
                    style: TextStyle(fontSize: 13, color: context.appTextMuted),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined, color: context.appPrimary),
              tooltip: 'Editar cliente',
              onPressed: () async {
                final updated = await Navigator.of(context).push<Client>(
                  MaterialPageRoute(
                    builder: (_) => CreateClientScreen(existingClient: client),
                  ),
                );
                if (updated != null) {
                  ref.invalidate(clientDetailProvider(id));
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Quick action buttons
        if (client.phone != null && client.phone!.isNotEmpty) ...[
          _buildQuickActions(context, client),
          const SizedBox(height: 16),
        ],

        // Details card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.appSurfaceRaised,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.appBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Datos de contacto',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: context.appText,
                ),
              ),
              const SizedBox(height: 14),
              _detailRow(
                context,
                Icons.badge_outlined,
                'NIF/CIF',
                client.taxId,
              ),
              if (client.email != null && client.email!.isNotEmpty)
                _detailRow(
                  context,
                  Icons.email_outlined,
                  'Email',
                  client.email!,
                ),
              if (client.phone != null && client.phone!.isNotEmpty)
                _tappableDetailRow(
                  context,
                  Icons.phone_outlined,
                  'Teléfono',
                  client.phone!,
                  trailingIcon: Icons.adaptive.more,
                  onTap: () => _showPhoneOptions(context, client.phone!),
                ),
              if (client.address != null && client.address!.isNotEmpty)
                _tappableDetailRow(
                  context,
                  Icons.location_on_outlined,
                  'Dirección',
                  _fullAddress(client),
                  trailingIcon: Icons.open_in_new_rounded,
                  onTap: () => _launchMaps(context, _fullAddress(client)),
                ),
              if (client.postalCode.isNotEmpty || client.city.isNotEmpty)
                _detailRow(
                  context,
                  Icons.map_outlined,
                  'Localidad',
                  [
                    client.postalCode,
                    client.city,
                  ].where((s) => s.isNotEmpty).join(', '),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _fullAddress(Client client) {
    return [
      if (client.address != null && client.address!.isNotEmpty) client.address!,
      if (client.postalCode.isNotEmpty) client.postalCode,
      if (client.city.isNotEmpty) client.city,
    ].join(', ');
  }

  Widget _buildQuickActions(BuildContext context, Client client) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionButton(
            icon: Icons.chat_rounded,
            label: 'WhatsApp',
            color: const Color(0xFF25D366),
            onTap: () => _launchWhatsApp(context, client.phone!),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.call_rounded,
            label: 'Llamar',
            color: context.appPrimary,
            onTap: () => _launchCall(context, client.phone!),
          ),
        ),
        if (client.address != null && client.address!.isNotEmpty) ...[
          const SizedBox(width: 10),
          Expanded(
            child: _QuickActionButton(
              icon: Icons.directions_rounded,
              label: 'Mapa',
              color: const Color(0xFF4285F4),
              onTap: () => _launchMaps(context, _fullAddress(client)),
            ),
          ),
        ],
      ],
    );
  }

  Widget _detailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: context.appTextSubtle),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: context.appTextSubtle,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.appText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tappableDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    required VoidCallback onTap,
    IconData? trailingIcon,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: context.appPrimary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: context.appTextSubtle,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: context.appPrimary,
                    ),
                  ),
                ],
              ),
            ),
            if (trailingIcon != null)
              Icon(trailingIcon, size: 16, color: context.appTextSubtle),
          ],
        ),
      ),
    );
  }

  void _showPhoneOptions(BuildContext context, String phone) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.appSurfaceRaised,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: ctx.appBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: Text(
                  phone,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ctx.appText,
                  ),
                ),
              ),
              Divider(height: 16, color: ctx.appBorder),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF25D366).withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chat_rounded,
                    color: Color(0xFF25D366),
                    size: 20,
                  ),
                ),
                title: Text(
                  'WhatsApp',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ctx.appText,
                  ),
                ),
                subtitle: Text(
                  phone,
                  style: TextStyle(fontSize: 12, color: ctx.appTextMuted),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _launchWhatsApp(context, phone);
                },
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ctx.appPrimarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.call_rounded,
                    color: ctx.appPrimary,
                    size: 20,
                  ),
                ),
                title: Text(
                  'Llamar',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ctx.appText,
                  ),
                ),
                subtitle: Text(
                  phone,
                  style: TextStyle(fontSize: 12, color: ctx.appTextMuted),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _launchCall(context, phone);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchWhatsApp(BuildContext context, String phone) async {
    final cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final number = cleaned.startsWith('+') ? cleaned.substring(1) : cleaned;
    final uri = Uri.parse('https://wa.me/$number');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir WhatsApp')),
        );
      }
    }
  }

  Future<void> _launchCall(BuildContext context, String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (!await launchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo iniciar la llamada')),
        );
      }
    }
  }

  Future<void> _launchMaps(BuildContext context, String address) async {
    final encoded = Uri.encodeComponent(address);
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$encoded',
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir Google Maps')),
        );
      }
    }
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
