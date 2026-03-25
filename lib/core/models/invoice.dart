import 'package:freezed_annotation/freezed_annotation.dart';
import 'payment.dart';
import '../utils/json_helpers.dart';

part 'invoice.freezed.dart';
part 'invoice.g.dart';

@freezed
class InvoiceListItem with _$InvoiceListItem {
  const factory InvoiceListItem({
    required int id,
    required String type,
    required String status,
    required String series,
    required int number,
    required String issuedAt,
    @JsonKey(fromJson: toDouble) required double total,
    required String invoiceType,
    String? taxKind,
    InvoiceClient? client,
  }) = _InvoiceListItem;

  factory InvoiceListItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceListItemFromJson(json);
}

@freezed
class InvoiceClient with _$InvoiceClient {
  const factory InvoiceClient({
    required int id,
    required String name,
    required String taxId,
  }) = _InvoiceClient;

  factory InvoiceClient.fromJson(Map<String, dynamic> json) =>
      _$InvoiceClientFromJson(json);
}

@freezed
class InvoiceDetail with _$InvoiceDetail {
  const factory InvoiceDetail({
    required int id,
    required String type,
    required String status,
    required String series,
    required int number,
    required String issuedAt,
    @JsonKey(fromJson: toDouble) required double total,
    required String invoiceType,
    String? taxKind,
    String? publicNotes,
    String? invoiceNote,
    InvoiceDetailClient? client,
    CreatedBy? createdBy,
    required List<InvoiceLine> lines,
    required List<Payment> payments,
  }) = _InvoiceDetail;

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDetailFromJson(json);
}

@freezed
class InvoiceDetailClient with _$InvoiceDetailClient {
  const factory InvoiceDetailClient({
    required int id,
    required String name,
    required String taxId,
    String? email,
    String? phone,
    String? address,
    String? city,
  }) = _InvoiceDetailClient;

  factory InvoiceDetailClient.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDetailClientFromJson(json);
}

@freezed
class CreatedBy with _$CreatedBy {
  const factory CreatedBy({
    required int id,
    required String name,
  }) = _CreatedBy;

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);
}

@freezed
class InvoiceLine with _$InvoiceLine {
  const factory InvoiceLine({
    required int id,
    required String description,
    @JsonKey(fromJson: toDouble) required double quantity,
    @JsonKey(fromJson: toDouble) required double unitPrice,
    @JsonKey(fromJson: toDouble) required double discountRate,
    @JsonKey(fromJson: toDouble) required double taxRate,
    @JsonKey(fromJson: toDouble) required double taxAmount,
    @JsonKey(fromJson: toDouble) required double total,
  }) = _InvoiceLine;

  factory InvoiceLine.fromJson(Map<String, dynamic> json) =>
      _$InvoiceLineFromJson(json);
}
