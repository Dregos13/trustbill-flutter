import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/auth_state.dart';
import '../../core/models/dashboard.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/currency.dart';
import '../tax/tax_returns_screen.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/invoice_card.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';

final dashboardProvider =
    FutureProvider.autoDispose<DashboardSummary>((ref) async {
  // Wait until authenticated before calling API
  final auth = ref.watch(authProvider);
  if (auth is! AuthAuthenticated) throw StateError('Not authenticated');
  final endpoints = ref.read(endpointsProvider);
  return endpoints.getDashboardSummary();
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(dashboardProvider.future),
      child: dashboardAsync.when(
        loading: () => const LoadingIndicator(),
        error: (err, _) => ListView(
          children: [
            EmptyState(
              message: err is ApiError
                  ? err.message
                  : 'Error al cargar el resumen',
            ),
          ],
        ),
        data: (summary) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Resumen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: context.appText,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatGrid(summary),
            const SizedBox(height: 16),
            _buildTaxSnapshot(context, ref),
            const SizedBox(height: 24),
            Text(
              'Ultimas facturas',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: context.appText,
              ),
            ),
            const SizedBox(height: 12),
            if (summary.recentInvoices.isEmpty)
              const EmptyState(message: 'No hay facturas recientes')
            else
              ...summary.recentInvoices.map((inv) => InvoiceCard(
                    series: inv.series,
                    number: inv.number,
                    status: inv.status,
                    clientName: inv.clientName,
                    total: inv.total,
                    issuedAt: inv.issuedAt,
                    onTap: () => context.push('/invoices/${inv.id}'),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildTaxSnapshot(BuildContext context, WidgetRef ref) {
    final taxAsync = ref.watch(taxReturnsProvider);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => context.push('/tax'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.isDark ? context.appSurfaceRaised : AppColors.gray900,
          borderRadius: BorderRadius.circular(14),
        ),
        child: taxAsync.when(
          loading: () => const Text(
            'Cargando situación fiscal...',
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700),
          ),
          error: (error, stackTrace) => const Text(
            'Ver historial fiscal',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          data: (tax) => Row(
            children: [
              const Icon(Icons.account_balance_outlined, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Historial fiscal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${tax.summary.presented} presentados · ${tax.summary.draft} borradores',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (tax.summary.nextDue != null)
                Text(
                  tax.summary.nextDue!.label,
                  style: const TextStyle(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatGrid(DashboardSummary summary) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.6,
      children: [
        StatCard(
          label: 'Facturas mes',
          value: summary.invoicesThisMonth.toString(),
        ),
        StatCard(
          label: 'Facturado',
          value: '${formatAmount(summary.totalBilled)} \u20AC',
        ),
        StatCard(
          label: 'Cobrado',
          value: '${formatAmount(summary.totalCollected)} \u20AC',
          valueColor: AppColors.success,
        ),
        StatCard(
          label: 'Pendiente',
          value: '${formatAmount(summary.totalPending)} \u20AC',
          valueColor: AppColors.warning,
        ),
      ],
    );
  }
}
