import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/permission_helpers.dart';
import '../../core/auth/permission_provider.dart';
import '../../core/models/catalog.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/error_messages.dart';

class ServicesTab extends ConsumerStatefulWidget {
  const ServicesTab({super.key});

  @override
  ConsumerState<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends ConsumerState<ServicesTab> {
  final _searchCtrl = TextEditingController();
  List<CatalogService> _services = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _load({String? search}) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final ep = ref.read(endpointsProvider);
      final items = await ep.getCatalogServices(search: search);
      if (mounted) {
        setState(() {
          _services = items;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = friendlyError(e);
          _loading = false;
        });
      }
    }
  }

  Future<void> _delete(CatalogService s) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Desactivar servicio'),
        content: Text(
          '¿Desactivar "${s.name}"? Dejará de aparecer en el catálogo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Desactivar',
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref.read(endpointsProvider).deleteCatalogService(s.id);
      await _load(
        search: _searchCtrl.text.trim().isEmpty
            ? null
            : _searchCtrl.text.trim(),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(friendlyError(e)),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final perms = ref.watch(permissionsProvider);
    final canWrite =
        perms.contains(Permissions.servicesWrite) ||
        perms.contains('services.*');

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Buscar servicio...',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchCtrl.clear();
                            _load();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: context.appSurface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: context.appBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: context.appBorder),
                  ),
                ),
                onSubmitted: (v) =>
                    _load(search: v.trim().isEmpty ? null : v.trim()),
                onChanged: (v) {
                  setState(() {});
                  if (v.isEmpty) _load();
                },
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _error!,
                            style: const TextStyle(color: AppColors.danger),
                          ),
                          TextButton(
                            onPressed: _load,
                            child: const Text('Reintentar'),
                          ),
                        ],
                      ),
                    )
                  : _services.isEmpty
                  ? Center(
                      child: Text(
                        'Sin servicios',
                        style: TextStyle(color: context.appTextMuted),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _load(
                        search: _searchCtrl.text.trim().isEmpty
                            ? null
                            : _searchCtrl.text.trim(),
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
                        itemCount: _services.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (_, i) => _ServiceCard(
                          service: _services[i],
                          canWrite: canWrite,
                          onEdit: () async {
                            await context.push(
                              '/catalog/services/${_services[i].id}/edit',
                              extra: _services[i],
                            );
                            _load();
                          },
                          onDelete: () => _delete(_services[i]),
                        ),
                      ),
                    ),
            ),
          ],
        ),
        if (canWrite)
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton.extended(
              heroTag: 'services_fab',
              backgroundColor: AppColors.success,
              onPressed: () async {
                await context.push('/catalog/services/new');
                _load();
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Nuevo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final CatalogService service;
  final bool canWrite;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ServiceCard({
    required this.service,
    required this.canWrite,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.successBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.design_services_outlined,
              color: AppColors.success,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: context.appText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (service.description != null &&
                    service.description!.isNotEmpty)
                  Text(
                    service.description!,
                    style: TextStyle(fontSize: 12, color: context.appTextMuted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '€${service.unitPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: context.appText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'IVA ${service.taxRate.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.appTextMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (canWrite)
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: context.appTextMuted,
                size: 20,
              ),
              onSelected: (v) {
                if (v == 'edit') onEdit();
                if (v == 'delete') onDelete();
              },
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'edit', child: Text('Editar')),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    'Desactivar',
                    style: TextStyle(color: AppColors.danger),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
