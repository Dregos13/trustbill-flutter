import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/permission_helpers.dart';
import '../../core/auth/permission_provider.dart';
import '../../core/models/catalog.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/error_messages.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final int id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  CatalogProduct? _product;
  List<InventoryMovement> _movements = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final ep = ref.read(endpointsProvider);
      final product = await ep.getCatalogProduct(widget.id);
      final movements = await ep.getInventoryMovements(widget.id);
      if (mounted) {
        setState(() {
          _product = product;
          _movements = movements;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() { _error = friendlyError(e); _loading = false; });
    }
  }

  Future<void> _showEntrySheet() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _InventoryEntrySheet(productId: widget.id),
    );
    if (result == true) _load();
  }

  Future<void> _showAdjustSheet() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _InventoryAdjustSheet(
        productId: widget.id,
        currentStock: _product?.stockQty ?? 0,
      ),
    );
    if (result == true) _load();
  }

  @override
  Widget build(BuildContext context) {
    final perms = ref.watch(permissionsProvider);
    final canInventoryWrite = perms.contains(Permissions.inventoryWrite) || perms.contains('inventory.*');
    final canProductWrite = perms.contains(Permissions.productsWrite) || perms.contains('products.*');

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appSurface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.appText),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _product?.name ?? 'Producto',
          style: TextStyle(color: context.appText, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        actions: [
          if (canProductWrite && _product != null)
            IconButton(
              icon: Icon(Icons.edit_outlined, color: context.appTextMuted),
              onPressed: () async {
                await context.push('/catalog/products/${widget.id}/edit', extra: _product);
                _load();
              },
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(_error!, style: const TextStyle(color: AppColors.danger)),
                  TextButton(onPressed: _load, child: const Text('Reintentar')),
                ]))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildInfoCard(context),
                      const SizedBox(height: 12),
                      _buildStockCard(context, canInventoryWrite),
                      const SizedBox(height: 16),
                      Text('Movimientos recientes', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: context.appText)),
                      const SizedBox(height: 8),
                      if (_movements.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(child: Text('Sin movimientos', style: TextStyle(color: context.appTextMuted))),
                        )
                      else
                        ..._movements.map((m) => _MovementTile(movement: m)),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final p = _product!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: context.appSurface, borderRadius: BorderRadius.circular(12), border: Border.all(color: context.appBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.inventory_2_outlined, color: context.appPrimary, size: 18),
            const SizedBox(width: 8),
            Text(p.sku, style: TextStyle(fontSize: 13, color: context.appTextMuted, fontFamily: 'monospace')),
          ]),
          const SizedBox(height: 8),
          Text(p.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: context.appText)),
          if (p.description != null && p.description!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(p.description!, style: TextStyle(fontSize: 13, color: context.appTextMuted)),
          ],
          const SizedBox(height: 10),
          Text('€${p.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: context.appPrimary)),
        ],
      ),
    );
  }

  Widget _buildStockCard(BuildContext context, bool canWrite) {
    final qty = _product!.stockQty;
    final stockColor = qty <= 0 ? AppColors.danger : qty < 5 ? AppColors.warning : AppColors.success;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: stockColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: stockColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warehouse_outlined, color: stockColor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stock disponible', style: TextStyle(fontSize: 12, color: context.appTextMuted)),
                Text('$qty unidades', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: stockColor)),
              ],
            ),
          ),
          if (canWrite) ...[
            _StockActionButton(
              icon: Icons.add,
              label: 'Entrada',
              color: AppColors.success,
              onTap: _showEntrySheet,
            ),
            const SizedBox(width: 8),
            _StockActionButton(
              icon: Icons.tune,
              label: 'Ajuste',
              color: AppColors.warning,
              onTap: _showAdjustSheet,
            ),
          ],
        ],
      ),
    );
  }
}

class _StockActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _StockActionButton({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
        child: Column(children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ]),
      ),
    );
  }
}

class _MovementTile extends StatelessWidget {
  final InventoryMovement movement;
  const _MovementTile({required this.movement});

  IconData get _icon => switch (movement.type) {
    'IN' => Icons.arrow_downward,
    'OUT' => Icons.arrow_upward,
    'ADJUST' => Icons.tune,
    _ => Icons.swap_horiz,
  };

  Color get _color => switch (movement.type) {
    'IN' => AppColors.success,
    'OUT' => AppColors.danger,
    'ADJUST' => AppColors.warning,
    _ => AppColors.gray500,
  };

  String get _label => switch (movement.type) {
    'IN' => 'Entrada',
    'OUT' => 'Salida',
    'ADJUST' => 'Ajuste',
    _ => movement.type,
  };

  String get _qty {
    final n = movement.quantity;
    return movement.type == 'IN' ? '+$n' : movement.type == 'OUT' ? '-$n' : '${n >= 0 ? '+' : ''}$n';
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd/MM/yy HH:mm');
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: context.appSurface, borderRadius: BorderRadius.circular(10), border: Border.all(color: context.appBorder)),
      child: Row(children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: _color.withValues(alpha: 0.12), shape: BoxShape.circle),
          child: Icon(_icon, color: _color, size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: context.appText)),
          if (movement.notes != null && movement.notes!.isNotEmpty)
            Text(movement.notes!, style: TextStyle(fontSize: 11, color: context.appTextMuted), maxLines: 1, overflow: TextOverflow.ellipsis),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(_qty, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _color)),
          Text(fmt.format(movement.occurredAt.toLocal()), style: TextStyle(fontSize: 10, color: context.appTextMuted)),
        ]),
      ]),
    );
  }
}

// ── Bottom sheets ──────────────────────────────────────────────────────────────

class _InventoryEntrySheet extends ConsumerStatefulWidget {
  final int productId;
  const _InventoryEntrySheet({required this.productId});

  @override
  ConsumerState<_InventoryEntrySheet> createState() => _InventoryEntrySheetState();
}

class _InventoryEntrySheetState extends ConsumerState<_InventoryEntrySheet> {
  final _qtyCtrl = TextEditingController();
  final _costCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  @override
  void dispose() { _qtyCtrl.dispose(); _costCtrl.dispose(); _notesCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref.read(endpointsProvider).createInventoryEntry(
        productId: widget.productId,
        quantity: int.parse(_qtyCtrl.text),
        unitCost: double.parse(_costCtrl.text.replaceAll(',', '.')),
        notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      );
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(friendlyError(e)), backgroundColor: AppColors.danger));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _SheetWrapper(
      title: 'Registrar entrada',
      saving: _saving,
      onSave: _submit,
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            controller: _qtyCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Cantidad *', prefixIcon: Icon(Icons.add_box_outlined, size: 18)),
            validator: (v) => v == null || int.tryParse(v) == null || int.parse(v) <= 0 ? 'Introduce cantidad válida' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _costCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Coste unitario *', prefixIcon: Icon(Icons.euro, size: 18)),
            validator: (v) => v == null || double.tryParse(v.replaceAll(',', '.')) == null ? 'Introduce coste válido' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _notesCtrl,
            decoration: const InputDecoration(labelText: 'Notas (opcional)', prefixIcon: Icon(Icons.notes, size: 18)),
            maxLines: 2,
          ),
        ]),
      ),
    );
  }
}

class _InventoryAdjustSheet extends ConsumerStatefulWidget {
  final int productId;
  final int currentStock;
  const _InventoryAdjustSheet({required this.productId, required this.currentStock});

  @override
  ConsumerState<_InventoryAdjustSheet> createState() => _InventoryAdjustSheetState();
}

class _InventoryAdjustSheetState extends ConsumerState<_InventoryAdjustSheet> {
  final _deltaCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  @override
  void dispose() { _deltaCtrl.dispose(); _reasonCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref.read(endpointsProvider).adjustInventory(
        productId: widget.productId,
        delta: int.parse(_deltaCtrl.text),
        reason: _reasonCtrl.text.trim().isEmpty ? null : _reasonCtrl.text.trim(),
      );
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(friendlyError(e)), backgroundColor: AppColors.danger));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _SheetWrapper(
      title: 'Ajuste de stock',
      saving: _saving,
      onSave: _submit,
      child: Form(
        key: _formKey,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: context.appBorder, borderRadius: BorderRadius.circular(8)),
            child: Row(children: [
              Icon(Icons.info_outline, size: 16, color: context.appTextMuted),
              const SizedBox(width: 8),
              Text('Stock actual: ${widget.currentStock} unidades', style: TextStyle(fontSize: 13, color: context.appTextMuted)),
            ]),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _deltaCtrl,
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            decoration: const InputDecoration(labelText: 'Variación (ej: +5 ó -3) *', prefixIcon: Icon(Icons.tune, size: 18)),
            validator: (v) {
              if (v == null || int.tryParse(v) == null) return 'Introduce un número entero';
              if (int.parse(v) == 0) return 'La variación no puede ser 0';
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _reasonCtrl,
            decoration: const InputDecoration(labelText: 'Motivo (opcional)', prefixIcon: Icon(Icons.notes, size: 18)),
            maxLines: 2,
          ),
        ]),
      ),
    );
  }
}

class _SheetWrapper extends StatelessWidget {
  final String title;
  final bool saving;
  final VoidCallback onSave;
  final Widget child;

  const _SheetWrapper({required this.title, required this.saving, required this.onSave, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Container(width: 36, height: 4, decoration: BoxDecoration(color: context.appTextSubtle, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: context.appText)),
          const SizedBox(height: 16),
          child,
          const SizedBox(height: 20),
          SizedBox(
            height: 46,
            child: ElevatedButton(
              onPressed: saving ? null : onSave,
              child: saving ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Guardar'),
            ),
          ),
        ],
      ),
    );
  }
}
