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
import '../../core/utils/error_messages.dart';
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
  bool _actionInFlight = false;
  bool _savingNotes = false;
  bool _savingPayment = false;

  Future<void> _confirmInvoice() async {
    setState(() => _actionInFlight = true);
    try {
      await ref.read(endpointsProvider).confirmInvoice(widget.id);
      ref.invalidate(invoiceDetailProvider(widget.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Factura confirmada')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(friendlyError(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _actionInFlight = false);
    }
  }

  Future<void> _promptFinalize() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Finalizar factura'),
        content: const Text(
          'Se asignará el número legal definitivo y la factura quedará '
          'bloqueada. No se envía a la AEAT.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: context.appPrimary),
            child: const Text('Finalizar'),
          ),
        ],
      ),
    );
    if (confirmed == true) await _finalizeInvoice();
  }

  Future<void> _finalizeInvoice() async {
    setState(() => _actionInFlight = true);
    try {
      await ref.read(endpointsProvider).finalizeInvoice(widget.id);
      ref.invalidate(invoiceDetailProvider(widget.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Factura emitida con número legal')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(friendlyError(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _actionInFlight = false);
    }
  }

  Future<void> _promptCancel() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Anular factura'),
        content: const Text(
          'La factura quedará anulada y se restaurará el inventario consumido. '
          'Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: const Text('Anular'),
          ),
        ],
      ),
    );
    if (confirmed == true) await _cancelInvoice();
  }

  Future<void> _cancelInvoice() async {
    setState(() => _actionInFlight = true);
    try {
      await ref.read(endpointsProvider).cancelInvoice(widget.id);
      ref.invalidate(invoiceDetailProvider(widget.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Factura anulada')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(friendlyError(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _actionInFlight = false);
    }
  }

  Future<void> _promptEditInternalNotes(String? current) async {
    // The dialog owns its TextEditingController (see _InternalNotesDialog) so it
    // is disposed in State.dispose(), after the exit animation. Disposing here
    // right after the await would tear it down while the route still animates.
    // Returns the trimmed text on save, null on cancel/dismiss.
    final text = await showDialog<String>(
      context: context,
      builder: (_) => _InternalNotesDialog(initial: current ?? ''),
    );
    if (text != null) {
      await _saveInternalNotes(text.isEmpty ? null : text);
    }
  }

  Future<void> _saveInternalNotes(String? value) async {
    setState(() => _savingNotes = true);
    try {
      await ref
          .read(endpointsProvider)
          .updateInvoiceInternalNotes(widget.id, internalNotes: value);
      ref.invalidate(invoiceDetailProvider(widget.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notas internas guardadas')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(friendlyError(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _savingNotes = false);
    }
  }

  /// Payments are only valid on a confirmed/final invoice with an outstanding
  /// balance. The server enforces this too (400 otherwise); this just hides the
  /// button when it can't succeed.
  bool _canRegisterPayment(InvoiceDetail invoice, double pending) {
    final s = invoice.status.toLowerCase();
    return (s == 'confirmed' || s == 'final') && pending > 0.01;
  }

  Future<void> _promptRegisterPayment(double pending) async {
    // The sheet owns its controllers (see _PaymentSheet) so they are disposed in
    // State.dispose() — after the sheet's exit animation — instead of
    // synchronously here. The old code disposed them right after the await,
    // which crashed when the closing sheet rebuilt its TextFields against an
    // already-disposed controller (use-after-dispose → cascading framework
    // assertions, the red screen).
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _PaymentSheet(pending: pending),
    );
    if (result != null) await _registerPayment(result);
  }

  Future<void> _registerPayment(Map<String, dynamic> data) async {
    setState(() => _savingPayment = true);
    try {
      await ref.read(endpointsProvider).createPayment(widget.id, data);
      ref.invalidate(invoiceDetailProvider(widget.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pago registrado')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(friendlyError(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _savingPayment = false);
    }
  }

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
        if (_canRegisterPayment(invoice, pendingAmount)) ...[
          const SizedBox(height: 10),
          SizedBox(
            height: 44,
            child: OutlinedButton.icon(
              onPressed: _savingPayment
                  ? null
                  : () => _promptRegisterPayment(pendingAmount),
              icon: _savingPayment
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.add, size: 18),
              label: Text(_savingPayment ? 'Guardando...' : 'Registrar pago'),
            ),
          ),
        ],
        const SizedBox(height: 20),

        // Status-driven lifecycle action (draft -> confirm -> finalize)
        ..._buildStatusActions(invoice),

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

        // Internal (private) notes — editable in any status, never on the PDF
        const SizedBox(height: 12),
        _buildInternalNotesCard(invoice),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInternalNotesCard(InvoiceDetail invoice) {
    final notes = invoice.internalNotes;
    final hasNotes = notes != null && notes.trim().isNotEmpty;
    return Container(
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
          Row(
            children: [
              Icon(Icons.lock_outline, size: 13, color: context.appTextSubtle),
              const SizedBox(width: 6),
              Text(
                'NOTAS INTERNAS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: context.appTextSubtle,
                  letterSpacing: 0.05 * 11,
                ),
              ),
              const Spacer(),
              if (_savingNotes)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                TextButton.icon(
                  onPressed: () => _promptEditInternalNotes(notes),
                  icon: Icon(hasNotes ? Icons.edit_outlined : Icons.add,
                      size: 16),
                  label: Text(hasNotes ? 'Editar' : 'Añadir'),
                  style: TextButton.styleFrom(
                    foregroundColor: context.appPrimary,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            hasNotes ? notes.trim() : 'Sin notas internas',
            style: TextStyle(
              fontSize: 13,
              color: hasNotes ? context.appTextMuted : context.appTextSubtle,
              fontStyle: hasNotes ? FontStyle.normal : FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Solo visible para tu equipo. No aparece en el PDF.',
            style: TextStyle(fontSize: 11, color: context.appTextSubtle),
          ),
        ],
      ),
    );
  }

  /// Lifecycle actions keyed off invoice status.
  /// draft -> [Confirmar] + [Anular]; confirmed -> [Finalizar] + [Anular];
  /// final/canceled -> locked (a final invoice is only annulled on desktop).
  List<Widget> _buildStatusActions(InvoiceDetail invoice) {
    switch (invoice.status.toLowerCase()) {
      case 'draft':
        return [
          _primaryActionButton(
            label: 'Confirmar',
            busyLabel: 'Confirmando...',
            icon: Icons.check_circle_outline,
            onPressed: _confirmInvoice,
          ),
          const SizedBox(height: 12),
          _secondaryActionButton(
            label: 'Editar',
            icon: Icons.edit_outlined,
            onPressed: () => context.push('/invoices/${invoice.id}/edit'),
          ),
          const SizedBox(height: 12),
          _dangerActionButton(
            label: 'Anular',
            icon: Icons.cancel_outlined,
            onPressed: _promptCancel,
          ),
          const SizedBox(height: 12),
        ];
      case 'confirmed':
        return [
          _primaryActionButton(
            label: 'Finalizar / Emitir',
            busyLabel: 'Emitiendo...',
            icon: Icons.lock_outline,
            onPressed: _promptFinalize,
          ),
          const SizedBox(height: 12),
          _dangerActionButton(
            label: 'Anular',
            icon: Icons.cancel_outlined,
            onPressed: _promptCancel,
          ),
          const SizedBox(height: 12),
        ];
      default:
        return const [];
    }
  }

  Widget _secondaryActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: _actionInFlight ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: context.appPrimary,
          side: BorderSide(color: context.appPrimary),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: Icon(icon, size: 20),
        label: Text(label),
      ),
    );
  }

  Widget _dangerActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: _actionInFlight ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.danger,
          side: const BorderSide(color: AppColors.danger),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: Icon(icon, size: 20),
        label: Text(label),
      ),
    );
  }

  Widget _primaryActionButton({
    required String label,
    required String busyLabel,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: _actionInFlight ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.appPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
        ),
        icon: _actionInFlight
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(icon, size: 20),
        label: Text(_actionInFlight ? busyLabel : label),
      ),
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

// ── Internal notes dialog ──────────────────────────────────────────────────────
// Owns its controller so it lives until the dialog's exit animation finishes.
// Pops the trimmed text on save, null on cancel/dismiss.
class _InternalNotesDialog extends StatefulWidget {
  final String initial;
  const _InternalNotesDialog({required this.initial});

  @override
  State<_InternalNotesDialog> createState() => _InternalNotesDialogState();
}

class _InternalNotesDialogState extends State<_InternalNotesDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Notas internas'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        minLines: 3,
        maxLines: 6,
        maxLength: 2000,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          hintText: 'Notas privadas para tu equipo...',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _controller.text.trim()),
          style: FilledButton.styleFrom(backgroundColor: context.appPrimary),
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}

// ── Register-payment bottom sheet ───────────────────────────────────────────────
// Owns its controllers so they outlive the sheet's exit animation. Pops a
// payload map on submit, null on dismiss.
class _PaymentSheet extends StatefulWidget {
  final double pending;
  const _PaymentSheet({required this.pending});

  @override
  State<_PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<_PaymentSheet> {
  static const _methods = <String, String>{
    'CASH': 'Efectivo',
    'BANK': 'Transferencia',
    'CREDIT': 'Tarjeta',
    'OTHER': 'Otro',
  };

  late final TextEditingController _amountCtrl;
  late final TextEditingController _refCtrl;
  String _method = 'CASH';
  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _amountCtrl = TextEditingController(
      text: widget.pending > 0 ? widget.pending.toStringAsFixed(2) : '',
    );
    _refCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _refCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    // Anchor to local noon so converting to UTC for the API can't roll the
    // calendar date back/forward a day.
    if (picked != null) {
      setState(
          () => _date = DateTime(picked.year, picked.month, picked.day, 12));
    }
  }

  void _submit() {
    final amount =
        double.tryParse(_amountCtrl.text.trim().replaceAll(',', '.'));
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Importe no válido')),
      );
      return;
    }
    Navigator.pop(context, {
      'amount': amount,
      // UTC with 'Z' — the API's paidAt is a strict z.datetime().
      'paidAt': _date.toUtc().toIso8601String(),
      'method': _method,
      if (_refCtrl.text.trim().isNotEmpty) 'reference': _refCtrl.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registrar pago',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: context.appText,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountCtrl,
              autofocus: true,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Importe',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _method,
              decoration: const InputDecoration(
                labelText: 'Método',
                border: OutlineInputBorder(),
              ),
              items: _methods.entries
                  .map((e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _method = v ?? 'CASH'),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  border: OutlineInputBorder(),
                ),
                child: Text(formatDate(_date.toIso8601String())),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _refCtrl,
              decoration: const InputDecoration(
                labelText: 'Referencia (opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                style:
                    FilledButton.styleFrom(backgroundColor: context.appPrimary),
                onPressed: _submit,
                child: const Text('Registrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
