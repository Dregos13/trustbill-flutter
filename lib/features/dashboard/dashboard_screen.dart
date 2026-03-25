import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/auth_state.dart';
import '../../core/models/dashboard.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/currency.dart';
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
            const Text(
              'Resumen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatGrid(summary),
            const SizedBox(height: 24),
            const Text(
              'Ultimas facturas',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.gray900,
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
