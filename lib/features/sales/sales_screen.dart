import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/sale.dart';
import '../../core/models/paginated.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../widgets/doc_type_switcher.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/pagination_controls.dart';

const saleStatusLabels = <String, String>{
  'OPEN': 'Abierta',
  'PARTIALLY_INVOICED': 'Parcial',
  'CLOSED': 'Cerrada',
  'LOST': 'Perdida',
};

class _SalesStatusNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void set(String? v) => state = v;
}

final _salesStatusProvider =
    NotifierProvider.autoDispose<_SalesStatusNotifier, String?>(
  _SalesStatusNotifier.new,
);

class _SalesOffsetNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void set(int v) => state = v;
}

final _salesOffsetProvider =
    NotifierProvider.autoDispose<_SalesOffsetNotifier, int>(
  _SalesOffsetNotifier.new,
);

final salesProvider =
    FutureProvider.autoDispose<PaginatedResponse<SaleListItem>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final status = ref.watch(_salesStatusProvider);
  final offset = ref.watch(_salesOffsetProvider);
  return endpoints.getSales(limit: 50, offset: offset, status: status);
});

class SalesScreen extends ConsumerWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesAsync = ref.watch(salesProvider);
    final currentStatus = ref.watch(_salesStatusProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(salesProvider.future),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const DocTypeSwitcher(active: 'sales'),
          const SizedBox(height: 16),
          Text(
            'Ventas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: context.appText,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: context.appSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.appBorder),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String?>(
                value: currentStatus,
                isExpanded: true,
                dropdownColor: context.appSurface,
                style: TextStyle(color: context.appText, fontSize: 14),
                icon: Icon(Icons.keyboard_arrow_down, color: context.appTextSubtle),
                items: const [
                  DropdownMenuItem(value: null, child: Text('Todos los estados')),
                  DropdownMenuItem(value: 'OPEN', child: Text('Abierta')),
                  DropdownMenuItem(
                      value: 'PARTIALLY_INVOICED', child: Text('Parcial')),
                  DropdownMenuItem(value: 'CLOSED', child: Text('Cerrada')),
                  DropdownMenuItem(value: 'LOST', child: Text('Perdida')),
                ],
                onChanged: (value) {
                  ref.read(_salesOffsetProvider.notifier).set(0);
                  ref.read(_salesStatusProvider.notifier).set(value);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          salesAsync.when(
            loading: () => const LoadingIndicator(),
            error: (err, _) => EmptyState(
              message: err is ApiError ? err.message : 'Error al cargar ventas',
            ),
            data: (response) {
              if (response.items.isEmpty) {
                return const EmptyState(message: 'No se encontraron ventas');
              }
              return Column(
                children: [
                  ...response.items.map((s) => _SaleCard(sale: s)),
                  PaginationControls(
                    currentPage: response.currentPage,
                    totalPages: response.totalPages,
                    hasPrevious: response.hasPrevious,
                    hasNext: response.hasNext,
                    onPrevious: () {
                      ref.read(_salesOffsetProvider.notifier).set(
                          ref.read(_salesOffsetProvider) - 50);
                    },
                    onNext: () {
                      ref.read(_salesOffsetProvider.notifier).set(
                          ref.read(_salesOffsetProvider) + 50);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SaleCard extends StatelessWidget {
  final SaleListItem sale;
  const _SaleCard({required this.sale});

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.currency(locale: 'es_ES', symbol: '€');
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: context.appSurfaceRaised,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: context.appBorder),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => context.push('/sales/${sale.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    sale.code,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: context.appText),
                  ),
                  const SizedBox(width: 8),
                  _statusChip(context, sale.status),
                  const Spacer(),
                  Text(
                    fmt.format(sale.totalPlanned),
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: context.appText),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                sale.client?.name ?? 'Sin cliente',
                style: TextStyle(fontSize: 13, color: context.appTextMuted),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _miniStat(context, 'Facturado', fmt.format(sale.totalInvoiced)),
                  const SizedBox(width: 16),
                  _miniStat(context, 'Pendiente', fmt.format(sale.totalPending),
                      highlight: sale.totalPending > 0.01),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniStat(BuildContext context, String label, String value,
      {bool highlight = false}) {
    return Row(
      children: [
        Text('$label: ',
            style: TextStyle(fontSize: 12, color: context.appTextSubtle)),
        Text(value,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: highlight ? AppColors.warning : context.appTextMuted)),
      ],
    );
  }

  Widget _statusChip(BuildContext context, String status) {
    final color = switch (status) {
      'CLOSED' => AppColors.success,
      'PARTIALLY_INVOICED' => AppColors.primary,
      'LOST' => AppColors.danger,
      _ => AppColors.warning,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        saleStatusLabels[status] ?? status,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color),
      ),
    );
  }
}
