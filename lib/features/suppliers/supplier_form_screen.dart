import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/auth_provider.dart';
import '../../core/models/supplier.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/error_messages.dart';
import '../../widgets/loading_indicator.dart';
import '../purchases/purchases_screen.dart';
import 'suppliers_screen.dart';

final supplierDetailProvider = FutureProvider.autoDispose.family<Supplier, int>(
  (ref, id) async {
    return ref.watch(endpointsProvider).getSupplier(id);
  },
);

class SupplierFormScreen extends ConsumerStatefulWidget {
  const SupplierFormScreen({super.key, this.id});

  final int? id;

  @override
  ConsumerState<SupplierFormScreen> createState() => _SupplierFormScreenState();
}

class _SupplierFormScreenState extends ConsumerState<SupplierFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _taxIdCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _postalCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  bool _loaded = false;
  bool _saving = false;
  String? _error;

  bool get _isEditing => widget.id != null;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _taxIdCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _postalCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _load(Supplier supplier) {
    if (_loaded) return;
    _loaded = true;
    _nameCtrl.text = supplier.name;
    _taxIdCtrl.text = supplier.taxId;
    _emailCtrl.text = supplier.email;
    _phoneCtrl.text = supplier.phone;
    _addressCtrl.text = supplier.address;
    _postalCtrl.text = supplier.postalCode;
    _notesCtrl.text = supplier.notes;
  }

  bool _isValidEmail(String value) {
    if (value.trim().isEmpty) return true;
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
  }

  Map<String, dynamic> _payload() => {
    'name': _nameCtrl.text.trim(),
    'taxId': _taxIdCtrl.text.trim(),
    'email': _emailCtrl.text.trim(),
    'phone': _phoneCtrl.text.trim(),
    'address': _addressCtrl.text.trim(),
    'postalCode': _postalCtrl.text.trim(),
    'notes': _notesCtrl.text.trim(),
  };

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      final endpoints = ref.read(endpointsProvider);
      final Supplier supplier;
      if (_isEditing) {
        supplier = await endpoints.updateSupplier(widget.id!, _payload());
        ref.invalidate(supplierDetailProvider(widget.id!));
      } else {
        supplier = await endpoints.createSupplier(_payload());
      }
      ref.invalidate(suppliersProvider);
      ref.invalidate(purchasesProvider);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'Proveedor "${supplier.name}" actualizado.'
                : 'Proveedor "${supplier.name}" creado.',
          ),
          backgroundColor: context.statusSuccess,
        ),
      );
      context.pop(supplier);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = friendlyError(e, fallback: 'No se pudo guardar el proveedor.');
      });
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.id;
    final body = id == null
        ? _buildForm(context)
        : ref
              .watch(supplierDetailProvider(id))
              .when(
                loading: () => const LoadingIndicator(),
                error: (err, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      friendlyError(
                        err,
                        fallback: 'No se pudo cargar el proveedor.',
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: context.appTextMuted),
                    ),
                  ),
                ),
                data: (supplier) {
                  _load(supplier);
                  return _buildForm(context);
                },
              );

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar proveedor' : 'Nuevo proveedor'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text(
                'Guardar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
      body: body,
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_error != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.statusDangerSoft,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _error!,
                style: TextStyle(color: context.statusDanger),
              ),
            ),
            const SizedBox(height: 16),
          ],
          _SectionTitle('Datos fiscales'),
          const SizedBox(height: 8),
          _field(
            controller: _nameCtrl,
            label: 'Nombre fiscal',
            icon: Icons.storefront_outlined,
            required: true,
            textCapitalization: TextCapitalization.words,
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Nombre requerido'
                : null,
          ),
          const SizedBox(height: 12),
          _field(
            controller: _taxIdCtrl,
            label: 'CIF / NIF',
            icon: Icons.badge_outlined,
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: 20),
          _SectionTitle('Contacto'),
          const SizedBox(height: 8),
          _field(
            controller: _emailCtrl,
            label: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                _isValidEmail(value ?? '') ? null : 'Email no válido',
          ),
          const SizedBox(height: 12),
          _field(
            controller: _phoneCtrl,
            label: 'Teléfono',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          _SectionTitle('Dirección'),
          const SizedBox(height: 8),
          _field(
            controller: _addressCtrl,
            label: 'Dirección',
            icon: Icons.location_on_outlined,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 12),
          _field(
            controller: _postalCtrl,
            label: 'Código postal',
            icon: Icons.markunread_mailbox_outlined,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          _SectionTitle('Notas'),
          const SizedBox(height: 8),
          _field(
            controller: _notesCtrl,
            label: 'Notas internas',
            icon: Icons.notes_outlined,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(_isEditing ? 'Guardar cambios' : 'Crear proveedor'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        prefixIcon: Icon(icon, color: context.appTextSubtle),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: context.appText,
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
