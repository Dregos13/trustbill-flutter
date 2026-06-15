import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/product.dart';
import '../../core/models/service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/error_messages.dart';
import '../../widgets/doc_line_editor.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import 'invoice_detail_screen.dart';

/// Edit a DRAFT invoice's content. Reuses the shared [DocLineCard] editor.
/// The server rejects edits on non-draft / paid / sale-linked invoices (409).
class EditInvoiceScreen extends ConsumerStatefulWidget {
  final int id;
  const EditInvoiceScreen({super.key, required this.id});

  @override
  ConsumerState<EditInvoiceScreen> createState() => _EditInvoiceScreenState();
}

class _EditInvoiceScreenState extends ConsumerState<EditInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesCtrl = TextEditingController();
  final _currencyFmt = NumberFormat.currency(locale: 'es_ES', symbol: '€');

  bool _loading = true;
  bool _saving = false;
  String? _loadError;

  String _taxKind = 'IVA';
  DateTime _issuedAt = DateTime.now();
  List<DocLine> _lines = [];
  List<Product> _products = [];
  List<Service> _services = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final ep = ref.read(endpointsProvider);
      final invoice = await ep.getInvoice(widget.id);
      final products = await ep.getProducts(limit: 100);
      final services = await ep.getServices(limit: 100);
      if (!mounted) return;
      setState(() {
        _taxKind = invoice.taxKind ?? 'IVA';
        _issuedAt = DateTime.tryParse(invoice.issuedAt) ?? DateTime.now();
        _notesCtrl.text = invoice.publicNotes ?? '';
        _lines = invoice.lines
            .map((l) => DocLine(
                  description: l.description,
                  quantity: l.quantity,
                  unitPrice: l.unitPrice,
                  taxRate: l.taxRate,
                  discountRate: l.discountRate,
                ))
            .toList();
        if (_lines.isEmpty) _lines = [DocLine(taxRate: _taxKind == 'IVA' ? 21 : 10)];
        _products = products.items;
        _services = services.items;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadError = friendlyError(e, fallback: 'No se pudo cargar la factura.');
        _loading = false;
      });
    }
  }

  double get _subtotal => _lines.fold(0, (s, l) => s + l.base);
  double get _totalTax => _lines.fold(0, (s, l) => s + l.taxAmount);
  double get _total => _lines.fold(0, (s, l) => s + l.total);

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _issuedAt,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _issuedAt = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final body = {
      'issuedAt': _issuedAt.toUtc().toIso8601String(),
      'taxKind': _taxKind,
      'publicNotes':
          _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      'lines': _lines
          .map((l) => {
                'description': l.description.trim(),
                'quantity': l.quantity.toInt(),
                'unitPrice': l.unitPrice,
                'taxRate': l.taxRate,
                'discountRate': l.discountRate,
                if (l.productId != null) 'productId': l.productId,
                if (l.serviceId != null) 'serviceId': l.serviceId,
              })
          .toList(),
    };

    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(endpointsProvider).updateInvoiceContent(widget.id, body);
      if (!mounted) return;
      ref.invalidate(invoiceDetailProvider(widget.id));
      messenger.showSnackBar(
        const SnackBar(content: Text('Factura actualizada')),
      );
      context.pop();
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      messenger.showSnackBar(
        SnackBar(
          content: Text(friendlyError(e,
              fallback: 'No se pudo guardar. Verifica los datos.')),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar borrador'),
        backgroundColor: context.appPrimary,
        foregroundColor: Colors.white,
        actions: [
          if (!_loading && _loadError == null)
            _saving
                ? const Padding(
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
                : TextButton(
                    onPressed: _save,
                    child: const Text(
                      'Guardar',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
        ],
      ),
      body: _loading
          ? const LoadingIndicator()
          : _loadError != null
              ? EmptyState(message: _loadError!)
              : _buildForm(),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Date + tax regime
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(8),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Fecha de emisión',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      suffixIcon: const Icon(Icons.calendar_today, size: 18),
                    ),
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(_issuedAt),
                      style: TextStyle(fontSize: 14, color: context.appText),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Régimen fiscal',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _taxKind,
                      isDense: true,
                      dropdownColor: context.appSurfaceRaised,
                      items: [
                        DropdownMenuItem(
                            value: 'IVA',
                            child: Text('IVA',
                                style: TextStyle(color: context.appText))),
                        DropdownMenuItem(
                            value: 'IPSI',
                            child: Text('IPSI',
                                style: TextStyle(color: context.appText))),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          setState(() {
                            _taxKind = v;
                            for (final line in _lines) {
                              line.taxRate = v == 'IVA' ? 21 : 10;
                            }
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Lines
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LÍNEAS DE FACTURA',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: context.appTextMuted,
                  letterSpacing: 0.8,
                ),
              ),
              TextButton.icon(
                onPressed: () => setState(() => _lines.add(
                    DocLine(taxRate: _taxKind == 'IVA' ? 21 : 10))),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Añadir línea'),
                style:
                    TextButton.styleFrom(foregroundColor: context.appPrimary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ..._lines.asMap().entries.map((entry) {
            final idx = entry.key;
            final line = entry.value;
            return DocLineCard(
              key: ValueKey('line_$idx'),
              line: line,
              taxKind: _taxKind,
              products: _products,
              services: _services,
              canDelete: _lines.length > 1,
              onDelete: () => setState(() => _lines.removeAt(idx)),
              onChanged: () => setState(() {}),
            );
          }),
          const SizedBox(height: 12),

          DocTotalsBox(
            subtotal: _subtotal,
            totalTax: _totalTax,
            total: _total,
            taxKind: _taxKind,
            fmt: _currencyFmt,
          ),
          const SizedBox(height: 20),

          // Public notes
          Text(
            'OBSERVACIONES (OPCIONAL)',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: context.appTextMuted,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _notesCtrl,
            maxLines: 3,
            maxLength: 200,
            decoration: InputDecoration(
              hintText: 'Se imprimirán en la factura...',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text(
                      'Guardar cambios',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
