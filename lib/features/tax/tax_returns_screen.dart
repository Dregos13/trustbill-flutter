import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/auth_state.dart';
import '../../core/models/tax_return.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/currency.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/status_badge.dart';

final taxReturnsProvider =
    FutureProvider.autoDispose<TaxReturnListResponse>((ref) async {
  final auth = ref.watch(authProvider);
  if (auth is! AuthAuthenticated) throw StateError('Not authenticated');
  return ref.read(endpointsProvider).getTaxReturns();
});

class TaxReturnsScreen extends ConsumerWidget {
  const TaxReturnsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(taxReturnsProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(taxReturnsProvider.future),
      child: async.when(
        loading: () => const LoadingIndicator(),
        error: (err, _) => ListView(
          children: [
            EmptyState(
              message: err is ApiError
                  ? err.message
                  : 'Error al cargar el historial fiscal',
            ),
          ],
        ),
        data: (data) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const _Header(),
            const SizedBox(height: 16),
            _SummaryGrid(summary: data.summary),
            const SizedBox(height: 22),
            Text(
              'Historial de modelos',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: context.appText,
              ),
            ),
            const SizedBox(height: 12),
            if (data.items.isEmpty)
              const EmptyState(message: 'No hay modelos fiscales guardados')
            else
              ...data.items.map((item) => _TaxReturnCard(item: item)),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fiscalidad',
          style: TextStyle(
            color: context.appPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Modelos presentados',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: context.appText,
          ),
        ),
      ],
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  final TaxReturnSummary summary;

  const _SummaryGrid({required this.summary});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.55,
      children: [
        _SummaryTile(label: 'Presentados', value: '${summary.presented}'),
        _SummaryTile(label: 'Borradores', value: '${summary.draft}'),
        _SummaryTile(
          label: 'Última presentación',
          value: _formatDate(summary.lastPresentedAt),
          compact: true,
        ),
        _SummaryTile(
          label: 'Próximo plazo',
          value: summary.nextDue == null
              ? 'Sin plazo'
              : '${summary.nextDue!.label}\n${_formatDate(summary.nextDue!.dueDate)}',
          compact: true,
        ),
      ],
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final String label;
  final String value;
  final bool compact;

  const _SummaryTile({
    required this.label,
    required this.value,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appBorder),
        boxShadow: [
          BoxShadow(
            color: context.appShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: context.appTextSubtle,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: context.appText,
              fontSize: compact ? 13 : 24,
              height: compact ? 1.2 : 1,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaxReturnCard extends StatelessWidget {
  final TaxReturnListItem item;

  const _TaxReturnCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Modelo ${item.model} · ${item.year}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: context.appText,
                  ),
                ),
              ),
              StatusBadge(status: item.status),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.period == 'A' ? 'Declaración anual' : 'Periodo ${item.period}',
            style: TextStyle(color: context.appTextMuted, fontSize: 13),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _Meta(label: 'Presentación', value: _formatDate(item.presentedAt)),
              ),
              Expanded(
                child: _Meta(
                  label: 'Importe trazado',
                  value: '${formatAmount(item.totalAmount)} €',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _Meta(label: 'Casillas', value: '${item.boxCount}')),
              Expanded(child: _Meta(label: 'Exports', value: '${item.exportCount}')),
            ],
          ),
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  final String label;
  final String value;

  const _Meta({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: context.appTextSubtle,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: context.appText,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

String _formatDate(String? value) {
  if (value == null || value.isEmpty) return 'Sin fecha';
  final date = DateTime.tryParse(value);
  if (date == null) return 'Sin fecha';
  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}
