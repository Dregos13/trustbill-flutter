import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/budget.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';

final budgetDetailProvider =
    FutureProvider.autoDispose.family<BudgetDetail, int>((ref, id) async {
  final endpoints = ref.watch(endpointsProvider);
  return endpoints.getBudget(id);
});

class BudgetDetailScreen extends ConsumerWidget {
  final int id;
  const BudgetDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetAsync = ref.watch(budgetDetailProvider(id));
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
          final canConvert = b.saleId == null && b.client != null;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Text('${b.series}-${b.number}',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: context.appText)),
                  const SizedBox(width: 10),
                  if (b.saleId != null)
                    _chip(context, 'Venta creada', AppColors.success)
                  else
                    _chip(
                        context,
                        b.status == 'confirmed' ? 'Confirmado' : 'Borrador',
                        b.status == 'confirmed'
                            ? AppColors.primary
                            : AppColors.warning),
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
              if (canConvert)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => context.push('/sales/new', extra: {
                      'budgetId': b.id,
                      'clientId': b.client!.id,
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
              const SizedBox(height: 32),
            ],
          );
        },
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
