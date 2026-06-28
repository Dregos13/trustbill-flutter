import 'package:freezed_annotation/freezed_annotation.dart';
import '../utils/json_helpers.dart';

part 'sale.freezed.dart';
part 'sale.g.dart';

@freezed
abstract class SaleListItem with _$SaleListItem {
  const factory SaleListItem({
    required int id,
    required String code,
    required String status,
    String? regime,
    int? budgetId,
    @JsonKey(fromJson: toDouble) required double totalPlanned,
    @JsonKey(fromJson: toDouble) required double totalInvoiced,
    @JsonKey(fromJson: toDouble) required double totalPending,
    required String createdAt,
    SaleParty? client,
    SaleParty? vendor,
  }) = _SaleListItem;

  factory SaleListItem.fromJson(Map<String, dynamic> json) =>
      _$SaleListItemFromJson(json);
}

@freezed
abstract class SaleParty with _$SaleParty {
  const factory SaleParty({
    required int id,
    String? name,
    String? taxId,
    String? email,
  }) = _SaleParty;

  factory SaleParty.fromJson(Map<String, dynamic> json) =>
      _$SalePartyFromJson(json);
}

@freezed
abstract class AvailableBudget with _$AvailableBudget {
  const factory AvailableBudget({
    required int id,
    required String series,
    required int number,
    required String issuedAt,
    @JsonKey(fromJson: toDouble) required double total,
    String? taxKind,
    String? quoteStatus,
    SaleParty? client,
  }) = _AvailableBudget;

  factory AvailableBudget.fromJson(Map<String, dynamic> json) =>
      _$AvailableBudgetFromJson(json);
}

@freezed
abstract class SaleDetail with _$SaleDetail {
  const factory SaleDetail({
    required int id,
    required String code,
    required String status,
    String? regime,
    String? taxKind,
    int? budgetId,
    String? internalNotes,
    @JsonKey(fromJson: toDouble) required double totalPlanned,
    @JsonKey(fromJson: toDouble) required double totalInvoiced,
    @JsonKey(fromJson: toDouble) required double totalPending,
    SaleParty? client,
    SaleParty? vendor,
    SaleBudgetRef? budget,
    @Default([]) List<SaleDetailLine> lines,
    @Default([]) List<SaleInstallment> installments,
    @Default([]) List<SaleInvoiceRef> invoices,
  }) = _SaleDetail;

  factory SaleDetail.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailFromJson(json);
}

@freezed
abstract class SaleBudgetRef with _$SaleBudgetRef {
  const factory SaleBudgetRef({
    required int id,
    required String series,
    required int number,
    required String status,
    required String issuedAt,
    @JsonKey(fromJson: toDouble) required double total,
    String? taxKind,
  }) = _SaleBudgetRef;

  factory SaleBudgetRef.fromJson(Map<String, dynamic> json) =>
      _$SaleBudgetRefFromJson(json);
}

@freezed
abstract class SaleDetailLine with _$SaleDetailLine {
  const factory SaleDetailLine({
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
    @JsonKey(fromJson: toDouble) @Default(0) double invoicedQuantity,
    @JsonKey(fromJson: toDouble) @Default(0) double invoicedTotal,
    @JsonKey(fromJson: toDouble) @Default(0) double pendingQuantity,
    @JsonKey(fromJson: toDouble) @Default(0) double pendingTotal,
  }) = _SaleDetailLine;

  factory SaleDetailLine.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailLineFromJson(json);
}

@freezed
abstract class SaleInstallment with _$SaleInstallment {
  const factory SaleInstallment({
    required int id,
    required int index,
    String? dueDate,
    @JsonKey(fromJson: toDoubleN) double? percentage,
    @JsonKey(fromJson: toDoubleN) double? plannedAmount,
  }) = _SaleInstallment;

  factory SaleInstallment.fromJson(Map<String, dynamic> json) =>
      _$SaleInstallmentFromJson(json);
}

@freezed
abstract class SaleInvoiceRef with _$SaleInvoiceRef {
  const factory SaleInvoiceRef({
    required int id,
    required String series,
    required int number,
    required String status,
    required String issuedAt,
    @JsonKey(fromJson: toDouble) required double total,
    @Default(false) bool isFinal,
  }) = _SaleInvoiceRef;

  factory SaleInvoiceRef.fromJson(Map<String, dynamic> json) =>
      _$SaleInvoiceRefFromJson(json);
}
