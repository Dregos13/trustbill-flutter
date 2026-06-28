import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/sale.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/error_messages.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import 'sales_screen.dart' show saleStatusLabels;

final saleDetailProvider =
    FutureProvider.autoDispose.family<SaleDetail, int>((ref, id) async {
  final endpoints = ref.watch(endpointsProvider);
  return endpoints.getSale(id);
});

class SaleDetailScreen extends ConsumerStatefulWidget {
  final int id;
  const SaleDetailScreen({super.key, required this.id});

  @override
  ConsumerState<SaleDetailScreen> createState() => _SaleDetailScreenState();
}

class _SaleDetailScreenState extends ConsumerState<SaleDetailScreen> {
  bool _invoicing = false;
  final _fmt = NumberFormat.currency(locale: 'es_ES', symbol: '€');

  Future<void> _invoiceSale(SaleDetail sale) async {
    final pendingLines =
        sale.lines.where((l) => l.pendingQuantity > 0).toList();
    if (pendingLines.isEmpty) {
      _toast('No hay nada pendiente de facturar.', AppColors.warning);
      return;
    }

    final pendingTotal =
        pendingLines.fold<double>(0, (s, l) => s + l.pendingTotal);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Facturar venta'),
        content: Text(
          'Se creará una factura BORRADOR por el pendiente de esta venta '
          '(${_fmt.format(pendingTotal)}). Podrás finalizarla desde el escritorio.',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Facturar')),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _invoicing = true);
    final payload = {
      'lines': pendingLines
          .map((l) => {
                'saleLineId': l.id,
                'description': l.description,
                'quantity': l.pendingQuantity.toInt(),
                'unitPrice': l.unitPrice,
                'taxRate': l.taxRate,
                'discountRate': l.discountRate,
                if (l.productId != null) 'productId': l.productId,
                if (l.serviceId != null) 'serviceId': l.serviceId,
              })
          .toList(),
      if (sale.taxKind != null) 'taxKind': sale.taxKind,
    };

    try {
      final endpoints = ref.read(endpointsProvider);
      final res = await endpoints.createInvoiceFromSale(sale.id, payload);
      if (!mounted) return;
      setState(() => _invoicing = false);
      ref.invalidate(saleDetailProvider(sale.id));
      final invoiceId = (res['invoice'] as Map<String, dynamic>?)?['id'] as int?;
      _toast('Factura borrador creada.', AppColors.success);
      if (invoiceId != null) context.go('/invoices/$invoiceId');
    } catch (e) {
      if (!mounted) return;
      setState(() => _invoicing = false);
      _toast(
          friendlyError(e, fallback: 'No se pudo facturar la venta.'),
          AppColors.danger);
    }
  }

  void _toast(String msg, Color color) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    final saleAsync = ref.watch(saleDetailProvider(widget.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Venta'),
        backgroundColor: context.appPrimary,
        foregroundColor: Colors.white,
      ),
      body: saleAsync.when(
        loading: () => const LoadingIndicator(),
        error: (err, _) => EmptyState(
          message: err is ApiError ? err.message : 'Error al cargar la venta',
        ),
        data: (sale) {
          final canInvoice =
              sale.status != 'CLOSED' && sale.status != 'LOST' &&
                  sale.totalPending > 0.01;
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    children: [
                      Text(sale.code,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: context.appText)),
                      const SizedBox(width: 10),
                      _statusChip(context, sale.status),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(sale.client?.name ?? 'Sin cliente',
                      style:
                          TextStyle(fontSize: 15, color: context.appTextMuted)),
                  if (sale.vendor?.name != null)
                    Text('Vendedor: ${sale.vendor!.name}',
                        style: TextStyle(
                            fontSize: 13, color: context.appTextSubtle)),
                  const SizedBox(height: 16),

                  _totalsCard(context, sale),

                  if (sale.budget != null) ...[
                    const SizedBox(height: 12),
                    _card(
                      context,
                      child: InkWell(
                        onTap: () => context.push('/budgets/${sale.budget!.id}'),
                        child: Row(
                          children: [
                            Icon(Icons.request_quote_outlined,
                                size: 18, color: context.appTextMuted),
                            const SizedBox(width: 8),
                            Text(
                                'Presupuesto ${sale.budget!.series}-${sale.budget!.number}',
                                style: TextStyle(color: context.appText)),
                            const Spacer(),
                            Icon(Icons.chevron_right,
                                color: context.appTextSubtle),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  _sectionTitle(context, 'Líneas'),
                  const SizedBox(height: 8),
                  _card(
                    context,
                    child: Column(
                      children: [
                        for (final line in sale.lines)
                          _lineRow(context, line),
                      ],
                    ),
                  ),

                  if (sale.installments.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _sectionTitle(context, 'Plan de pagos'),
                    const SizedBox(height: 8),
                    _card(
                      context,
                      child: Column(
                        children: [
                          for (final inst in sale.installments)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Cuota ${inst.index}'
                                      '${inst.percentage != null ? ' · ${inst.percentage!.toInt()}%' : ''}',
                                      style:
                                          TextStyle(color: context.appTextMuted)),
                                  Text(
                                      _fmt.format(inst.plannedAmount ?? 0),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: context.appText)),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],

                  if (sale.invoices.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _sectionTitle(context, 'Facturas'),
                    const SizedBox(height: 8),
                    ...sale.invoices.map((inv) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          color: context.appSurfaceRaised,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: context.appBorder),
                          ),
                          child: ListTile(
                            onTap: () => context.push('/invoices/${inv.id}'),
                            title: Text('${inv.series}-${inv.number}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: context.appText)),
                            subtitle: Text(
                                inv.isFinal ? 'Final' : 'Borrador',
                                style: TextStyle(color: context.appTextSubtle)),
                            trailing: Text(_fmt.format(inv.total),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: context.appText)),
                          ),
                        )),
                  ],

                  const SizedBox(height: 24),
                  if (canInvoice)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed:
                            _invoicing ? null : () => _invoiceSale(sale),
                        icon: const Icon(Icons.receipt_long),
                        label: Text(
                            'Facturar pendiente (${_fmt.format(sale.totalPending)})'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.appPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
                ],
              ),
              if (_invoicing)
                Container(
                  color: Colors.black38,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _totalsCard(BuildContext context, SaleDetail sale) => _card(
        context,
        child: Column(
          children: [
            _totalRow(context, 'Previsto', sale.totalPlanned),
            const SizedBox(height: 6),
            _totalRow(context, 'Facturado', sale.totalInvoiced),
            Divider(color: context.appBorder, height: 20),
            _totalRow(context, 'Pendiente', sale.totalPending,
                highlight: true),
          ],
        ),
      );

  Widget _totalRow(BuildContext context, String label, double value,
          {bool highlight = false}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: highlight ? context.appText : context.appTextMuted,
                  fontWeight: highlight ? FontWeight.w700 : FontWeight.w400)),
          Text(_fmt.format(value),
              style: TextStyle(
                  fontSize: highlight ? 16 : 14,
                  fontWeight: highlight ? FontWeight.w800 : FontWeight.w600,
                  color: highlight ? context.appPrimary : context.appText)),
        ],
      );

  Widget _lineRow(BuildContext context, SaleDetailLine line) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(line.description,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: context.appText)),
                  Text(
                    '${line.quantity.toInt()} × ${_fmt.format(line.unitPrice)} · ${line.taxRate.toInt()}%',
                    style:
                        TextStyle(fontSize: 12, color: context.appTextSubtle),
                  ),
                  if (line.pendingQuantity > 0)
                    Text('Pendiente: ${line.pendingQuantity.toInt()} ud.',
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.warning)),
                ],
              ),
            ),
            Text(_fmt.format(line.total),
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: context.appText)),
          ],
        ),
      );

  Widget _sectionTitle(BuildContext context, String title) => Text(
        title.toUpperCase(),
        style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: context.appTextMuted,
            letterSpacing: 0.8),
      );

  Widget _card(BuildContext context, {required Widget child}) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.appSurfaceRaised,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.appBorder),
        ),
        child: child,
      );

  Widget _statusChip(BuildContext context, String status) {
    final color = switch (status) {
      'CLOSED' => AppColors.success,
      'PARTIALLY_INVOICED' => AppColors.primary,
      'LOST' => AppColors.danger,
      _ => AppColors.warning,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(saleStatusLabels[status] ?? status,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: color)),
    );
  }
}
