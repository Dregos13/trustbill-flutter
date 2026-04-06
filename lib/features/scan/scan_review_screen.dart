import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/expense.dart';
import '../../core/models/supplier.dart';
import '../../core/auth/auth_provider.dart';
import 'scan_provider.dart';

class ScanReviewScreen extends ConsumerStatefulWidget {
  const ScanReviewScreen({super.key});

  @override
  ConsumerState<ScanReviewScreen> createState() => _ScanReviewScreenState();
}

class _ScanReviewScreenState extends ConsumerState<ScanReviewScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _supplierNameCtrl;
  late TextEditingController _supplierCifCtrl;
  late TextEditingController _descriptionCtrl;
  late TextEditingController _baseAmountCtrl;
  late TextEditingController _taxRateCtrl;
  late TextEditingController _vatAmountCtrl;
  late TextEditingController _totalAmountCtrl;
  late TextEditingController _dateCtrl;

  String _category = 'OTHER';
  SupplierMatch? _matchedSupplier;
  bool _searchingSupplier = false;

  static const _categories = {
    'OTHER': 'Otros',
    'RENT': 'Alquiler',
    'UTILITIES': 'Suministros',
    'SOFTWARE': 'Software',
    'PAYROLL': 'Nominas',
  };

  @override
  void initState() {
    super.initState();
    final result = ref.read(scanProvider).result;

    _supplierNameCtrl =
        TextEditingController(text: result?.supplierName ?? '');
    _supplierCifCtrl =
        TextEditingController(text: result?.supplierCif ?? '');

    // Build description from first line items or supplier name
    String desc = '';
    if (result != null && result.lines.isNotEmpty) {
      desc = result.lines.map((l) => l.description).take(3).join(', ');
    }
    if (desc.isEmpty) {
      desc = result?.supplierName != null
          ? 'Gasto - ${result!.supplierName}'
          : 'Gasto escaneado';
    }
    _descriptionCtrl = TextEditingController(text: desc);

    _baseAmountCtrl = TextEditingController(
        text: (result?.subtotal ?? 0).toStringAsFixed(2));
    _taxRateCtrl = TextEditingController(
        text: _inferTaxRate(result?.subtotal ?? 0, result?.taxAmount ?? 0));
    _vatAmountCtrl = TextEditingController(
        text: (result?.taxAmount ?? 0).toStringAsFixed(2));
    _totalAmountCtrl = TextEditingController(
        text: (result?.total ?? 0).toStringAsFixed(2));

    // Parse date
    final dateStr = result?.date ?? DateTime.now().toIso8601String();
    _dateCtrl = TextEditingController(text: _formatDisplayDate(dateStr));
  }

  String _inferTaxRate(double base, double tax) {
    if (base <= 0) return '21';
    final rate = (tax / base * 100).roundToDouble();
    // Snap to common Spanish rates
    if ((rate - 21).abs() < 2) return '21';
    if ((rate - 10).abs() < 2) return '10';
    if ((rate - 4).abs() < 2) return '4';
    return rate.toStringAsFixed(0);
  }

  String _formatDisplayDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
    } catch (_) {
      return iso;
    }
  }

  String _parseDisplayDateToIso(String display) {
    try {
      final parts = display.split('/');
      if (parts.length == 3) {
        final dt = DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
        return dt.toIso8601String();
      }
    } catch (_) {}
    return DateTime.now().toIso8601String();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
      locale: const Locale('es', 'ES'),
    );
    if (picked != null) {
      _dateCtrl.text = _formatDisplayDate(picked.toIso8601String());
    }
  }

  Future<void> _searchSupplier() async {
    final cif = _supplierCifCtrl.text.trim();
    final name = _supplierNameCtrl.text.trim();
    if (cif.isEmpty && name.isEmpty) return;

    setState(() => _searchingSupplier = true);
    try {
      final endpoints = ref.read(endpointsProvider);
      final results = await endpoints.lookupSupplier(
        taxId: cif.isNotEmpty ? cif : null,
        name: name.isNotEmpty ? name : null,
      );

      if (!mounted) return;

      if (results.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se encontró ningún proveedor. Se creará uno nuevo al confirmar.'),
            duration: Duration(seconds: 3),
          ),
        );
        setState(() { _matchedSupplier = null; _searchingSupplier = false; });
        return;
      }

      if (results.length == 1) {
        _applySupplier(results.first);
      } else {
        // Show picker dialog
        final picked = await showDialog<SupplierMatch>(
          context: context,
          builder: (_) => _SupplierPickerDialog(suppliers: results),
        );
        if (picked != null && mounted) _applySupplier(picked);
      }
    } catch (_) {
      // Silently ignore search errors — user can still fill fields manually
    } finally {
      if (mounted) setState(() => _searchingSupplier = false);
    }
  }

  void _applySupplier(SupplierMatch s) {
    setState(() {
      _matchedSupplier = s;
      _supplierNameCtrl.text = s.name;
      _supplierCifCtrl.text = s.taxId ?? '';
    });
  }

  void _recalculateFromBase() {
    final base = double.tryParse(_baseAmountCtrl.text) ?? 0;
    final rate = double.tryParse(_taxRateCtrl.text) ?? 0;
    final vat = (base * rate / 100);
    _vatAmountCtrl.text = vat.toStringAsFixed(2);
    _totalAmountCtrl.text = (base + vat).toStringAsFixed(2);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final state = ref.read(scanProvider);
    if (state.imageBytes == null) return;

    final payload = ExpenseConfirmPayload(
      supplierName: _supplierNameCtrl.text.trim(),
      supplierCif: _supplierCifCtrl.text.trim(),
      date: _parseDisplayDateToIso(_dateCtrl.text),
      category: _category,
      description: _descriptionCtrl.text.trim(),
      baseAmount: double.tryParse(_baseAmountCtrl.text) ?? 0,
      taxRate: double.tryParse(_taxRateCtrl.text) ?? 0,
      vatAmount: double.tryParse(_vatAmountCtrl.text) ?? 0,
      totalAmount: double.tryParse(_totalAmountCtrl.text) ?? 0,
      imageBase64: base64Encode(state.imageBytes!),
      imageMimeType: state.imageMimeType ?? 'image/jpeg',
    );

    await ref.read(scanProvider.notifier).confirmExpense(payload);
  }

  @override
  void dispose() {
    _supplierNameCtrl.dispose();
    _supplierCifCtrl.dispose();
    _descriptionCtrl.dispose();
    _baseAmountCtrl.dispose();
    _taxRateCtrl.dispose();
    _vatAmountCtrl.dispose();
    _totalAmountCtrl.dispose();
    _dateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scanProvider);
    final confidence = state.result?.confidence ?? 0;

    // Navigate home on success
    ref.listen<ScanState>(scanProvider, (prev, next) {
      if (next.confirmed != null && prev?.confirmed == null) {
        final supplierCreated = next.confirmed!.supplier.created;
        final msg = supplierCreated
            ? 'Gasto creado. Proveedor "${next.confirmed!.supplier.name}" creado automaticamente.'
            : 'Gasto creado correctamente.';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 3),
          ),
        );
        context.go('/');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisar datos'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Confidence indicator
            if (confidence > 0) ...[
              _ConfidenceBanner(confidence: confidence),
              const SizedBox(height: 16),
            ],

            // Error display
            if (state.error != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.dangerBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: AppColors.danger, fontSize: 13),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Supplier section
            _SectionTitle('Proveedor'),
            const SizedBox(height: 8),
            if (_matchedSupplier != null)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.successBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.success, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Proveedor encontrado en tu base de datos',
                        style: const TextStyle(color: AppColors.success, fontSize: 13),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _matchedSupplier = null),
                      child: const Icon(Icons.close, color: AppColors.success, size: 16),
                    ),
                  ],
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildField(
                    controller: _supplierNameCtrl,
                    label: 'Nombre del proveedor',
                    icon: Icons.store,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Nombre requerido' : null,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: _searchingSupplier
                      ? const SizedBox(
                          width: 48, height: 48,
                          child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
                        )
                      : IconButton.filled(
                          onPressed: _searchSupplier,
                          icon: const Icon(Icons.search),
                          tooltip: 'Buscar en tu base de datos',
                          style: IconButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildField(
              controller: _supplierCifCtrl,
              label: 'CIF / NIF',
              icon: Icons.badge,
              hint: 'Busca por CIF para encontrar el proveedor',
            ),

            const SizedBox(height: 24),
            _SectionTitle('Datos del gasto'),
            const SizedBox(height: 8),

            // Date picker
            GestureDetector(
              onTap: _pickDate,
              child: AbsorbPointer(
                child: _buildField(
                  controller: _dateCtrl,
                  label: 'Fecha',
                  icon: Icons.calendar_today,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Fecha requerida' : null,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Category dropdown
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: InputDecoration(
                labelText: 'Categoria',
                prefixIcon:
                    const Icon(Icons.category, color: AppColors.gray400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: _categories.entries
                  .map((e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _category = v ?? 'OTHER'),
            ),
            const SizedBox(height: 12),

            _buildField(
              controller: _descriptionCtrl,
              label: 'Descripcion',
              icon: Icons.notes,
              maxLines: 2,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Descripcion requerida' : null,
            ),

            const SizedBox(height: 24),
            _SectionTitle('Importes'),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildField(
                    controller: _baseAmountCtrl,
                    label: 'Base imponible',
                    icon: Icons.euro,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _recalculateFromBase(),
                    validator: (v) {
                      final n = double.tryParse(v ?? '');
                      if (n == null || n < 0) return 'Importe invalido';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildField(
                    controller: _taxRateCtrl,
                    label: '% IVA',
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _recalculateFromBase(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildField(
                    controller: _vatAmountCtrl,
                    label: 'IVA',
                    icon: Icons.receipt_long,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildField(
                    controller: _totalAmountCtrl,
                    label: 'Total',
                    icon: Icons.payments,
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      final n = double.tryParse(v ?? '');
                      if (n == null || n <= 0) return 'Total requerido';
                      return null;
                    },
                  ),
                ),
              ],
            ),

            // Line items preview (read-only)
            if (state.result != null &&
                state.result!.lines.isNotEmpty) ...[
              const SizedBox(height: 24),
              _SectionTitle(
                  'Lineas detectadas (${state.result!.lines.length})'),
              const SizedBox(height: 8),
              ...state.result!.lines.map((line) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.gray50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray200),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            line.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.gray700,
                            ),
                          ),
                        ),
                        Text(
                          '${line.total.toStringAsFixed(2)} EUR',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray800,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],

            const SizedBox(height: 32),

            // Submit button (disabled until backend confirm is ready)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.check),
                label: const Text('Crear gasto (próximamente)'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null
            ? Icon(icon, color: AppColors.gray400)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.gray800,
      ),
    );
  }
}

class _SupplierPickerDialog extends StatelessWidget {
  final List<SupplierMatch> suppliers;
  const _SupplierPickerDialog({required this.suppliers});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccionar proveedor'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: suppliers.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            final s = suppliers[i];
            return ListTile(
              leading: const Icon(Icons.store, color: AppColors.primary),
              title: Text(s.name),
              subtitle: s.taxId != null && s.taxId!.isNotEmpty
                  ? Text(s.taxId!, style: const TextStyle(fontSize: 12))
                  : null,
              onTap: () => Navigator.of(context).pop(s),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

class _ConfidenceBanner extends StatelessWidget {
  final double confidence;
  const _ConfidenceBanner({required this.confidence});

  @override
  Widget build(BuildContext context) {
    final pct = (confidence * 100).round();
    final isHigh = pct >= 80;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isHigh ? AppColors.successBg : AppColors.warningBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            isHigh ? Icons.verified : Icons.info_outline,
            size: 18,
            color: isHigh ? AppColors.success : AppColors.warning,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              isHigh
                  ? 'Confianza del OCR: $pct%. Revisa los datos antes de confirmar.'
                  : 'Confianza baja ($pct%). Revisa cuidadosamente todos los campos.',
              style: TextStyle(
                fontSize: 13,
                color: isHigh ? AppColors.success : AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
