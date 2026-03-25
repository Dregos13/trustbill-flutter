import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/invoice.dart';
import '../../core/models/payment.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/currency.dart';
import '../../core/utils/date.dart';
import '../../widgets/status_badge.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';

final invoiceDetailProvider =
    FutureProvider.autoDispose.family<InvoiceDetail, int>((ref, id) async {
  final endpoints = ref.watch(endpointsProvider);
  return endpoints.getInvoice(id);
});

class InvoiceDetailScreen extends ConsumerStatefulWidget {
  final int id;

  const InvoiceDetailScreen({super.key, required this.id});

  @override
  ConsumerState<InvoiceDetailScreen> createState() =>
      _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends ConsumerState<InvoiceDetailScreen> {
  bool _downloadingPdf = false;

  Future<void> _handlePdf() async {
    setState(() => _downloadingPdf = true);
    try {
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/factura_${widget.id}.pdf';
      final endpoints = ref.read(endpointsProvider);
      await endpoints.downloadPdf(widget.id, filePath);
      await OpenFilex.open(filePath);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e is ApiError ? e.message : 'Error al descargar el PDF',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _downloadingPdf = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(invoiceDetailProvider(widget.id));

    return detailAsync.when(
      loading: () => const LoadingIndicator(),
      error: (err, _) => EmptyState(
        message:
            err is ApiError ? err.message : 'Error al cargar la factura',
      ),
      data: (invoice) => _buildContent(invoice),
    );
  }

  Widget _buildContent(InvoiceDetail invoice) {
    final paidAmount = invoice.payments.fold<double>(
        0, (sum, p) => sum + p.amount);
    final pendingAmount = invoice.total - paidAmount;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header row
        Row(
          children: [
            GestureDetector(
              onTap: () => context.go('/invoices'),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back,
                    size: 18, color: AppColors.gray600),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${invoice.series}-${invoice.number.toString().padLeft(4, '0')}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.gray900,
                ),
              ),
            ),
            StatusBadge(status: invoice.status),
          ],
        ),
        const SizedBox(height: 20),

        // Info card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gray100),
          ),
          child: Column(
            children: [
              _infoRow('Cliente', invoice.client?.name ?? '-'),
              const SizedBox(height: 8),
              _infoRow('Fecha', formatDate(invoice.issuedAt)),
              if (invoice.client?.taxId != null) ...[
                const SizedBox(height: 8),
                _infoRow('NIF', invoice.client!.taxId),
              ],
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Divider(color: AppColors.gray200, height: 1),
              ),
              // Totals row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _totalColumn('TOTAL', invoice.total, AppColors.gray900),
                  if (paidAmount > 0)
                    _totalColumn('COBRADO', paidAmount, AppColors.success),
                  if (pendingAmount > 0)
                    _totalColumn(
                        'PENDIENTE', pendingAmount, AppColors.warning),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Lines section
        const Text(
          'Lineas',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.gray900,
          ),
        ),
        const SizedBox(height: 10),
        ...invoice.lines.map(_buildLine),
        const SizedBox(height: 20),

        // Payments section
        const Text(
          'Pagos',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.gray900,
          ),
        ),
        const SizedBox(height: 10),
        if (invoice.payments.isEmpty)
          const EmptyState(message: 'Sin pagos registrados')
        else
          ...invoice.payments.map(_buildPayment),
        const SizedBox(height: 20),

        // PDF button
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: _downloadingPdf ? null : _handlePdf,
            icon: _downloadingPdf
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.picture_as_pdf, size: 20),
            label: Text(_downloadingPdf ? 'Descargando...' : 'Ver PDF'),
          ),
        ),

        // Notes
        if (invoice.publicNotes != null &&
            invoice.publicNotes!.isNotEmpty) ...[
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gray100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOTAS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray400,
                    letterSpacing: 0.05 * 11,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  invoice.publicNotes!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.gray700,
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.gray500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.gray900,
          ),
        ),
      ],
    );
  }

  Widget _totalColumn(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.gray400,
            letterSpacing: 0.05 * 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          formatCurrency(value),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(InvoiceLine line) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.gray100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            line.description,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.gray900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${line.quantity} x ${formatCurrency(line.unitPrice)}'
            '${line.discountRate > 0 ? ' · Dto. ${line.discountRate}%' : ''}'
            ' · IVA ${line.taxRate}%',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.gray500,
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              formatCurrency(line.total),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.gray900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayment(Payment payment) {
    final methodLabel = _paymentMethodLabel(payment.method);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.gray100),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  methodLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.gray900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formatDate(payment.paidAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.gray500,
                  ),
                ),
                if (payment.reference != null &&
                    payment.reference!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Ref: ${payment.reference}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.gray400,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            formatCurrency(payment.amount),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }

  String _paymentMethodLabel(String method) {
    switch (method) {
      case 'CASH':
        return 'Efectivo';
      case 'BANK':
        return 'Transferencia';
      case 'CREDIT':
        return 'Tarjeta';
      case 'OTHER':
        return 'Otro';
      default:
        return method;
    }
  }
}
