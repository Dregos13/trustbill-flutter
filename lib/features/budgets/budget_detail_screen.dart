import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/budget.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/error_messages.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/status_badge.dart';

final budgetDetailProvider =
    FutureProvider.autoDispose.family<BudgetDetail, int>((ref, id) async {
  final endpoints = ref.watch(endpointsProvider);
  return endpoints.getBudget(id);
});

class BudgetDetailScreen extends ConsumerStatefulWidget {
  final int id;
  const BudgetDetailScreen({super.key, required this.id});

  @override
  ConsumerState<BudgetDetailScreen> createState() => _BudgetDetailScreenState();
}

class _BudgetDetailScreenState extends ConsumerState<BudgetDetailScreen> {
  /// Which action is currently running ('accept' | 'reject'), or null when idle.
  String? _busyAction;
  bool get _actionInFlight => _busyAction != null;

  Future<void> _accept() async {
    setState(() => _busyAction = 'accept');
    try {
      await ref.read(endpointsProvider).acceptBudget(widget.id);
      ref.invalidate(budgetDetailProvider(widget.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Presupuesto aceptado')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(friendlyError(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _busyAction = null);
    }
  }

  Future<void> _promptReject() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rechazar presupuesto'),
        content: const Text(
          'El presupuesto se marcará como rechazado y se liberarán las '
          'reservas de stock. Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: const Text('Rechazar'),
          ),
        ],
      ),
    );
    if (confirmed == true) await _reject();
  }

  Future<void> _reject() async {
    setState(() => _busyAction = 'reject');
    try {
      await ref.read(endpointsProvider).rejectBudget(widget.id);
      ref.invalidate(budgetDetailProvider(widget.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Presupuesto rechazado')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(friendlyError(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _busyAction = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final budgetAsync = ref.watch(budgetDetailProvider(widget.id));
    final fmt = NumberFormat.currency(locale: 'es_ES', symbol: '€');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Presupuesto'),
        backgroundColor: context.appPrimary,
        foregroundColor: Colors.white,
      ),
      body: budgetAsync.when(
        loading: () => const LoadingIndicator(),
        error: (err, _) => EmptyState(
          message:
              err is ApiError ? err.message : 'Error al cargar el presupuesto',
        ),
        data: (b) {
          final qs = b.quoteStatus;
          final isPending = qs == 'pending';
          final isRejected = qs == 'rejected';
          final canConvert =
              b.saleId == null && b.client != null && !isRejected;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${b.series}-${b.number}',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: context.appText)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (qs != null)
                          StatusBadge(status: qs)
                        else
                          _chip(
                              context,
                              b.status == 'confirmed'
                                  ? 'Confirmado'
                                  : 'Borrador',
                              b.status == 'confirmed'
                                  ? AppColors.primary
                                  : AppColors.warning),
                        if (b.saleId != null)
                          _chip(context, 'Venta creada', AppColors.success),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(b.client?.name ?? 'Sin cliente',
                  style: TextStyle(fontSize: 15, color: context.appTextMuted)),
              Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.parse(b.issuedAt)),
                  style: TextStyle(fontSize: 13, color: context.appTextSubtle)),
              const SizedBox(height: 20),

              _card(
                context,
                child: Column(
                  children: [
                    for (final line in b.lines) _lineRow(context, line, fmt),
                    Divider(color: context.appBorder, height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: context.appText)),
                        Text(fmt.format(b.total),
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: context.appPrimary)),
                      ],
                    ),
                  ],
                ),
              ),

              if (b.publicNotes != null && b.publicNotes!.isNotEmpty) ...[
                const SizedBox(height: 16),
                _card(
                  context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Observaciones',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: context.appTextMuted)),
                      const SizedBox(height: 6),
                      Text(b.publicNotes!,
                          style: TextStyle(color: context.appText)),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // pending -> [Aceptar] [Rechazar]
              if (isPending) ...[
                Row(
                  children: [
                    Expanded(
                      child: _filledActionButton(
                        label: 'Aceptar',
                        busyLabel: 'Aceptando...',
                        icon: Icons.check,
                        color: AppColors.success,
                        action: 'accept',
                        onPressed: _accept,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _outlinedActionButton(
                        label: 'Rechazar',
                        icon: Icons.close,
                        color: AppColors.danger,
                        onPressed: _promptReject,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],

              // convert (pending/accepted, not yet sold) -> [Convertir en venta]
              if (canConvert)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _actionInFlight
                        ? null
                        : () => context.push('/sales/new', extra: {
                              'budgetId': b.id,
                              'clientId': b.client!.id,
                              'taxKind': b.taxKind,
                            }),
                    icon: const Icon(Icons.point_of_sale),
                    label: const Text('Convertir en venta'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.appPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                )
              else if (b.saleId != null)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/sales/${b.saleId}'),
                    icon: const Icon(Icons.visibility_outlined),
                    label: const Text('Ver venta asociada'),
                  ),
                ),

              // rejected -> locked notice (icon + label, never color alone)
              if (isRejected) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: context.statusDangerSoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.block, size: 18, color: context.statusDanger),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Presupuesto rechazado. Las reservas de stock se han liberado.',
                          style: TextStyle(
                              color: context.statusDanger,
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Widget _filledActionButton({
    required String label,
    required String busyLabel,
    required IconData icon,
    required Color color,
    required String action,
    required VoidCallback onPressed,
  }) {
    final busy = _busyAction == action;
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: _actionInFlight ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: busy
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Icon(icon, size: 20),
        label: Text(busy ? busyLabel : label),
      ),
    );
  }

  Widget _outlinedActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: _actionInFlight ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withValues(alpha: 0.5)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: Icon(icon, size: 20),
        label: Text(label),
      ),
    );
  }

  Widget _lineRow(BuildContext context, BudgetLine line, NumberFormat fmt) =>
      Padding(
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
                    '${line.quantity.toInt()} × ${fmt.format(line.unitPrice)}'
                    '${line.discountRate > 0 ? '  ·  -${line.discountRate.toInt()}%' : ''}'
                    '  ·  ${line.taxRate.toInt()}%',
                    style:
                        TextStyle(fontSize: 12, color: context.appTextSubtle),
                  ),
                ],
              ),
            ),
            Text(fmt.format(line.total),
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: context.appText)),
          ],
        ),
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

  Widget _chip(BuildContext context, String label, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w700, color: color)),
      );
}
