import 'package:freezed_annotation/freezed_annotation.dart';
import '../utils/json_helpers.dart';

part 'budget.freezed.dart';
part 'budget.g.dart';

@freezed
abstract class BudgetListItem with _$BudgetListItem {
  const factory BudgetListItem({
    required int id,
    required String series,
    required int number,
    required String status,
    String? quoteStatus,
    required String issuedAt,
    @JsonKey(fromJson: toDouble) required double total,
    String? taxKind,
    int? saleId,
    BudgetClient? client,
  }) = _BudgetListItem;

  factory BudgetListItem.fromJson(Map<String, dynamic> json) =>
      _$BudgetListItemFromJson(json);
}

@freezed
abstract class BudgetClient with _$BudgetClient {
  const factory BudgetClient({
    required int id,
    required String name,
    String? taxId,
  }) = _BudgetClient;

  factory BudgetClient.fromJson(Map<String, dynamic> json) =>
      _$BudgetClientFromJson(json);
}

@freezed
abstract class BudgetDetail with _$BudgetDetail {
  const factory BudgetDetail({
    required int id,
    required String series,
    required int number,
    required String status,
    String? quoteStatus,
    required String issuedAt,
    @JsonKey(fromJson: toDouble) required double total,
    String? taxKind,
    int? paymentPlanCount,
    int? saleId,
    String? internalNotes,
    String? publicNotes,
    BudgetClient? client,
    @Default([]) List<BudgetLine> lines,
  }) = _BudgetDetail;

  factory BudgetDetail.fromJson(Map<String, dynamic> json) =>
      _$BudgetDetailFromJson(json);
}

@freezed
abstract class BudgetLine with _$BudgetLine {
  const factory BudgetLine({
    required int id,
    int? productId,
    int? serviceId,
    required String description,
    @JsonKey(fromJson: toDouble) required double quantity,
    @JsonKey(fromJson: toDouble) required double unitPrice,
    @JsonKey(fromJson: toDouble) required double discountRate,
    @JsonKey(fromJson: toDouble) required double taxRate,
    @JsonKey(fromJson: toDouble) required double taxAmount,
    @JsonKey(fromJson: toDouble) required double total,
  }) = _BudgetLine;

  factory BudgetLine.fromJson(Map<String, dynamic> json) =>
      _$BudgetLineFromJson(json);
}
