import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../core/models/product.dart';
import '../core/models/service.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme_tokens.dart';

/// Mutable draft line shared by the budget / sale create editors.
/// Mirrors the line math used by the desktop and the API:
/// base = qty * price * (1 - disc/100); tax = base * rate/100.
class DocLine {
  String description;
  double quantity;
  double unitPrice;
  double taxRate;
  double discountRate;
  int? productId;
  int? serviceId;

  DocLine({
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

List<double> taxRateOptions(String taxKind) =>
    (taxKind == 'IVA' ? [0, 4, 10, 21] : [0, 0.5, 1, 4, 8, 10, 10.5])
        .map((e) => e.toDouble())
        .toList();

class DocLineCard extends StatefulWidget {
  final DocLine line;
  final String taxKind;
  final List<Product> products;
  final List<Service> services;
  final bool canDelete;
  final VoidCallback onDelete;
  final VoidCallback onChanged;

  const DocLineCard({
    super.key,
    required this.line,
    required this.taxKind,
    required this.products,
    required this.services,
    required this.canDelete,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  State<DocLineCard> createState() => _DocLineCardState();
}

class _DocLineCardState extends State<DocLineCard> {
  late final TextEditingController _descCtrl;
  late final TextEditingController _qtyCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _discCtrl;

  @override
  void initState() {
    super.initState();
    _descCtrl = TextEditingController(text: widget.line.description);
    _qtyCtrl =
        TextEditingController(text: widget.line.quantity.toInt().toString());
    _priceCtrl = TextEditingController(
        text: widget.line.unitPrice == 0 ? '' : widget.line.unitPrice.toString());
    _discCtrl = TextEditingController(
        text: widget.line.discountRate == 0
            ? ''
            : widget.line.discountRate.toString());
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
    final fmt = NumberFormat.currency(locale: 'es_ES', symbol: '€');
    final options = taxRateOptions(widget.taxKind);
    final currentRate =
        options.contains(widget.line.taxRate) ? widget.line.taxRate : options.first;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: context.appSurfaceRaised,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: context.appBorder),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: PopupMenuButton<String>(
                    color: context.appSurfaceRaised,
                    onSelected: (value) {
                      final parts = value.split(':');
                      final id = int.parse(parts[1]);
                      if (parts[0] == 'p') {
                        _applyProduct(
                            widget.products.firstWhere((x) => x.id == id));
                      } else {
                        _applyService(
                            widget.services.firstWhere((x) => x.id == id));
                      }
                    },
                    itemBuilder: (_) {
                      final items = <PopupMenuEntry<String>>[];
                      if (widget.products.isNotEmpty) {
                        items.add(PopupMenuItem(
                            enabled: false,
                            child: Text('— ARTÍCULOS —',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: context.appTextSubtle))));
                        items.addAll(widget.products.map((p) => PopupMenuItem(
                            value: 'p:${p.id}',
                            child: Text(p.name,
                                style: TextStyle(color: context.appText)))));
                      }
                      if (widget.services.isNotEmpty) {
                        items.add(PopupMenuItem(
                            enabled: false,
                            child: Text('— SERVICIOS —',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: context.appTextSubtle))));
                        items.addAll(widget.services.map((s) => PopupMenuItem(
                            value: 's:${s.id}',
                            child: Text(s.name,
                                style: TextStyle(color: context.appText)))));
                      }
                      if (items.isEmpty) {
                        items.add(PopupMenuItem(
                            enabled: false,
                            child: Text('Sin artículos ni servicios',
                                style: TextStyle(color: context.appTextMuted))));
                      }
                      return items;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: context.appPrimarySoft,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: context.appPrimary.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search,
                              size: 14, color: context.appPrimary),
                          const SizedBox(width: 4),
                          Text('Artículo / Servicio',
                              style: TextStyle(
                                  fontSize: 12, color: context.appPrimary)),
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
                    constraints:
                        const BoxConstraints(minWidth: 36, minHeight: 36),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descCtrl,
              decoration: InputDecoration(
                labelText: 'Descripción *',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                isDense: true,
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Descripción requerida' : null,
              onChanged: (v) {
                widget.line.description = v;
                widget.onChanged();
              },
            ),
            const SizedBox(height: 10),
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
                    validator: (v) {
                      final n = int.tryParse(v ?? '');
                      if (n == null || n < 1) return 'Mín. 1';
                      return null;
                    },
                    onChanged: (v) {
                      widget.line.quantity = double.tryParse(v) ?? 1;
                      widget.onChanged();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _priceCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Precio *',
                      suffixText: '€',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      isDense: true,
                    ),
                    validator: (v) {
                      final n =
                          double.tryParse((v ?? '').replaceAll(',', '.'));
                      if (n == null || n < 0) return 'Precio no válido';
                      return null;
                    },
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
                        value: currentRate,
                        isDense: true,
                        isExpanded: true,
                        dropdownColor: context.appSurfaceRaised,
                        items: options
                            .map((r) => DropdownMenuItem(
                                  value: r,
                                  child: Text('$r%',
                                      style:
                                          TextStyle(color: context.appText)),
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
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
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
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total: ${fmt.format(widget.line.total)}',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: context.appText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocTotalsBox extends StatelessWidget {
  final double subtotal;
  final double totalTax;
  final double total;
  final String taxKind;
  final NumberFormat fmt;

  const DocTotalsBox({
    super.key,
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
        color: context.appPrimarySoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appPrimary.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          _row(context, 'Base imponible', fmt.format(subtotal)),
          const SizedBox(height: 6),
          _row(context, taxKind, fmt.format(totalTax)),
          Divider(height: 16, color: context.appBorder),
          _row(context, 'TOTAL', fmt.format(total), bold: true, large: true),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value,
      {bool bold = false, bool large = false}) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
      fontSize: large ? 16 : 14,
      color: bold ? context.appPrimary : context.appTextMuted,
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
