import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/paginated.dart';
import '../../core/models/supplier.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/pagination_controls.dart';

class _SuppliersSearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void set(String value) => state = value;
}

final _suppliersSearchProvider =
    NotifierProvider.autoDispose<_SuppliersSearchNotifier, String>(
      _SuppliersSearchNotifier.new,
    );

class _SuppliersOffsetNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void set(int value) => state = value;
}

final _suppliersOffsetProvider =
    NotifierProvider.autoDispose<_SuppliersOffsetNotifier, int>(
      _SuppliersOffsetNotifier.new,
    );

final suppliersProvider =
    FutureProvider.autoDispose<PaginatedResponse<Supplier>>((ref) async {
      final endpoints = ref.watch(endpointsProvider);
      final search = ref.watch(_suppliersSearchProvider);
      final offset = ref.watch(_suppliersOffsetProvider);
      return endpoints.getSuppliers(limit: 50, offset: offset, search: search);
    });

class SuppliersScreen extends ConsumerStatefulWidget {
  const SuppliersScreen({super.key});

  @override
  ConsumerState<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends ConsumerState<SuppliersScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    ref.read(_suppliersOffsetProvider.notifier).set(0);
    ref.read(_suppliersSearchProvider.notifier).set(value);
  }

  @override
  Widget build(BuildContext context) {
    final suppliersAsync = ref.watch(suppliersProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(suppliersProvider.future),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Proveedores',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: context.appText,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar proveedores...',
              prefixIcon: Icon(
                Icons.search,
                size: 20,
                color: context.appTextSubtle,
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 42,
                minHeight: 0,
              ),
            ),
            onChanged: _onSearch,
          ),
          const SizedBox(height: 16),
          suppliersAsync.when(
            loading: () => const LoadingIndicator(),
            error: (err, _) => EmptyState(
              message: err is ApiError
                  ? err.message
                  : 'Error al cargar proveedores',
            ),
            data: (response) {
              if (response.items.isEmpty) {
                return const EmptyState(
                  message: 'No se encontraron proveedores',
                );
              }
              return Column(
                children: [
                  ...response.items.map(
                    (supplier) => _SupplierCard(supplier: supplier),
                  ),
                  PaginationControls(
                    currentPage: response.currentPage,
                    totalPages: response.totalPages,
                    hasPrevious: response.hasPrevious,
                    hasNext: response.hasNext,
                    onPrevious: () {
                      ref
                          .read(_suppliersOffsetProvider.notifier)
                          .set(ref.read(_suppliersOffsetProvider) - 50);
                    },
                    onNext: () {
                      ref
                          .read(_suppliersOffsetProvider.notifier)
                          .set(ref.read(_suppliersOffsetProvider) + 50);
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

class _SupplierCard extends StatelessWidget {
  const _SupplierCard({required this.supplier});

  final Supplier supplier;

  void _openEditor(BuildContext context) {
    context.push('/suppliers/${supplier.id}/edit');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openEditor(context),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.appBorder),
          boxShadow: [
            BoxShadow(
              color: context.appShadow,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: context.appPrimarySoft,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.storefront_outlined,
                color: context.appPrimary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    supplier.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: context.appText,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    supplier.taxId.isNotEmpty ? supplier.taxId : 'Sin CIF/NIF',
                    style: TextStyle(
                      fontSize: 12,
                      color: supplier.taxId.isNotEmpty
                          ? context.appTextMuted
                          : context.appTextSubtle,
                      fontStyle: supplier.taxId.isNotEmpty
                          ? FontStyle.normal
                          : FontStyle.italic,
                    ),
                  ),
                  if (supplier.email.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      supplier.email,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.appTextMuted,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: context.appSurfaceRaised,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: context.appBorder),
                  ),
                  child: Text(
                    '${supplier.purchasesCount} compras',
                    style: TextStyle(
                      color: context.appTextMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                IconButton.filledTonal(
                  onPressed: () => _openEditor(context),
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  tooltip: 'Editar proveedor',
                  style: IconButton.styleFrom(
                    backgroundColor: context.appPrimarySoft,
                    foregroundColor: context.appPrimary,
                    minimumSize: const Size(36, 36),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
