import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/auth_state.dart';
import '../../core/models/dashboard.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/currency.dart';
import '../../core/utils/date.dart';
import '../../core/utils/error_messages.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_indicator.dart';
import '../tax/tax_returns_screen.dart';

enum DashboardRangePreset { month, quarter, year, custom }

class DashboardRange {
  final DateTime from;
  final DateTime to;
  final DashboardRangePreset preset;

  const DashboardRange({
    required this.from,
    required this.to,
    required this.preset,
  });

  String get apiFrom => DateFormat('yyyy-MM-dd').format(from);
  String get apiTo => DateFormat('yyyy-MM-dd').format(to);

  String get label {
    final fmt = DateFormat('dd MMM', 'es_ES');
    if (preset == DashboardRangePreset.month) {
      return DateFormat('MMMM yyyy', 'es_ES').format(from);
    }
    if (from.year == to.year) {
      return '${fmt.format(from)} - ${fmt.format(to)}';
    }
    return '${DateFormat('dd/MM/yy', 'es_ES').format(from)} - ${DateFormat('dd/MM/yy', 'es_ES').format(to)}';
  }
}

class DashboardRangeNotifier extends Notifier<DashboardRange> {
  @override
  DashboardRange build() => _presetRange(DashboardRangePreset.month);

  void setPreset(DashboardRangePreset preset) {
    state = _presetRange(preset);
  }

  void setCustom(DateTime from, DateTime to) {
    state = DashboardRange(
      from: DateTime(from.year, from.month, from.day),
      to: DateTime(to.year, to.month, to.day),
      preset: DashboardRangePreset.custom,
    );
  }

  DashboardRange _presetRange(DashboardRangePreset preset) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return switch (preset) {
      DashboardRangePreset.month => DashboardRange(
        from: DateTime(today.year, today.month),
        to: today,
        preset: preset,
      ),
      DashboardRangePreset.quarter => DashboardRange(
        from: DateTime(today.year, today.month - 2),
        to: today,
        preset: preset,
      ),
      DashboardRangePreset.year => DashboardRange(
        from: DateTime(today.year),
        to: today,
        preset: preset,
      ),
      DashboardRangePreset.custom => DashboardRange(
        from: DateTime(today.year, today.month),
        to: today,
        preset: preset,
      ),
    };
  }
}

final dashboardRangeProvider =
    NotifierProvider<DashboardRangeNotifier, DashboardRange>(
      DashboardRangeNotifier.new,
    );

final mobileDashboardProvider =
    FutureProvider.autoDispose<MobileDashboardSummary>((ref) async {
      final auth = ref.watch(authProvider);
      if (auth is! AuthAuthenticated) throw StateError('Not authenticated');
      final range = ref.watch(dashboardRangeProvider);
      return ref
          .read(endpointsProvider)
          .getMobileDashboard(from: range.apiFrom, to: range.apiTo);
    });

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(mobileDashboardProvider);
    final range = ref.watch(dashboardRangeProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(mobileDashboardProvider.future),
      child: dashboardAsync.when(
        loading: () => const LoadingIndicator(),
        error: (err, _) => ListView(
          children: [
            EmptyState(
              message: err is ApiError
                  ? err.message
                  : friendlyError(err, fallback: 'Error al cargar el resumen'),
            ),
          ],
        ),
        data: (summary) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _Header(range: range),
            const SizedBox(height: 12),
            _RangeSelector(range: range),
            const SizedBox(height: 16),
            _HeroSummary(summary: summary, range: range),
            const SizedBox(height: 12),
            _KpiGrid(summary: summary),
            const SizedBox(height: 16),
            _TaxSnapshot(),
            const SizedBox(height: 24),
            _SectionHeader(title: 'Agenda de cobros', trailing: '2 semanas'),
            const SizedBox(height: 10),
            _UpcomingList(items: summary.upcoming),
            const SizedBox(height: 24),
            _SectionHeader(
              title: 'Top clientes',
              trailing: 'Ver todos',
              onTap: () => context.push('/clients'),
            ),
            const SizedBox(height: 10),
            _TopClients(clients: summary.topClients),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.range});

  final DashboardRange range;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inicio',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: context.appText,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                range.label,
                style: TextStyle(
                  fontSize: 12,
                  color: context.appTextMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.insights_outlined, color: context.appPrimary),
      ],
    );
  }
}

class _RangeSelector extends ConsumerWidget {
  const _RangeSelector({required this.range});

  final DashboardRange range;

  void _setPreset(WidgetRef ref, DashboardRangePreset preset) {
    ref.read(dashboardRangeProvider.notifier).setPreset(preset);
    ref.invalidate(mobileDashboardProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _RangeChip(
            label: 'Mes',
            selected: range.preset == DashboardRangePreset.month,
            onTap: () => _setPreset(ref, DashboardRangePreset.month),
          ),
          _RangeChip(
            label: 'Trimestre',
            selected: range.preset == DashboardRangePreset.quarter,
            onTap: () => _setPreset(ref, DashboardRangePreset.quarter),
          ),
          _RangeChip(
            label: 'Año',
            selected: range.preset == DashboardRangePreset.year,
            onTap: () => _setPreset(ref, DashboardRangePreset.year),
          ),
          _RangeChip(
            label: 'Rango',
            icon: Icons.date_range,
            selected: range.preset == DashboardRangePreset.custom,
            onTap: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialDateRange: DateTimeRange(
                  start: range.from,
                  end: range.to,
                ),
              );
              if (picked == null || !context.mounted) return;
              ref
                  .read(dashboardRangeProvider.notifier)
                  .setCustom(picked.start, picked.end);
              ref.invalidate(mobileDashboardProvider);
            },
          ),
        ],
      ),
    );
  }
}

class _RangeChip extends StatelessWidget {
  const _RangeChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        selected: selected,
        onSelected: (_) => onTap(),
        avatar: icon == null
            ? null
            : Icon(
                icon,
                size: 16,
                color: selected ? context.onPrimary : context.appTextMuted,
              ),
        label: Text(label),
        selectedColor: context.appPrimary,
        labelStyle: TextStyle(
          color: selected ? context.onPrimary : context.appText,
          fontWeight: FontWeight.w700,
        ),
        side: BorderSide(color: context.appBorder),
      ),
    );
  }
}

class _HeroSummary extends StatelessWidget {
  const _HeroSummary({required this.summary, required this.range});

  final MobileDashboardSummary summary;
  final DashboardRange range;

  @override
  Widget build(BuildContext context) {
    final changeLabel = _changeLabel(
      summary.month.facturado,
      summary.month.facturadoPrev,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.isDark ? context.appSurfaceRaised : AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Facturado · ${summary.month.label.toLowerCase()}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formatCurrency(summary.month.facturado),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              changeLabel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.18)),
          const SizedBox(height: 14),
          Row(
            children: const [
              _LegendDot(color: AppColors.primaryLight, label: 'Ingresos'),
              SizedBox(width: 14),
              _LegendDot(color: AppColors.warning, label: 'Gastos'),
            ],
          ),
          const SizedBox(height: 12),
          _HistoryBars(items: summary.history),
        ],
      ),
    );
  }

  String _changeLabel(double current, double previous) {
    if (previous <= 0) {
      return current > 0 ? 'Sin comparativa previa' : 'Sin cambios';
    }
    final pct = ((current - previous) / previous * 100).round();
    final sign = pct > 0 ? '+' : '';
    return '$sign$pct% vs periodo anterior';
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _HistoryBars extends StatelessWidget {
  const _HistoryBars({required this.items});

  final List<MobileDashboardHistoryItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox(height: 72);
    }
    final maxValue = items.fold<double>(
      1,
      (max, item) =>
          [max, item.ingresos, item.gastos].reduce((a, b) => a > b ? a : b),
    );

    return SizedBox(
      height: 96,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: items
            .map(
              (item) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _Bar(
                              value: item.ingresos,
                              maxValue: maxValue,
                              color: AppColors.primaryLight,
                            ),
                            const SizedBox(width: 3),
                            _Bar(
                              value: item.gastos,
                              maxValue: maxValue,
                              color: AppColors.warning,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.value,
    required this.maxValue,
    required this.color,
  });

  final double value;
  final double maxValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final height = value <= 0
        ? 4.0
        : 58 * (value / maxValue).clamp(0.08, 1.0).toDouble();
    return Container(
      width: 8,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.summary});

  final MobileDashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    final cashflow = summary.month.cobrado - summary.month.gastos;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.72,
      children: [
        _KpiTile(
          label: 'Cobrado',
          value: formatCurrency(summary.month.cobrado),
          icon: Icons.payments_outlined,
          color: AppColors.success,
        ),
        _KpiTile(
          label: 'Pendiente',
          value: formatCurrency(summary.month.pendiente),
          icon: Icons.schedule,
          color: AppColors.warning,
        ),
        _KpiTile(
          label: 'Gastos',
          value: formatCurrency(summary.month.gastos),
          icon: Icons.shopping_bag_outlined,
          color: AppColors.danger,
        ),
        _KpiTile(
          label: 'Cashflow',
          value: formatCurrency(cashflow),
          icon: Icons.account_balance_wallet_outlined,
          color: cashflow >= 0 ? AppColors.success : AppColors.danger,
        ),
      ],
    );
  }
}

class _KpiTile extends StatelessWidget {
  const _KpiTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.appBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 17, color: color),
              const Spacer(),
              Text(
                label,
                style: TextStyle(
                  color: context.appTextMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                color: context.appText,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaxSnapshot extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taxAsync = ref.watch(taxReturnsProvider);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => context.push('/tax'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.appBorder),
        ),
        child: taxAsync.when(
          loading: () => Text(
            'Cargando situación fiscal...',
            style: TextStyle(
              color: context.appTextMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
          error: (_, _) => _TaxRow(
            title: 'Historial fiscal',
            subtitle: 'Ver modelos y vencimientos',
            trailing: null,
          ),
          data: (tax) => _TaxRow(
            title: 'Historial fiscal',
            subtitle:
                '${tax.summary.presented} presentados · ${tax.summary.draft} borradores',
            trailing: tax.summary.nextDue?.label,
          ),
        ),
      ),
    );
  }
}

class _TaxRow extends StatelessWidget {
  const _TaxRow({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final String title;
  final String subtitle;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.account_balance_outlined, color: context.appPrimary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: context.appText,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(color: context.appTextMuted, fontSize: 12),
              ),
            ],
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: TextStyle(
              color: context.appPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        const SizedBox(width: 6),
        Icon(Icons.chevron_right, color: context.appTextSubtle),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.trailing,
    this.onTap,
  });

  final String title;
  final String trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final trailingWidget = Text(
      trailing,
      style: TextStyle(
        color: onTap == null ? context.appTextMuted : context.appPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
    );
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: context.appText,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (onTap == null)
          trailingWidget
        else
          InkWell(onTap: onTap, child: trailingWidget),
      ],
    );
  }
}

class _UpcomingList extends StatelessWidget {
  const _UpcomingList({required this.items});

  final List<MobileDashboardUpcomingItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _EmptyPanel(
        icon: Icons.event_available_outlined,
        text: 'No hay vencimientos próximos con fecha real.',
      );
    }
    return Column(
      children: items.map((item) => _UpcomingTile(item: item)).toList(),
    );
  }
}

class _UpcomingTile extends StatelessWidget {
  const _UpcomingTile({required this.item});

  final MobileDashboardUpcomingItem item;

  @override
  Widget build(BuildContext context) {
    final isOverdue = item.dueIn < 0;
    final color = isOverdue
        ? AppColors.danger
        : item.dueIn <= 5
        ? AppColors.warning
        : AppColors.primary;
    final dateLabel = isOverdue
        ? 'Hace ${item.dueIn.abs()} días'
        : item.dueIn == 0
        ? 'Hoy'
        : item.dueIn == 1
        ? 'Mañana'
        : 'En ${item.dueIn} días';

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => context.push('/invoices/${item.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.appBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.dueIn.abs().toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text('días', style: TextStyle(color: color, fontSize: 10)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.client,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.appText,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${item.invoiceId} · $dateLabel · ${formatDate(item.dueDate)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: context.appTextMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              formatCurrency(item.amount),
              style: TextStyle(
                color: context.appText,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopClients extends StatelessWidget {
  const _TopClients({required this.clients});

  final List<MobileDashboardTopClient> clients;

  @override
  Widget build(BuildContext context) {
    if (clients.isEmpty) {
      return _EmptyPanel(
        icon: Icons.people_outline,
        text: 'Aún no hay facturación en este rango.',
      );
    }
    return Column(
      children: clients.asMap().entries.map((entry) {
        final index = entry.key;
        final client = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.appBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index == 0
                      ? context.appPrimary.withValues(alpha: 0.14)
                      : context.appSurfaceRaised,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: index == 0 ? context.appPrimary : context.appText,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.appText,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (client.pct / 100).clamp(0.0, 1.0).toDouble(),
                        minHeight: 5,
                        color: context.appPrimary,
                        backgroundColor: context.appBorder,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${client.pct}%',
                style: TextStyle(
                  color: context.appTextMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                formatCurrency(client.amount),
                style: TextStyle(
                  color: context.appText,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.appBorder),
      ),
      child: Row(
        children: [
          Icon(icon, color: context.appTextSubtle),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: context.appTextMuted, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
