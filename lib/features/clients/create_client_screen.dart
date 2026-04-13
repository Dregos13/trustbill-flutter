import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/client.dart';
import '../../core/theme/app_colors.dart';

class CreateClientScreen extends ConsumerStatefulWidget {
  /// If [existingClient] is provided, the screen is in edit mode.
  final Client? existingClient;

  const CreateClientScreen({super.key, this.existingClient});

  @override
  ConsumerState<CreateClientScreen> createState() => _CreateClientScreenState();
}

class _CreateClientScreenState extends ConsumerState<CreateClientScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  late final TextEditingController _nameCtrl;
  late final TextEditingController _taxIdCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _postalCtrl;
  late final TextEditingController _cityCtrl;

  bool get _isEditing => widget.existingClient != null;

  @override
  void initState() {
    super.initState();
    final c = widget.existingClient;
    _nameCtrl    = TextEditingController(text: c?.name ?? '');
    _taxIdCtrl   = TextEditingController(text: c?.taxId ?? '');
    _emailCtrl   = TextEditingController(text: c?.email ?? '');
    _phoneCtrl   = TextEditingController(text: c?.phone ?? '');
    _addressCtrl = TextEditingController(text: c?.address ?? '');
    _postalCtrl  = TextEditingController(text: c?.postalCode ?? '');
    _cityCtrl    = TextEditingController(text: c?.city ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _taxIdCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _postalCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final endpoints = ref.read(endpointsProvider);
    final data = {
      'name':       _nameCtrl.text.trim(),
      'taxId':      _taxIdCtrl.text.trim(),
      'email':      _emailCtrl.text.trim(),
      'phone':      _phoneCtrl.text.trim(),
      'address':    _addressCtrl.text.trim(),
      'postalCode': _postalCtrl.text.trim(),
      'city':       _cityCtrl.text.trim(),
    };

    try {
      Client result;
      if (_isEditing) {
        result = await endpoints.updateClient(widget.existingClient!.id, data);
      } else {
        result = await endpoints.createClient(data);
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'Cliente "${result.name}" actualizado.'
                : 'Cliente "${result.name}" creado correctamente.',
          ),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop(result);
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
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar cliente' : 'Nuevo cliente'),
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
                      strokeWidth: 2, color: Colors.white),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text(
                'Guardar',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SectionTitle('Datos fiscales'),
            const SizedBox(height: 8),
            _field(
              controller: _nameCtrl,
              label: 'Nombre / Razón social',
              hint: 'Nombre del cliente',
              required: true,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),
            _field(
              controller: _taxIdCtrl,
              label: 'CIF / NIF',
              hint: 'Ej: B12345678',
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 20),
            _SectionTitle('Contacto'),
            const SizedBox(height: 8),
            _field(
              controller: _emailCtrl,
              label: 'Email',
              hint: 'cliente@ejemplo.com',
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return null;
                final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
                if (!re.hasMatch(v)) return 'Email no válido';
                return null;
              },
            ),
            const SizedBox(height: 12),
            _field(
              controller: _phoneCtrl,
              label: 'Teléfono',
              hint: 'Ej: 612 345 678',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            _SectionTitle('Dirección'),
            const SizedBox(height: 8),
            _field(
              controller: _addressCtrl,
              label: 'Dirección',
              hint: 'Calle, número...',
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _field(
                    controller: _postalCtrl,
                    label: 'Código postal',
                    hint: '28001',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: _field(
                    controller: _cityCtrl,
                    label: 'Ciudad',
                    hint: 'Madrid',
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
                    : Text(
                        _isEditing ? 'Guardar cambios' : 'Crear cliente',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      validator: validator ??
          (required
              ? (v) => (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null
              : null),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.gray500,
        letterSpacing: 0.5,
      ),
    );
  }
}
