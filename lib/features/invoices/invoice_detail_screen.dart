import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/invoice.dart';
import '../../core/models/payment.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
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
        message: err is ApiError ? err.message : 'Error al cargar la factura',
      ),
      data: (invoice) => _buildContent(invoice),
    );
  }

  Widget _buildContent(InvoiceDetail invoice) {
    final paidAmount =
        invoice.payments.fold<double>(0, (sum, p) => sum + p.amount);
    final pendingAmount = invoice.total - paidAmount;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header row
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/invoices');
                }
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: context.appSurfaceRaised,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back,
                    size: 18, color: context.appTextMuted),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${invoice.series}-${invoice.number.toString().padLeft(4, '0')}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: context.appText,
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
            color: context.appSurfaceRaised,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.appBorder),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Divider(color: context.appBorder, height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _totalColumn('TOTAL', invoice.total, context.appText),
                  if (paidAmount > 0)
                    _totalColumn('COBRADO', paidAmount, AppColors.success),
                  if (pendingAmount > 0)
                    _totalColumn('PENDIENTE', pendingAmount, AppColors.warning),
                ],
              ),
            ],
          ),
        ),

        // Client contact card
        if (invoice.client != null &&
            (invoice.client!.phone != null ||
                invoice.client!.email != null ||
                invoice.client!.address != null)) ...[
          const SizedBox(height: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: context.appSurfaceRaised,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.appBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONTACTO',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: context.appTextSubtle,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 4),
                if (invoice.client!.phone != null)
                  _contactRow(
                    icon: Icons.chat,
                    label: 'Teléfono',
                    value: invoice.client!.phone!,
                    uri: _whatsappUri(invoice.client!.phone),
                  ),
                if (invoice.client!.email != null)
                  _contactRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: invoice.client!.email!,
                    uri: _mailtoUri(invoice.client!.email),
                  ),
                if (invoice.client!.address != null)
                  _contactRow(
                    icon: Icons.location_on_outlined,
                    label: 'Dirección',
                    value: invoice.client!.address!,
                    uri: _mapsUri(invoice.client!.address),
                  ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 20),

        // Lines section
        Text(
          'Lineas',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: context.appText,
          ),
        ),
        const SizedBox(height: 10),
        ...invoice.lines.map(_buildLine),
        const SizedBox(height: 20),

        // Payments section
        Text(
          'Pagos',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: context.appText,
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
              color: context.appSurfaceRaised,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.appBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOTAS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: context.appTextSubtle,
                    letterSpacing: 0.05 * 11,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  invoice.publicNotes!,
                  style: TextStyle(
                    fontSize: 13,
                    color: context.appTextMuted,
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

  Uri? _whatsappUri(String? phone) {
    if (phone == null || phone.trim().isEmpty) return null;
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;
    final cc = digits.length == 9 ? '34$digits' : digits;
    return Uri.parse('https://wa.me/$cc');
  }

  Uri? _mapsUri(String? address) {
    if (address == null || address.trim().isEmpty) return null;
    return Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address.trim())}');
  }

  Uri? _mailtoUri(String? email) {
    if (email == null || email.trim().isEmpty) return null;
    return Uri.parse('mailto:${email.trim()}');
  }

  Future<void> _openUri(Uri? uri) async {
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el enlace')),
        );
      }
    }
  }

  Widget _contactRow({
    required IconData icon,
    required String label,
    required String value,
    required Uri? uri,
  }) {
    final hasLink = uri != null;
    return InkWell(
      onTap: hasLink ? () => _openUri(uri) : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Icon(icon,
                size: 16,
                color: hasLink ? context.appPrimary : context.appTextSubtle),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          fontSize: 11, color: context.appTextSubtle)),
                  const SizedBox(height: 1),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color:
                          hasLink ? context.appPrimary : context.appTextMuted,
                      decoration: hasLink
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor: context.appPrimary,
                    ),
                  ),
                ],
              ),
            ),
            if (hasLink)
              Icon(Icons.open_in_new, size: 14, color: context.appTextSubtle),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: context.appTextMuted),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: context.appText,
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
            color: context.appTextSubtle,
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
        color: context.appSurfaceRaised,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.appBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            line.description,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: context.appText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${line.quantity} x ${formatCurrency(line.unitPrice)}'
            '${line.discountRate > 0 ? ' · Dto. ${line.discountRate}%' : ''}'
            ' · IVA ${line.taxRate}%',
            style: TextStyle(fontSize: 12, color: context.appTextMuted),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              formatCurrency(line.total),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: context.appText,
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
        color: context.appSurfaceRaised,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.appBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  methodLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: context.appText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formatDate(payment.paidAt),
                  style: TextStyle(fontSize: 12, color: context.appTextMuted),
                ),
                if (payment.reference != null &&
                    payment.reference!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Ref: ${payment.reference}',
                    style:
                        TextStyle(fontSize: 11, color: context.appTextSubtle),
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
