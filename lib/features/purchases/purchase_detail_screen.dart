import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/auth_provider.dart';
import '../../core/models/purchase.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/date.dart';
import '../../core/utils/error_messages.dart';
import '../../core/utils/number_parsing.dart';
import '../../widgets/loading_indicator.dart';
import '../dashboard/dashboard_screen.dart';
import '../suppliers/suppliers_screen.dart';
import 'purchases_screen.dart';

final purchaseDetailProvider = FutureProvider.autoDispose
    .family<PurchaseDetail, int>((ref, id) async {
      return ref.watch(endpointsProvider).getPurchase(id);
    });

class PurchaseDetailScreen extends ConsumerStatefulWidget {
  const PurchaseDetailScreen({super.key, required this.id});

  final int id;

  @override
  ConsumerState<PurchaseDetailScreen> createState() =>
      _PurchaseDetailScreenState();
}

class _PurchaseDetailScreenState extends ConsumerState<PurchaseDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _supplierNameCtrl = TextEditingController();
  final _supplierCifCtrl = TextEditingController();
  final _supplierEmailCtrl = TextEditingController();
  final _supplierPhoneCtrl = TextEditingController();
  final _supplierAddressCtrl = TextEditingController();
  final _supplierPostalCtrl = TextEditingController();
  final _supplierNotesCtrl = TextEditingController();
  final _invoiceNumberCtrl = TextEditingController();
  final _issueDateCtrl = TextEditingController();
  final _dueDateCtrl = TextEditingController();
  final _paidDateCtrl = TextEditingController();
  final _totalCtrl = TextEditingController();
  final _taxCtrl = TextEditingController();

  final List<_PurchaseLineDraft> _lines = [];
  int? _supplierId;
  String _taxKind = 'IVA';
  String _status = 'UNPAID';
  bool _loaded = false;
  bool _saving = false;
  String? _error;

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
    _paidDateCtrl.dispose();
    _totalCtrl.dispose();
    _taxCtrl.dispose();
    for (final line in _lines) {
      line.dispose();
    }
    super.dispose();
  }

  void _load(PurchaseDetail purchase) {
    if (_loaded) return;
    _loaded = true;
    _supplierId = purchase.supplierId;
    _supplierNameCtrl.text = purchase.supplierName;
    _supplierCifCtrl.text = purchase.supplierTaxId;
    _supplierEmailCtrl.text = purchase.supplier['email'] as String? ?? '';
    _supplierPhoneCtrl.text = purchase.supplier['phone'] as String? ?? '';
    _supplierAddressCtrl.text = purchase.supplier['address'] as String? ?? '';
    _supplierPostalCtrl.text = purchase.supplier['postalCode'] as String? ?? '';
    _supplierNotesCtrl.text = purchase.supplier['notes'] as String? ?? '';
    _invoiceNumberCtrl.text = purchase.invoiceNumber ?? '';
    _issueDateCtrl.text = formatIsoDateForDisplay(purchase.issueDate);
    _dueDateCtrl.text = formatIsoDateForDisplay(purchase.dueDate ?? '');
    _paidDateCtrl.text = formatIsoDateForDisplay(purchase.paidAt ?? '');
    _totalCtrl.text = purchase.total.toStringAsFixed(2);
    _taxCtrl.text = purchase.tax.toStringAsFixed(2);
    _taxKind = purchase.taxKind;
    _status = purchase.status;
    if (_status == 'PAID' && _paidDateCtrl.text.trim().isEmpty) {
      _paidDateCtrl.text = _issueDateCtrl.text;
    }
    _lines
      ..clear()
      ..addAll(purchase.lines.map(_PurchaseLineDraft.fromLine));
    if (_lines.isEmpty) _lines.add(_PurchaseLineDraft.empty());
  }

  Future<void> _pickDate(TextEditingController ctrl) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      ctrl.text = formatIsoDateForDisplay(picked.toIso8601String());
    }
  }

  void _syncTotalsFromLines() {
    _taxCtrl.text = _lines
        .fold<double>(0, (sum, line) => sum + line.taxAmount)
        .toStringAsFixed(2);
    _totalCtrl.text = _lines
        .fold<double>(0, (sum, line) => sum + line.total)
        .toStringAsFixed(2);
  }

  void _setStatus(String status) {
    setState(() {
      _status = status;
      if (_status == 'PAID' && _paidDateCtrl.text.trim().isEmpty) {
        _paidDateCtrl.text = _issueDateCtrl.text;
      }
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      final endpoints = ref.read(endpointsProvider);
      if (_supplierId != null) {
        await endpoints.updateSupplier(_supplierId!, {
          'name': _supplierNameCtrl.text.trim(),
          'taxId': _supplierCifCtrl.text.trim(),
          'email': _supplierEmailCtrl.text.trim(),
          'phone': _supplierPhoneCtrl.text.trim(),
          'address': _supplierAddressCtrl.text.trim(),
          'postalCode': _supplierPostalCtrl.text.trim(),
          'notes': _supplierNotesCtrl.text.trim(),
        });
      }

      await endpoints.updatePurchase(widget.id, {
        if (_supplierId != null) 'supplierId': _supplierId,
        'invoiceNumber': _invoiceNumberCtrl.text.trim(),
        'issueDate': parseDisplayDateToApiIso(_issueDateCtrl.text),
        if (_dueDateCtrl.text.trim().isNotEmpty)
          'dueDate': parseDisplayDateToApiIso(_dueDateCtrl.text),
        if (_dueDateCtrl.text.trim().isEmpty) 'dueDate': null,
        'taxKind': _taxKind,
        'status': _status,
        if (_status == 'PAID')
          'paidAt': parseDisplayDateToApiIso(
            _paidDateCtrl.text.trim().isNotEmpty
                ? _paidDateCtrl.text
                : _issueDateCtrl.text,
          ),
        if (_status != 'PAID') 'paidAt': null,
        'total': parseLocalizedDecimal(_totalCtrl.text),
        'tax': parseLocalizedDecimal(_taxCtrl.text),
        'lines': _lines
            .map(
              (line) => {
                'description': line.description,
                'base': line.base,
                'taxRate': line.taxRate,
                'taxAmount': line.taxAmount,
              },
            )
            .toList(),
      });

      ref.invalidate(purchaseDetailProvider(widget.id));
      ref.invalidate(purchasesProvider);
      ref.invalidate(suppliersProvider);
      ref.invalidate(mobileDashboardProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Factura de proveedor actualizada'),
          backgroundColor: context.statusSuccess,
        ),
      );
      context.pop();
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = friendlyError(
            e,
            fallback: 'No se pudo guardar la factura de proveedor.',
          );
        });
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _addLine() {
    setState(() {
      _lines.add(_PurchaseLineDraft.empty());
      _syncTotalsFromLines();
    });
  }

  void _removeLine(int index) {
    setState(() {
      _lines.removeAt(index).dispose();
      _syncTotalsFromLines();
    });
  }

  @override
  Widget build(BuildContext context) {
    final purchaseAsync = ref.watch(purchaseDetailProvider(widget.id));

    return Scaffold(
      appBar: AppBar(title: const Text('Editar compra')),
      body: purchaseAsync.when(
        loading: () => const LoadingIndicator(),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              friendlyError(err, fallback: 'No se pudo cargar la compra.'),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (purchase) {
          _load(purchase);
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
                _section('Proveedor'),
                _field(
                  _supplierNameCtrl,
                  'Nombre fiscal',
                  Icons.store,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Nombre requerido' : null,
                ),
                _field(_supplierCifCtrl, 'CIF / NIF', Icons.badge),
                _field(
                  _supplierEmailCtrl,
                  'Email',
                  Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                _field(
                  _supplierPhoneCtrl,
                  'Teléfono',
                  Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                _field(
                  _supplierAddressCtrl,
                  'Dirección',
                  Icons.location_on_outlined,
                ),
                _field(
                  _supplierPostalCtrl,
                  'Código postal',
                  Icons.markunread_mailbox_outlined,
                ),
                _field(_supplierNotesCtrl, 'Notas', Icons.notes, maxLines: 2),
                const SizedBox(height: 16),
                _section('Factura'),
                _field(_invoiceNumberCtrl, 'Nº Factura', Icons.tag),
                GestureDetector(
                  onTap: () => _pickDate(_issueDateCtrl),
                  child: AbsorbPointer(
                    child: _field(
                      _issueDateCtrl,
                      'Fecha emisión',
                      Icons.calendar_today,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Fecha requerida'
                          : null,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _pickDate(_dueDateCtrl),
                  child: AbsorbPointer(
                    child: _field(
                      _dueDateCtrl,
                      'Fecha vencimiento',
                      Icons.event_outlined,
                    ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  initialValue: _taxKind,
                  decoration: InputDecoration(
                    labelText: 'Régimen fiscal',
                    prefixIcon: Icon(
                      Icons.account_balance_outlined,
                      color: context.appTextSubtle,
                    ),
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
                DropdownButtonFormField<String>(
                  initialValue: _status,
                  decoration: InputDecoration(
                    labelText: 'Estado',
                    prefixIcon: Icon(
                      Icons.payments_outlined,
                      color: context.appTextSubtle,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'UNPAID', child: Text('Pendiente')),
                    DropdownMenuItem(value: 'PAID', child: Text('Pagada')),
                  ],
                  onChanged: (v) => _setStatus(v ?? 'UNPAID'),
                ),
                if (_status == 'PAID')
                  GestureDetector(
                    onTap: () => _pickDate(_paidDateCtrl),
                    child: AbsorbPointer(
                      child: _field(
                        _paidDateCtrl,
                        'Fecha de pago',
                        Icons.event_available_outlined,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Fecha de pago requerida'
                            : null,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                _section('Importes'),
                _numberField(
                  _totalCtrl,
                  'Total',
                  Icons.euro,
                  validator: (v) => parseLocalizedDecimal(v ?? '') <= 0
                      ? 'Total requerido'
                      : null,
                ),
                _numberField(_taxCtrl, 'Impuesto / IVA', Icons.receipt_long),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _section('Líneas (${_lines.length})')),
                    TextButton.icon(
                      onPressed: _saving ? null : _addLine,
                      icon: const Icon(Icons.add),
                      label: const Text('Añadir'),
                    ),
                  ],
                ),
                ..._lines.asMap().entries.map(
                  (entry) => _PurchaseLineEditor(
                    index: entry.key,
                    line: entry.value,
                    canDelete: _lines.length > 1,
                    onChanged: () => setState(_syncTotalsFromLines),
                    onDelete: () => _removeLine(entry.key),
                  ),
                ),
                const SizedBox(height: 24),
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
                    label: const Text('Guardar cambios'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _section(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        color: context.appText,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: context.appTextSubtle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _numberField(
    TextEditingController controller,
    String label,
    IconData icon, {
    String? Function(String?)? validator,
  }) {
    return _field(
      controller,
      label,
      icon,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: validator,
    );
  }
}

class _PurchaseLineDraft {
  _PurchaseLineDraft({
    required String description,
    required double base,
    required double taxRate,
    required double taxAmount,
  }) : descriptionCtrl = TextEditingController(text: description),
       baseCtrl = TextEditingController(text: base.toStringAsFixed(2)),
       taxRateCtrl = TextEditingController(text: taxRate.toStringAsFixed(2)),
       taxAmountCtrl = TextEditingController(
         text: taxAmount.toStringAsFixed(2),
       );

  factory _PurchaseLineDraft.fromLine(PurchaseLine line) => _PurchaseLineDraft(
    description: line.description,
    base: line.base,
    taxRate: line.taxRate,
    taxAmount: line.taxAmount,
  );

  factory _PurchaseLineDraft.empty() =>
      _PurchaseLineDraft(description: '', base: 0, taxRate: 21, taxAmount: 0);

  final TextEditingController descriptionCtrl;
  final TextEditingController baseCtrl;
  final TextEditingController taxRateCtrl;
  final TextEditingController taxAmountCtrl;

  String get description => descriptionCtrl.text.trim();
  double get base => parseLocalizedDecimal(baseCtrl.text);
  double get taxRate => parseLocalizedDecimal(taxRateCtrl.text);
  double get taxAmount {
    final explicit = parseLocalizedDecimal(taxAmountCtrl.text, fallback: -1);
    if (explicit >= 0) return explicit;
    return base * taxRate / 100;
  }

  double get total => base + taxAmount;

  void dispose() {
    descriptionCtrl.dispose();
    baseCtrl.dispose();
    taxRateCtrl.dispose();
    taxAmountCtrl.dispose();
  }
}

class _PurchaseLineEditor extends StatelessWidget {
  const _PurchaseLineEditor({
    required this.index,
    required this.line,
    required this.canDelete,
    required this.onChanged,
    required this.onDelete,
  });

  final int index;
  final _PurchaseLineDraft line;
  final bool canDelete;
  final VoidCallback onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appSurfaceRaised,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.appBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Línea ${index + 1}',
                  style: TextStyle(
                    color: context.appText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '${line.total.toStringAsFixed(2)} EUR',
                style: TextStyle(
                  color: context.appPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (canDelete)
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete_outline, color: context.statusDanger),
                ),
            ],
          ),
          TextFormField(
            controller: line.descriptionCtrl,
            decoration: InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
            ),
            style: TextStyle(color: context.appText),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Descripción requerida' : null,
            onChanged: (_) => onChanged(),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _number(context, line.baseCtrl, 'Base', 'EUR')),
              const SizedBox(width: 8),
              Expanded(child: _number(context, line.taxRateCtrl, 'IVA', '%')),
              const SizedBox(width: 8),
              Expanded(
                child: _number(context, line.taxAmountCtrl, 'Cuota', 'EUR'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _number(
    BuildContext context,
    TextEditingController controller,
    String label,
    String suffix,
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'))],
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        isDense: true,
      ),
      style: TextStyle(color: context.appText),
      onChanged: (_) => onChanged(),
    );
  }
}
