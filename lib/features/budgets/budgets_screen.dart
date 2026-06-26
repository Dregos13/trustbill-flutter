import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/budget.dart';
import '../../core/models/paginated.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../widgets/doc_type_switcher.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/pagination_controls.dart';

class _BudgetsStatusNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void set(String? v) => state = v;
}

final _budgetsStatusProvider =
    NotifierProvider.autoDispose<_BudgetsStatusNotifier, String?>(
  _BudgetsStatusNotifier.new,
);

class _BudgetsOffsetNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void set(int v) => state = v;
}

final _budgetsOffsetProvider =
    NotifierProvider.autoDispose<_BudgetsOffsetNotifier, int>(
  _BudgetsOffsetNotifier.new,
);

final budgetsProvider =
    FutureProvider.autoDispose<PaginatedResponse<BudgetListItem>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final status = ref.watch(_budgetsStatusProvider);
  final offset = ref.watch(_budgetsOffsetProvider);
  return endpoints.getBudgets(limit: 50, offset: offset, status: status);
});

class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetsAsync = ref.watch(budgetsProvider);
    final currentStatus = ref.watch(_budgetsStatusProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(budgetsProvider.future),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const DocTypeSwitcher(active: 'budgets'),
          const SizedBox(height: 16),
          Text(
            'Presupuestos',
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
                  DropdownMenuItem(value: 'draft', child: Text('Borrador')),
                  DropdownMenuItem(value: 'confirmed', child: Text('Confirmado')),
                ],
                onChanged: (value) {
                  ref.read(_budgetsOffsetProvider.notifier).set(0);
                  ref.read(_budgetsStatusProvider.notifier).set(value);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          budgetsAsync.when(
            loading: () => const LoadingIndicator(),
            error: (err, _) => EmptyState(
              message:
                  err is ApiError ? err.message : 'Error al cargar presupuestos',
            ),
            data: (response) {
              if (response.items.isEmpty) {
                return const EmptyState(message: 'No se encontraron presupuestos');
              }
              return Column(
                children: [
                  ...response.items.map((b) => _BudgetCard(budget: b)),
                  PaginationControls(
                    currentPage: response.currentPage,
                    totalPages: response.totalPages,
                    hasPrevious: response.hasPrevious,
                    hasNext: response.hasNext,
                    onPrevious: () {
                      ref.read(_budgetsOffsetProvider.notifier).set(
                          ref.read(_budgetsOffsetProvider) - 50);
                    },
                    onNext: () {
                      ref.read(_budgetsOffsetProvider.notifier).set(
                          ref.read(_budgetsOffsetProvider) + 50);
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

class _BudgetCard extends StatelessWidget {
  final BudgetListItem budget;
  const _BudgetCard({required this.budget});

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.currency(locale: 'es_ES', symbol: '€');
    final converted = budget.saleId != null;
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
        onTap: () => context.push('/budgets/${budget.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${budget.series}-${budget.number}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: context.appText,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _statusChip(context, budget.status, converted),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      budget.client?.name ?? 'Sin cliente',
                      style: TextStyle(fontSize: 13, color: context.appTextMuted),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat('dd/MM/yyyy').format(DateTime.parse(budget.issuedAt)),
                      style: TextStyle(fontSize: 12, color: context.appTextSubtle),
                    ),
                  ],
                ),
              ),
              Text(
                fmt.format(budget.total),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: context.appText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(BuildContext context, String status, bool converted) {
    final (label, color) = converted
        ? ('Venta creada', AppColors.success)
        : status == 'confirmed'
            ? ('Confirmado', AppColors.primary)
            : ('Borrador', AppColors.warning);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color),
      ),
    );
  }
}
