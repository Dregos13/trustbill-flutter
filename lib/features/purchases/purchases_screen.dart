import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/purchase.dart';
import '../../core/models/paginated.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/pagination_controls.dart';

class _PurchasesStatusNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void set(String? v) => state = v;
}

final _purchasesStatusProvider =
    NotifierProvider.autoDispose<_PurchasesStatusNotifier, String?>(
  _PurchasesStatusNotifier.new,
);

class _PurchasesOffsetNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void set(int v) => state = v;
}

final _purchasesOffsetProvider =
    NotifierProvider.autoDispose<_PurchasesOffsetNotifier, int>(
  _PurchasesOffsetNotifier.new,
);

final purchasesProvider =
    FutureProvider.autoDispose<PaginatedResponse<PurchaseListItem>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final status = ref.watch(_purchasesStatusProvider);
  final offset = ref.watch(_purchasesOffsetProvider);
  return endpoints.getPurchases(limit: 50, offset: offset, status: status);
});

class PurchasesScreen extends ConsumerWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchasesAsync = ref.watch(purchasesProvider);
    final currentStatus = ref.watch(_purchasesStatusProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(purchasesProvider.future),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Compras',
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
                  DropdownMenuItem(
                      value: null, child: Text('Todos los estados')),
                  DropdownMenuItem(
                      value: 'UNPAID', child: Text('Pendiente')),
                  DropdownMenuItem(value: 'PAID', child: Text('Pagada')),
                ],
                onChanged: (value) {
                  ref.read(_purchasesOffsetProvider.notifier).set(0);
                  ref.read(_purchasesStatusProvider.notifier).set(value);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          purchasesAsync.when(
            loading: () => const LoadingIndicator(),
            error: (err, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: AppColors.gray400),
                    const SizedBox(height: 12),
                    Text(
                      err is ApiError
                          ? err.message
                          : 'Error al cargar facturas de compra',
                      style: const TextStyle(
                          color: AppColors.gray500, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => ref.refresh(purchasesProvider.future),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            ),
            data: (response) {
              if (response.items.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.shopping_bag_outlined,
                            size: 48, color: AppColors.gray400),
                        SizedBox(height: 12),
                        Text(
                          'No hay facturas de compra todavía',
                          style: TextStyle(
                              color: AppColors.gray400, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  ...response.items.map((purchase) =>
                      _PurchaseCard(purchase: purchase)),
                  PaginationControls(
                    currentPage: response.currentPage,
                    totalPages: response.totalPages,
                    hasPrevious: response.hasPrevious,
                    hasNext: response.hasNext,
                    onPrevious: () {
                      ref.read(_purchasesOffsetProvider.notifier).set(
                          ref.read(_purchasesOffsetProvider) - 50);
                    },
                    onNext: () {
                      ref.read(_purchasesOffsetProvider.notifier).set(
                          ref.read(_purchasesOffsetProvider) + 50);
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

class _PurchaseCard extends StatelessWidget {
  final PurchaseListItem purchase;

  const _PurchaseCard({required this.purchase});

  String _formatDate(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate);
      final dd = dt.day.toString().padLeft(2, '0');
      final mm = dt.month.toString().padLeft(2, '0');
      final yyyy = dt.year.toString();
      return '$dd/$mm/$yyyy';
    } catch (_) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPaid = purchase.status == 'PAID';
    final statusLabel = isPaid ? 'Pagada' : 'Pendiente';
    final statusColor = isPaid ? context.statusSuccess : context.statusWarning;
    final statusBgColor =
        isPaid ? context.statusSuccessSoft : context.statusWarningSoft;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        purchase.supplierName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: context.appText,
                        ),
                      ),
                      if (purchase.supplierTaxId.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          purchase.supplierTaxId,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.appTextMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${purchase.total.toStringAsFixed(2)} €',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: context.appText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        purchase.invoiceNumber != null &&
                                purchase.invoiceNumber!.isNotEmpty
                            ? purchase.invoiceNumber!
                            : 'Sin número',
                        style: TextStyle(
                          fontSize: 13,
                          color: purchase.invoiceNumber != null &&
                                  purchase.invoiceNumber!.isNotEmpty
                              ? context.appTextMuted
                              : context.appTextSubtle,
                          fontStyle: purchase.invoiceNumber != null &&
                                  purchase.invoiceNumber!.isNotEmpty
                              ? FontStyle.normal
                              : FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatDate(purchase.issueDate),
                        style: TextStyle(
                          fontSize: 12,
                          color: context.appTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
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
