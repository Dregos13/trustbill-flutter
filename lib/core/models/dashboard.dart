import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard.freezed.dart';
part 'dashboard.g.dart';

@freezed
class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    required int invoicesThisMonth,
    required double totalBilled,
    required double totalCollected,
    required double totalPending,
    required List<DashboardInvoice> recentInvoices,
  }) = _DashboardSummary;

  factory DashboardSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryFromJson(json);
}

@freezed
class DashboardInvoice with _$DashboardInvoice {
  const factory DashboardInvoice({
    required int id,
    required String series,
    required int number,
    required String status,
    required double total,
    String? clientName,
  }) = _DashboardInvoice;

  factory DashboardInvoice.fromJson(Map<String, dynamic> json) =>
      _$DashboardInvoiceFromJson(json);
}
