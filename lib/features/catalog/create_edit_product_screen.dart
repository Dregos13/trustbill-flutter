import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/catalog.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/error_messages.dart';

class CreateEditProductScreen extends ConsumerStatefulWidget {
  final CatalogProduct? existing;
  const CreateEditProductScreen({super.key, this.existing});

  @override
  ConsumerState<CreateEditProductScreen> createState() => _CreateEditProductScreenState();
}

class _CreateEditProductScreenState extends ConsumerState<CreateEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _skuCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  bool _saving = false;
  String? _error;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final p = widget.existing;
    if (p != null) {
      _nameCtrl.text = p.name;
      _skuCtrl.text = p.sku;
      _descCtrl.text = p.description ?? '';
      _priceCtrl.text = p.price.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _skuCtrl.dispose(); _descCtrl.dispose(); _priceCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _saving = true; _error = null; });

    final data = <String, dynamic>{
      'name': _nameCtrl.text.trim(),
      'price': double.parse(_priceCtrl.text.replaceAll(',', '.')),
      if (_skuCtrl.text.trim().isNotEmpty) 'sku': _skuCtrl.text.trim(),
      if (_descCtrl.text.trim().isNotEmpty) 'description': _descCtrl.text.trim(),
    };

    try {
      final ep = ref.read(endpointsProvider);
      if (_isEdit) {
        await ep.updateCatalogProduct(widget.existing!.id, data);
      } else {
        await ep.createCatalogProduct(data);
      }
      if (mounted) context.pop(true);
    } catch (e) {
      if (mounted) setState(() { _saving = false; _error = friendlyError(e); });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appSurface,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: context.appText), onPressed: () => context.pop()),
        title: Text(
          _isEdit ? 'Editar producto' : 'Nuevo producto',
          style: TextStyle(color: context.appText, fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_error != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.dangerBg, borderRadius: BorderRadius.circular(8)),
                  child: Text(_error!, style: const TextStyle(color: AppColors.danger, fontSize: 13)),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nombre *', prefixIcon: Icon(Icons.label_outline, size: 18)),
                textCapitalization: TextCapitalization.words,
                validator: (v) => v == null || v.trim().isEmpty ? 'El nombre es obligatorio' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _skuCtrl,
                decoration: const InputDecoration(
                  labelText: 'SKU (opcional)',
                  hintText: 'Se genera automáticamente si se deja vacío',
                  prefixIcon: Icon(Icons.qr_code, size: 18),
                ),
                autocorrect: false,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _priceCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Precio de venta *', prefixIcon: Icon(Icons.euro, size: 18)),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'El precio es obligatorio';
                  if (double.tryParse(v.replaceAll(',', '.')) == null) return 'Precio no válido';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Descripción (opcional)', prefixIcon: Icon(Icons.notes, size: 18)),
                maxLines: 3,
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: _saving ? null : _submit,
                  child: _saving
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(_isEdit ? 'Guardar cambios' : 'Crear producto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
