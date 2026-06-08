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

class ProductsTab extends ConsumerStatefulWidget {
  const ProductsTab({super.key});

  @override
  ConsumerState<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends ConsumerState<ProductsTab> {
  final _searchCtrl = TextEditingController();
  List<CatalogProduct> _products = [];
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
    setState(() { _loading = true; _error = null; });
    try {
      final ep = ref.read(endpointsProvider);
      final items = await ep.getCatalogProducts(search: search);
      if (mounted) setState(() { _products = items; _loading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = friendlyError(e); _loading = false; });
    }
  }

  Future<void> _delete(CatalogProduct p) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text('¿Eliminar "${p.name}"? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref.read(endpointsProvider).deleteCatalogProduct(p.id);
      await _load(search: _searchCtrl.text.trim().isEmpty ? null : _searchCtrl.text.trim());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(friendlyError(e)), backgroundColor: AppColors.danger),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final perms = ref.watch(permissionsProvider);
    final canWrite = perms.contains(Permissions.productsWrite) || perms.contains('products.*');

    return Stack(
      children: [
        Column(
          children: [
            Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
              hintText: 'Buscar producto...',
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.appBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.appBorder),
              ),
            ),
            onSubmitted: (v) => _load(search: v.trim().isEmpty ? null : v.trim()),
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
                          Text(_error!, style: const TextStyle(color: AppColors.danger)),
                          const SizedBox(height: 12),
                          TextButton(onPressed: _load, child: const Text('Reintentar')),
                        ],
                      ),
                    )
                  : _products.isEmpty
                      ? Center(child: Text('Sin productos', style: TextStyle(color: context.appTextMuted)))
                      : RefreshIndicator(
                          onRefresh: () => _load(search: _searchCtrl.text.trim().isEmpty ? null : _searchCtrl.text.trim()),
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 80),
                            itemCount: _products.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                            itemBuilder: (_, i) => _ProductCard(
                              product: _products[i],
                              canWrite: canWrite,
                              onDelete: () => _delete(_products[i]),
                              onEdit: () async {
                                await context.push(
                                  '/catalog/products/${_products[i].id}/edit',
                                  extra: _products[i],
                                );
                                _load();
                              },
                              onTap: () => context.push('/catalog/products/${_products[i].id}'),
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
              heroTag: 'products_fab',
              backgroundColor: AppColors.primary,
              onPressed: () async {
                await context.push('/catalog/products/new');
                _load();
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Nuevo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
      ],
    );
  }
}

// ── Card ───────────────────────────────────────────────────────────────────────

class _ProductCard extends StatelessWidget {
  final CatalogProduct product;
  final bool canWrite;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ProductCard({
    required this.product,
    required this.canWrite,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  Color _stockColor() {
    if (product.stockQty <= 0) return AppColors.danger;
    if (product.stockQty < 5) return AppColors.warning;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    final stockColor = _stockColor();
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
                color: context.appPrimarySoft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.inventory_2_outlined, color: context.appPrimary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: context.appText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.sku,
                    style: TextStyle(fontSize: 12, color: context.appTextMuted, fontFamily: 'monospace'),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '€${product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: context.appText),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: stockColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Stock: ${product.stockQty}',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: stockColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (canWrite)
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: context.appTextMuted, size: 20),
                onSelected: (v) {
                  if (v == 'edit') onEdit();
                  if (v == 'delete') onDelete();
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'edit', child: Text('Editar')),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Eliminar', style: TextStyle(color: AppColors.danger)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
