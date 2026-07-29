import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/cache/cache_keys.dart';
import '../../core/cache/cache_providers.dart';
import '../../core/cache/swr.dart';
import '../../core/models/invoice.dart';
import '../../core/models/paginated.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../widgets/invoice_card.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/pagination_controls.dart';
import '../../widgets/doc_type_switcher.dart';

class _InvoicesStatusNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void set(String? v) => state = v;
}

final _invoicesStatusProvider =
    NotifierProvider.autoDispose<_InvoicesStatusNotifier, String?>(
  _InvoicesStatusNotifier.new,
);

class _InvoicesSimplifiedNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void set(bool v) => state = v;
}

/// true = solo tickets simplificados (F2); por defecto se excluyen y se ven
/// solo facturas completas — nunca se mezclan, igual que en escritorio.
final _invoicesSimplifiedProvider =
    NotifierProvider.autoDispose<_InvoicesSimplifiedNotifier, bool>(
  _InvoicesSimplifiedNotifier.new,
);

class _InvoicesOffsetNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void set(int v) => state = v;
}

final _invoicesOffsetProvider =
    NotifierProvider.autoDispose<_InvoicesOffsetNotifier, int>(
  _InvoicesOffsetNotifier.new,
);

/// Lista de facturas con stale-while-revalidate. Solo la vista por defecto
/// (1ª página, sin filtro de estado) se cachea.
final invoicesProvider =
    StreamProvider.autoDispose<PaginatedResponse<InvoiceListItem>>((ref) {
  final endpoints = ref.watch(endpointsProvider);
  final cache = ref.watch(cacheRepositoryProvider);
  final scope = ref.watch(cacheScopeProvider);
  final status = ref.watch(_invoicesStatusProvider);
  final offset = ref.watch(_invoicesOffsetProvider);
  final simplified = ref.watch(_invoicesSimplifiedProvider);

  return swrStream<PaginatedResponse<InvoiceListItem>>(
    cache: cache,
    key: '${CacheKeys.invoices}$scope${simplified ? ':tickets' : ''}',
    cacheable: status == null && offset == 0 && !simplified,
    encode: (r) => encodePaginated(r, (e) => e.toJson()),
    decode: (s) => decodePaginated(s, InvoiceListItem.fromJson),
    fetch: () => endpoints.getInvoices(
      limit: 50,
      offset: offset,
      status: status,
      simplified: simplified,
    ),
  );
});

class InvoicesScreen extends ConsumerWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesAsync = ref.watch(invoicesProvider);
    final currentStatus = ref.watch(_invoicesStatusProvider);
    final simplified = ref.watch(_invoicesSimplifiedProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        await ref.read(cacheRepositoryProvider).deleteByPrefix(CacheKeys.invoices);
        ref.invalidate(invoicesProvider);
        await ref.read(invoicesProvider.future);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const DocTypeSwitcher(active: 'invoices'),
          const SizedBox(height: 16),
          Text(
            simplified ? 'Tickets' : 'Facturas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: context.appText,
            ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<bool>(
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: context.appPrimary,
              selectedForegroundColor: Colors.white,
            ),
            segments: const [
              ButtonSegment(value: false, label: Text('Facturas')),
              ButtonSegment(value: true, label: Text('Tickets')),
            ],
            selected: {simplified},
            onSelectionChanged: (selection) {
              ref.read(_invoicesOffsetProvider.notifier).set(0);
              ref.read(_invoicesSimplifiedProvider.notifier).set(selection.first);
            },
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
                  DropdownMenuItem(
                      value: null, child: Text('Todos los estados')),
                  DropdownMenuItem(
                      value: 'draft', child: Text('Borrador')),
                  DropdownMenuItem(
                      value: 'confirmed', child: Text('Confirmada')),
                  DropdownMenuItem(value: 'final', child: Text('Emitida')),
                  DropdownMenuItem(value: 'paid', child: Text('Pagada')),
                  DropdownMenuItem(
                      value: 'cancelled', child: Text('Anulada')),
                ],
                onChanged: (value) {
                  ref.read(_invoicesOffsetProvider.notifier).set(0);
                  ref.read(_invoicesStatusProvider.notifier).set(value);
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
                        onTap: () => context.push('/invoices/${inv.id}'),
                      )),
                  PaginationControls(
                    currentPage: response.currentPage,
                    totalPages: response.totalPages,
                    hasPrevious: response.hasPrevious,
                    hasNext: response.hasNext,
                    onPrevious: () {
                      ref.read(_invoicesOffsetProvider.notifier).set(
                          ref.read(_invoicesOffsetProvider) - 50);
                    },
                    onNext: () {
                      ref.read(_invoicesOffsetProvider.notifier).set(
                          ref.read(_invoicesOffsetProvider) + 50);
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
