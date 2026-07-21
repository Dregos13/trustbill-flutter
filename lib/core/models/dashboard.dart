import 'package:freezed_annotation/freezed_annotation.dart';
import '../utils/json_helpers.dart';

part 'dashboard.freezed.dart';
part 'dashboard.g.dart';

@freezed
abstract class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    required int invoicesThisMonth,
    @JsonKey(fromJson: toDouble) required double totalBilled,
    @JsonKey(fromJson: toDouble) required double totalCollected,
    @JsonKey(fromJson: toDouble) required double totalPending,
    required List<DashboardInvoice> recentInvoices,
  }) = _DashboardSummary;

  factory DashboardSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryFromJson(json);
}

@freezed
abstract class DashboardInvoice with _$DashboardInvoice {
  const factory DashboardInvoice({
    required int id,
    required String series,
    required int number,
    required String status,
    @JsonKey(fromJson: toDouble) required double total,
    String? clientName,
    String? issuedAt,
  }) = _DashboardInvoice;

  factory DashboardInvoice.fromJson(Map<String, dynamic> json) =>
      _$DashboardInvoiceFromJson(json);
}

class MobileDashboardSummary {
  final MobileDashboardMonth month;
  final List<MobileDashboardHistoryItem> history;
  final List<MobileDashboardUpcomingItem> upcoming;
  final List<MobileDashboardTopClient> topClients;

  const MobileDashboardSummary({
    required this.month,
    required this.history,
    required this.upcoming,
    required this.topClients,
  });

  factory MobileDashboardSummary.fromJson(
    Map<String, dynamic> json,
  ) => MobileDashboardSummary(
    month: MobileDashboardMonth.fromJson(json['month'] as Map<String, dynamic>),
    history: ((json['history'] as List?) ?? const [])
        .map(
          (e) => MobileDashboardHistoryItem.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
    upcoming: ((json['upcoming'] as List?) ?? const [])
        .map(
          (e) =>
              MobileDashboardUpcomingItem.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
    topClients: ((json['topClients'] as List?) ?? const [])
        .map(
          (e) => MobileDashboardTopClient.fromJson(e as Map<String, dynamic>),
        )
        .toList(),
  );
}

class MobileDashboardMonth {
  final String label;
  final double facturado;
  final double facturadoPrev;
  final double cobrado;
  final double pendiente;
  final double gastos;
  final int facturasCount;

  const MobileDashboardMonth({
    required this.label,
    required this.facturado,
    required this.facturadoPrev,
    required this.cobrado,
    required this.pendiente,
    required this.gastos,
    required this.facturasCount,
  });

  factory MobileDashboardMonth.fromJson(Map<String, dynamic> json) =>
      MobileDashboardMonth(
        label: json['label'] as String? ?? '',
        facturado: toDouble(json['facturado']),
        facturadoPrev: toDouble(json['facturadoPrev']),
        cobrado: toDouble(json['cobrado']),
        pendiente: toDouble(json['pendiente']),
        gastos: toDouble(json['gastos']),
        facturasCount: json['facturasCount'] as int? ?? 0,
      );
}

class MobileDashboardHistoryItem {
  final String label;
  final double ingresos;
  final double gastos;

  const MobileDashboardHistoryItem({
    required this.label,
    required this.ingresos,
    required this.gastos,
  });

  factory MobileDashboardHistoryItem.fromJson(Map<String, dynamic> json) =>
      MobileDashboardHistoryItem(
        label: json['m'] as String? ?? '',
        ingresos: toDouble(json['ingresos']),
        gastos: toDouble(json['gastos']),
      );
}

class MobileDashboardUpcomingItem {
  final int id;
  final String invoiceId;
  final String client;
  final double amount;
  final String dueDate;
  final int dueIn;
  final String status;

  const MobileDashboardUpcomingItem({
    required this.id,
    required this.invoiceId,
    required this.client,
    required this.amount,
    required this.dueDate,
    required this.dueIn,
    required this.status,
  });

  factory MobileDashboardUpcomingItem.fromJson(Map<String, dynamic> json) =>
      MobileDashboardUpcomingItem(
        id: json['id'] as int,
        invoiceId: json['invoiceId'] as String? ?? '',
        client: json['client'] as String? ?? 'Sin cliente',
        amount: toDouble(json['amount']),
        dueDate: json['dueDate'] as String? ?? '',
        dueIn: json['dueIn'] as int? ?? 0,
        status: json['status'] as String? ?? 'ok',
      );
}

class MobileDashboardTopClient {
  final int? id;
  final String name;
  final double amount;
  final int pct;

  const MobileDashboardTopClient({
    required this.id,
    required this.name,
    required this.amount,
    required this.pct,
  });

  factory MobileDashboardTopClient.fromJson(Map<String, dynamic> json) =>
      MobileDashboardTopClient(
        id: json['id'] as int?,
        name: json['name'] as String? ?? 'Sin cliente',
        amount: toDouble(json['amount']),
        pct: json['pct'] as int? ?? 0,
      );
}
