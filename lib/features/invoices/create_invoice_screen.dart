import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/client.dart';
import '../../core/models/product.dart';
import '../../core/models/service.dart';
import '../../core/theme/app_colors.dart';
import '../clients/create_client_screen.dart';

// ── Providers ────────────────────────────────────────────────────────────────

final _clientsForInvoiceProvider =
    FutureProvider.autoDispose<List<Client>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final res = await endpoints.getClients(limit: 100);
  return res.items;
});

final _productsForInvoiceProvider =
    FutureProvider.autoDispose<List<Product>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final res = await endpoints.getProducts(limit: 100);
  return res.items;
});

final _servicesForInvoiceProvider =
    FutureProvider.autoDispose<List<Service>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final res = await endpoints.getServices(limit: 100);
  return res.items;
});

// ── Line model ────────────────────────────────────────────────────────────────

class _InvoiceLine {
  String description;
  double quantity;
  double unitPrice;
  double taxRate;
  double discountRate;
  int? productId;
  int? serviceId;

  _InvoiceLine({
    this.description = '',
    this.quantity = 1,
    this.unitPrice = 0,
    this.taxRate = 21,
    this.discountRate = 0,
    this.productId,
    this.serviceId,
  });

  double get base => quantity * unitPrice * (1 - discountRate / 100);
  double get taxAmount => base * (taxRate / 100);
  double get total => base + taxAmount;
}

// ── Screen ────────────────────────────────────────────────────────────────────

class CreateInvoiceScreen extends ConsumerStatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  ConsumerState<CreateInvoiceScreen> createState() =>
      _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends ConsumerState<CreateInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  bool _showSuccess = false;

  Client? _selectedClient;
  String _taxKind = 'IVA';
  DateTime _issuedAt = DateTime.now();
  final _notesCtrl = TextEditingController();
  final List<_InvoiceLine> _lines = [_InvoiceLine()];

  final _currencyFmt = NumberFormat.currency(locale: 'es_ES', symbol: '€');

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  double get _subtotal => _lines.fold(0, (s, l) => s + l.base);
  double get _totalTax => _lines.fold(0, (s, l) => s + l.taxAmount);
  double get _total => _lines.fold(0, (s, l) => s + l.total);

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedClient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona un cliente para continuar.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }
    if (_lines.any((l) => l.description.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rellena la descripción de todas las líneas.'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    setState(() => _saving = true);

    final payload = {
      'clientId': _selectedClient!.id,
      'issuedAt': _issuedAt.toUtc().toIso8601String(),
      'taxKind': _taxKind,
      if (_notesCtrl.text.trim().isNotEmpty)
        'publicNotes': _notesCtrl.text.trim(),
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

    try {
      final endpoints = ref.read(endpointsProvider);
      await endpoints.createInvoice(payload);

      if (!mounted) return;
      setState(() {
        _saving = false;
        _showSuccess = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        context.go('/invoices');
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al crear la factura: $e'),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _issuedAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _issuedAt = picked);
  }

  Future<void> _createClientInline() async {
    final result = await context.push<Client>('/clients/new');
    if (result != null) {
      ref.invalidate(_clientsForInvoiceProvider);
      setState(() => _selectedClient = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Nueva factura'),
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
                  onPressed: _submit,
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
                // Notice: always draft
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.warningBg,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: AppColors.warning.withOpacity(0.4)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: AppColors.warning, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Las facturas creadas desde móvil se guardan como borrador.',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.warning),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ── Cliente ─────────────────────────────────────────────────
                _SectionTitle('Cliente'),
                const SizedBox(height: 8),
                _ClientSelector(
                  selected: _selectedClient,
                  onChanged: (c) => setState(() => _selectedClient = c),
                  onCreateNew: _createClientInline,
                ),
                const SizedBox(height: 20),

                // ── Datos generales ─────────────────────────────────────────
                _SectionTitle('Datos de la factura'),
                const SizedBox(height: 8),
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
                            suffixIcon: const Icon(Icons.calendar_today,
                                size: 18),
                          ),
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(_issuedAt),
                            style: const TextStyle(fontSize: 14),
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
                            items: const [
                              DropdownMenuItem(
                                  value: 'IVA', child: Text('IVA')),
                              DropdownMenuItem(
                                  value: 'IPSI', child: Text('IPSI')),
                            ],
                            onChanged: (v) {
                              if (v != null) setState(() => _taxKind = v);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ── Líneas ──────────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _SectionTitle('Líneas de factura'),
                    TextButton.icon(
                      onPressed: () =>
                          setState(() => _lines.add(_InvoiceLine(
                                taxRate: _taxKind == 'IVA' ? 21 : 10,
                              ))),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Añadir línea'),
                      style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ..._lines.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final line = entry.value;
                  return _LineCard(
                    key: ValueKey(idx),
                    line: line,
                    taxKind: _taxKind,
                    canDelete: _lines.length > 1,
                    onDelete: () => setState(() => _lines.removeAt(idx)),
                    onChanged: () => setState(() {}),
                  );
                }),
                const SizedBox(height: 20),

                // ── Totales ─────────────────────────────────────────────────
                _TotalsBox(
                  subtotal: _subtotal,
                  totalTax: _totalTax,
                  total: _total,
                  taxKind: _taxKind,
                  fmt: _currencyFmt,
                ),
                const SizedBox(height: 20),

                // ── Notas ───────────────────────────────────────────────────
                _SectionTitle('Observaciones (opcional)'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesCtrl,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: InputDecoration(
                    hintText: 'Se imprimirán en la factura...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 20),

                // ── Botón ───────────────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
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
                            'Guardar como borrador',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),

        // ── Success overlay ─────────────────────────────────────────────────
        if (_showSuccess)
          Container(
            color: Colors.black54,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle,
                        color: AppColors.success, size: 56),
                    const SizedBox(height: 16),
                    const Text(
                      '¡Borrador creado!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gray800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'La factura ha sido guardada como borrador.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, color: AppColors.gray500),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Subwidgets ─────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.gray500,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _ClientSelector extends ConsumerWidget {
  final Client? selected;
  final ValueChanged<Client?> onChanged;
  final VoidCallback onCreateNew;

  const _ClientSelector({
    required this.selected,
    required this.onChanged,
    required this.onCreateNew,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(_clientsForInvoiceProvider);

    return clientsAsync.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('Error cargando clientes: $e'),
      data: (clients) {
        return Row(
          children: [
            Expanded(
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Cliente *',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Client>(
                    value: clients.any((c) => c.id == selected?.id)
                        ? selected
                        : null,
                    hint: const Text('Selecciona cliente...'),
                    isExpanded: true,
                    isDense: true,
                    items: clients
                        .map((c) => DropdownMenuItem<Client>(
                              value: c,
                              child: Text(
                                c.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: 'Crear nuevo cliente',
              child: InkWell(
                onTap: onCreateNew,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 44,
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primaryBg,
                  ),
                  child: const Icon(Icons.person_add,
                      color: AppColors.primary, size: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LineCard extends ConsumerStatefulWidget {
  final _InvoiceLine line;
  final String taxKind;
  final bool canDelete;
  final VoidCallback onDelete;
  final VoidCallback onChanged;

  const _LineCard({
    super.key,
    required this.line,
    required this.taxKind,
    required this.canDelete,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  ConsumerState<_LineCard> createState() => _LineCardState();
}

class _LineCardState extends ConsumerState<_LineCard> {
  late final TextEditingController _descCtrl;
  late final TextEditingController _qtyCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _discCtrl;

  @override
  void initState() {
    super.initState();
    _descCtrl  = TextEditingController(text: widget.line.description);
    _qtyCtrl   = TextEditingController(text: widget.line.quantity.toInt().toString());
    _priceCtrl = TextEditingController(text: widget.line.unitPrice == 0 ? '' : widget.line.unitPrice.toString());
    _discCtrl  = TextEditingController(text: widget.line.discountRate == 0 ? '' : widget.line.discountRate.toString());
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    _qtyCtrl.dispose();
    _priceCtrl.dispose();
    _discCtrl.dispose();
    super.dispose();
  }

  void _applyProduct(Product p) {
    widget.line.description = p.name;
    widget.line.unitPrice = p.price;
    widget.line.productId = p.id;
    widget.line.serviceId = null;
    _descCtrl.text = p.name;
    _priceCtrl.text = p.price.toString();
    widget.onChanged();
  }

  void _applyService(Service s) {
    widget.line.description = s.name;
    widget.line.unitPrice = s.unitPrice;
    widget.line.taxRate = s.taxRate;
    widget.line.serviceId = s.id;
    widget.line.productId = null;
    _descCtrl.text = s.name;
    _priceCtrl.text = s.unitPrice.toString();
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(_productsForInvoiceProvider);
    final servicesAsync = ref.watch(_servicesForInvoiceProvider);

    final fmt = NumberFormat.currency(locale: 'es_ES', symbol: '€');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.border),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                // Product/Service quick-fill
                Expanded(
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      final parts = value.split(':');
                      final type = parts[0];
                      final id = int.parse(parts[1]);
                      if (type == 'p') {
                        final products = productsAsync.valueOrNull ?? [];
                        final p = products.firstWhere((x) => x.id == id);
                        _applyProduct(p);
                      } else {
                        final services = servicesAsync.valueOrNull ?? [];
                        final s = services.firstWhere((x) => x.id == id);
                        _applyService(s);
                      }
                    },
                    itemBuilder: (_) {
                      final items = <PopupMenuEntry<String>>[];
                      final products = productsAsync.valueOrNull ?? [];
                      final services = servicesAsync.valueOrNull ?? [];
                      if (products.isNotEmpty) {
                        items.add(const PopupMenuItem(
                          enabled: false,
                          child: Text('— ARTÍCULOS —',
                              style: TextStyle(
                                  fontSize: 11, color: AppColors.gray400)),
                        ));
                        items.addAll(products.map((p) => PopupMenuItem(
                              value: 'p:${p.id}',
                              child: Text(p.name),
                            )));
                      }
                      if (services.isNotEmpty) {
                        items.add(const PopupMenuItem(
                          enabled: false,
                          child: Text('— SERVICIOS —',
                              style: TextStyle(
                                  fontSize: 11, color: AppColors.gray400)),
                        ));
                        items.addAll(services.map((s) => PopupMenuItem(
                              value: 's:${s.id}',
                              child: Text(s.name),
                            )));
                      }
                      if (items.isEmpty) {
                        items.add(const PopupMenuItem(
                          enabled: false,
                          child: Text('Sin artículos ni servicios'),
                        ));
                      }
                      return items;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBg,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: AppColors.primary.withOpacity(0.3)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search, size: 14, color: AppColors.primary),
                          SizedBox(width: 4),
                          Text('Artículo / Servicio',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.primary)),
                        ],
                      ),
                    ),
                  ),
                ),
                if (widget.canDelete)
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: AppColors.danger, size: 20),
                    onPressed: widget.onDelete,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                        minWidth: 36, minHeight: 36),
                  ),
              ],
            ),
            const SizedBox(height: 10),

            // Description
            TextFormField(
              controller: _descCtrl,
              decoration: InputDecoration(
                labelText: 'Descripción *',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                isDense: true,
              ),
              onChanged: (v) {
                widget.line.description = v;
                widget.onChanged();
              },
            ),
            const SizedBox(height: 10),

            // Qty + Price row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _qtyCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Cant.',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      isDense: true,
                    ),
                    onChanged: (v) {
                      widget.line.quantity =
                          double.tryParse(v) ?? 1;
                      widget.onChanged();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _priceCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Precio',
                      suffixText: '€',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      isDense: true,
                    ),
                    onChanged: (v) {
                      widget.line.unitPrice =
                          double.tryParse(v.replaceAll(',', '.')) ?? 0;
                      widget.onChanged();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Tax + Discount row
            Row(
              children: [
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: widget.taxKind,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      isDense: true,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<double>(
                        value: widget.line.taxRate,
                        isDense: true,
                        items: (widget.taxKind == 'IVA'
                                ? [0, 4, 10, 21]
                                : [0, 0.5, 1, 4, 8, 10, 10.5])
                            .map((r) => DropdownMenuItem(
                                  value: r.toDouble(),
                                  child: Text('$r%'),
                                ))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            widget.line.taxRate = v;
                            widget.onChanged();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _discCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Dto. %',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      isDense: true,
                    ),
                    onChanged: (v) {
                      widget.line.discountRate =
                          double.tryParse(v.replaceAll(',', '.')) ?? 0;
                      widget.onChanged();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Line total
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total: ${fmt.format(widget.line.total)}',
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.gray800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalsBox extends StatelessWidget {
  final double subtotal;
  final double totalTax;
  final double total;
  final String taxKind;
  final NumberFormat fmt;

  const _TotalsBox({
    required this.subtotal,
    required this.totalTax,
    required this.total,
    required this.taxKind,
    required this.fmt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          _row('Base imponible', fmt.format(subtotal)),
          const SizedBox(height: 6),
          _row(taxKind, fmt.format(totalTax)),
          const Divider(height: 16),
          _row('TOTAL', fmt.format(total), bold: true, large: true),
        ],
      ),
    );
  }

  Widget _row(String label, String value,
      {bool bold = false, bool large = false}) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
      fontSize: large ? 16 : 14,
      color: bold ? AppColors.primary : AppColors.gray700,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
