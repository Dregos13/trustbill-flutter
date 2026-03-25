import 'package:freezed_annotation/freezed_annotation.dart';
import '../utils/json_helpers.dart';

part 'dashboard.freezed.dart';
part 'dashboard.g.dart';

@freezed
class DashboardSummary with _$DashboardSummary {
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
class DashboardInvoice with _$DashboardInvoice {
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
