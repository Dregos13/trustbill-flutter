import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/invoice.dart';
import '../../core/models/paginated.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/invoice_card.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/pagination_controls.dart';

final _invoicesStatusProvider =
    StateProvider.autoDispose<String?>((ref) => null);
final _invoicesOffsetProvider = StateProvider.autoDispose<int>((ref) => 0);

final invoicesProvider =
    FutureProvider.autoDispose<PaginatedResponse<InvoiceListItem>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final status = ref.watch(_invoicesStatusProvider);
  final offset = ref.watch(_invoicesOffsetProvider);
  return endpoints.getInvoices(limit: 50, offset: offset, status: status);
});

class InvoicesScreen extends ConsumerWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesAsync = ref.watch(invoicesProvider);
    final currentStatus = ref.watch(_invoicesStatusProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(invoicesProvider.future),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Facturas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.gray900,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.gray300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String?>(
                value: currentStatus,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: AppColors.gray400),
                items: const [
                  DropdownMenuItem(
                      value: null, child: Text('Todos los estados')),
                  DropdownMenuItem(
                      value: 'draft', child: Text('Borrador')),
                  DropdownMenuItem(
                      value: 'confirmed', child: Text('Confirmada')),
                  DropdownMenuItem(value: 'paid', child: Text('Pagada')),
                  DropdownMenuItem(
                      value: 'cancelled', child: Text('Anulada')),
                ],
                onChanged: (value) {
                  ref.read(_invoicesOffsetProvider.notifier).state = 0;
                  ref.read(_invoicesStatusProvider.notifier).state = value;
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          invoicesAsync.when(
            loading: () => const LoadingIndicator(),
            error: (err, _) => EmptyState(
              message: err is ApiError
                  ? err.message
                  : 'Error al cargar facturas',
            ),
            data: (response) {
              if (response.items.isEmpty) {
                return const EmptyState(
                    message: 'No se encontraron facturas');
              }
              return Column(
                children: [
                  ...response.items.map((inv) => InvoiceCard(
                        series: inv.series,
                        number: inv.number,
                        status: inv.status,
                        clientName: inv.client?.name,
                        total: inv.total,
                        issuedAt: inv.issuedAt,
                        onTap: () => context.go('/invoices/${inv.id}'),
                      )),
                  PaginationControls(
                    currentPage: response.currentPage,
                    totalPages: response.totalPages,
                    hasPrevious: response.hasPrevious,
                    hasNext: response.hasNext,
                    onPrevious: () {
                      ref.read(_invoicesOffsetProvider.notifier).state =
                          ref.read(_invoicesOffsetProvider) - 50;
                    },
                    onNext: () {
                      ref.read(_invoicesOffsetProvider.notifier).state =
                          ref.read(_invoicesOffsetProvider) + 50;
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
