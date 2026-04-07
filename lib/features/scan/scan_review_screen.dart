import 'dart:async';
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

  // Supplier fields
  late TextEditingController _supplierNameCtrl;
  late TextEditingController _supplierCifCtrl;
  late TextEditingController _supplierEmailCtrl;
  late TextEditingController _supplierPhoneCtrl;
  late TextEditingController _supplierAddressCtrl;
  late TextEditingController _supplierPostalCtrl;
  late TextEditingController _supplierNotesCtrl;

  // Invoice fields
  late TextEditingController _invoiceNumberCtrl;
  late TextEditingController _issueDateCtrl;
  late TextEditingController _dueDateCtrl;

  // Amount fields
  late TextEditingController _totalCtrl;
  late TextEditingController _taxCtrl;

  String _taxKind = 'IVA';
  String _status = 'UNPAID';

  SupplierMatch? _matchedSupplier;
  bool _searchingSupplier = false;

  @override
  void initState() {
    super.initState();
    final result = ref.read(scanProvider).result;

    _supplierNameCtrl =
        TextEditingController(text: result?.supplierName ?? '');
    _supplierCifCtrl =
        TextEditingController(text: result?.supplierCif ?? '');
    _supplierEmailCtrl = TextEditingController();
    _supplierPhoneCtrl = TextEditingController();
    _supplierAddressCtrl =
        TextEditingController(text: result?.supplierAddress ?? '');
    _supplierPostalCtrl = TextEditingController();
    _supplierNotesCtrl = TextEditingController();

    _invoiceNumberCtrl =
        TextEditingController(text: result?.invoiceNumber ?? '');
    _issueDateCtrl = TextEditingController(
        text: _formatDisplayDate(result?.date ?? DateTime.now().toIso8601String()));
    _dueDateCtrl = TextEditingController();

    _totalCtrl = TextEditingController(
        text: (result?.total ?? 0).toStringAsFixed(2));
    _taxCtrl = TextEditingController(
        text: (result?.taxAmount ?? 0).toStringAsFixed(2));
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
        return dt.toUtc().toIso8601String();
      }
    } catch (_) {}
    return DateTime.now().toUtc().toIso8601String();
  }

  Future<void> _pickDate(TextEditingController ctrl,
      {bool allowFuture = false}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: allowFuture ? DateTime(2100) : now,
    );
    if (picked != null) {
      ctrl.text = _formatDisplayDate(picked.toIso8601String());
    }
  }

  bool _isValidEmail(String v) {
    if (v.isEmpty) return false;
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
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
            content: Text(
                'No se encontró ningún proveedor. Se creará uno nuevo al confirmar.'),
            duration: Duration(seconds: 3),
          ),
        );
        setState(() {
          _matchedSupplier = null;
          _searchingSupplier = false;
        });
        return;
      }

      if (results.length == 1) {
        _applySupplier(results.first);
      } else {
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
      if (s.address != null && s.address!.isNotEmpty) {
        _supplierAddressCtrl.text = s.address!;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final state = ref.read(scanProvider);
    if (state.imageBytes == null) return;

    final scanResult = state.result;
    final lines = scanResult?.lines
            .map((l) => <String, dynamic>{
                  'description': l.description,
                  'base': l.unitPrice * l.quantity,
                  'taxRate': l.taxRate,
                  'taxAmount': l.unitPrice * l.quantity * l.taxRate / 100,
                })
            .toList() ??
        <Map<String, dynamic>>[];

    final dueDateText = _dueDateCtrl.text.trim();

    final payload = SupplierInvoiceConfirmPayload(
      supplierId: _matchedSupplier?.id,
      supplierName: _supplierNameCtrl.text.trim(),
      supplierCif: _supplierCifCtrl.text.trim().isNotEmpty
          ? _supplierCifCtrl.text.trim()
          : null,
      supplierEmail: _isValidEmail(_supplierEmailCtrl.text.trim())
          ? _supplierEmailCtrl.text.trim()
          : null,
      supplierPhone: _supplierPhoneCtrl.text.trim().isNotEmpty
          ? _supplierPhoneCtrl.text.trim()
          : null,
      supplierAddress: _supplierAddressCtrl.text.trim().isNotEmpty
          ? _supplierAddressCtrl.text.trim()
          : null,
      supplierPostalCode: _supplierPostalCtrl.text.trim().isNotEmpty
          ? _supplierPostalCtrl.text.trim()
          : null,
      supplierNotes: _supplierNotesCtrl.text.trim().isNotEmpty
          ? _supplierNotesCtrl.text.trim()
          : null,
      invoiceNumber: _invoiceNumberCtrl.text.trim().isNotEmpty
          ? _invoiceNumberCtrl.text.trim()
          : null,
      issueDate: _parseDisplayDateToIso(_issueDateCtrl.text),
      dueDate: dueDateText.isNotEmpty
          ? _parseDisplayDateToIso(dueDateText)
          : null,
      taxKind: _taxKind,
      status: _status,
      total: double.tryParse(_totalCtrl.text) ?? 0,
      tax: double.tryParse(_taxCtrl.text) ?? 0,
      lines: lines,
      imageBase64: base64Encode(state.imageBytes!),
      imageMimeType: state.imageMimeType ?? 'image/jpeg',
    );

    await ref.read(scanProvider.notifier).confirmExpense(payload);
  }

  @override
  void dispose() {
    _supplierNameCtrl.dispose();
    _supplierCifCtrl.dispose();
    _supplierEmailCtrl.dispose();
    _supplierPhoneCtrl.dispose();
    _supplierAddressCtrl.dispose();
    _supplierPostalCtrl.dispose();
    _supplierNotesCtrl.dispose();
    _invoiceNumberCtrl.dispose();
    _issueDateCtrl.dispose();
    _dueDateCtrl.dispose();
    _totalCtrl.dispose();
    _taxCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scanProvider);
    final confidence = state.result?.confidence ?? 0;

    // Navigate home on success
    ref.listen<ScanState>(scanProvider, (prev, next) {
      if (next.confirmed != null && prev?.confirmed == null) {
        final supplierName = next.confirmed!.supplier['name'] as String? ?? '';
        final supplierCreated = next.confirmed!.supplierCreated;
        final msg = supplierCreated
            ? 'Factura registrada. Proveedor "$supplierName" creado automáticamente.'
            : 'Factura registrada correctamente.';

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

    return Stack(
      children: [
        Scaffold(
      appBar: AppBar(
        title: const Text('Revisar factura'),
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
                  style:
                      const TextStyle(color: AppColors.danger, fontSize: 13),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // ── Proveedor ──────────────────────────────────────────────────
            _SectionTitle('Proveedor'),
            const SizedBox(height: 8),

            // Matched supplier banner
            if (_matchedSupplier != null)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.successBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: AppColors.success, size: 16),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Proveedor encontrado en tu base de datos',
                        style: TextStyle(
                            color: AppColors.success, fontSize: 13),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          setState(() => _matchedSupplier = null),
                      child: const Icon(Icons.close,
                          color: AppColors.success, size: 16),
                    ),
                  ],
                ),
              ),

            // Nombre fiscal + search button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildField(
                    controller: _supplierNameCtrl,
                    label: 'Nombre fiscal',
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
                          width: 48,
                          height: 48,
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2),
                            ),
                          ),
                        )
                      : IconButton.filled(
                          onPressed: _searchSupplier,
                          icon: const Icon(Icons.search),
                          tooltip: 'Buscar en tu base de datos',
                          style: IconButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white),
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
            const SizedBox(height: 12),

            _buildField(
              controller: _supplierEmailCtrl,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),

            _buildField(
              controller: _supplierPhoneCtrl,
              label: 'Teléfono',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),

            _buildField(
              controller: _supplierAddressCtrl,
              label: 'Dirección',
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 12),

            _buildField(
              controller: _supplierPostalCtrl,
              label: 'Código postal',
              icon: Icons.markunread_mailbox_outlined,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            _buildField(
              controller: _supplierNotesCtrl,
              label: 'Notas',
              icon: Icons.notes,
              maxLines: 2,
            ),

            // ── Datos de la factura ────────────────────────────────────────
            const SizedBox(height: 24),
            _SectionTitle('Datos de la factura'),
            const SizedBox(height: 8),

            _buildField(
              controller: _invoiceNumberCtrl,
              label: 'Nº Factura',
              icon: Icons.tag,
            ),
            const SizedBox(height: 12),

            // Fecha emisión
            GestureDetector(
              onTap: () => _pickDate(_issueDateCtrl),
              child: AbsorbPointer(
                child: _buildField(
                  controller: _issueDateCtrl,
                  label: 'Fecha emisión',
                  icon: Icons.calendar_today,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Fecha requerida' : null,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Fecha vencimiento
            GestureDetector(
              onTap: () => _pickDate(_dueDateCtrl, allowFuture: true),
              child: AbsorbPointer(
                child: _buildField(
                  controller: _dueDateCtrl,
                  label: 'Fecha vencimiento',
                  icon: Icons.event_outlined,
                  hint: 'Opcional',
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Régimen fiscal
            DropdownButtonFormField<String>(
              value: _taxKind,
              decoration: InputDecoration(
                labelText: 'Régimen fiscal',
                prefixIcon: const Icon(Icons.account_balance_outlined,
                    color: AppColors.gray400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'IVA', child: Text('IVA')),
                DropdownMenuItem(value: 'IPSI', child: Text('IPSI')),
              ],
              onChanged: (v) => setState(() => _taxKind = v ?? 'IVA'),
            ),
            const SizedBox(height: 12),

            // Estado
            DropdownButtonFormField<String>(
              value: _status,
              decoration: InputDecoration(
                labelText: 'Estado',
                prefixIcon: const Icon(Icons.payments_outlined,
                    color: AppColors.gray400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'UNPAID', child: Text('Pendiente')),
                DropdownMenuItem(value: 'PAID', child: Text('Pagada')),
              ],
              onChanged: (v) => setState(() => _status = v ?? 'UNPAID'),
            ),

            // ── Importes ───────────────────────────────────────────────────
            const SizedBox(height: 24),
            _SectionTitle('Importes'),
            const SizedBox(height: 8),

            _buildField(
              controller: _totalCtrl,
              label: 'Total',
              icon: Icons.euro,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                final n = double.tryParse(v ?? '');
                if (n == null || n <= 0) return 'Total requerido';
                return null;
              },
            ),
            const SizedBox(height: 12),

            _buildField(
              controller: _taxCtrl,
              label: 'Impuesto / IVA',
              icon: Icons.receipt_long,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),

            // ── Líneas detectadas (read-only) ──────────────────────────────
            if (state.result != null &&
                state.result!.lines.isNotEmpty) ...[
              const SizedBox(height: 24),
              _SectionTitle(
                  'Líneas detectadas (${state.result!.lines.length})'),
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

            // Submit button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: state.isConfirming ? null : _submit,
                icon: const Icon(Icons.check),
                label: const Text('Registrar factura'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
        ),
        if (state.isConfirming) const _ConfirmProgressOverlay(),
      ],
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
        prefixIcon:
            icon != null ? Icon(icon, color: AppColors.gray400) : null,
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
              leading:
                  const Icon(Icons.store, color: AppColors.primary),
              title: Text(s.name),
              subtitle: s.taxId != null && s.taxId!.isNotEmpty
                  ? Text(s.taxId!,
                      style: const TextStyle(fontSize: 12))
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

// ── Confirm progress overlay ───────────────────────────────────────────────

class _ConfirmProgressOverlay extends StatefulWidget {
  const _ConfirmProgressOverlay();

  @override
  State<_ConfirmProgressOverlay> createState() =>
      _ConfirmProgressOverlayState();
}

class _ConfirmProgressOverlayState extends State<_ConfirmProgressOverlay> {
  // 0 = pending, 1 = active, 2 = done
  final List<int> _stepState = [1, 0, 0];

  final List<String> _labels = [
    'Guardando imagen',
    'Registrando proveedor',
    'Creando factura de compra',
  ];

  final List<IconData> _icons = [
    Icons.image_outlined,
    Icons.store_outlined,
    Icons.receipt_long_outlined,
  ];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 900), () {
      if (mounted) setState(() { _stepState[0] = 2; _stepState[1] = 1; });
    });
    Timer(const Duration(milliseconds: 1900), () {
      if (mounted) setState(() { _stepState[1] = 2; _stepState[2] = 1; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Registrando factura',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray800,
                ),
              ),
              const SizedBox(height: 24),
              ...List.generate(_labels.length, (i) => _StepRow(
                    icon: _icons[i],
                    label: _labels[i],
                    state: _stepState[i],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final int state; // 0=pending, 1=active, 2=done

  const _StepRow({required this.icon, required this.label, required this.state});

  @override
  Widget build(BuildContext context) {
    final isPending = state == 0;
    final isActive = state == 1;
    final isDone = state == 2;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: isActive
                ? const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.primary,
                  )
                : isDone
                    ? const Icon(Icons.check_circle,
                        color: AppColors.success, size: 28)
                    : Icon(Icons.radio_button_unchecked,
                        color: AppColors.gray300, size: 28),
          ),
          const SizedBox(width: 14),
          Icon(icon,
              size: 18,
              color: isPending ? AppColors.gray300 : AppColors.primary),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  isActive ? FontWeight.w600 : FontWeight.w400,
              color: isPending ? AppColors.gray400 : AppColors.gray800,
            ),
          ),
        ],
      ),
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
