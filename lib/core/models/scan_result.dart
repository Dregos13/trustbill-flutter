import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_result.freezed.dart';
part 'scan_result.g.dart';

@freezed
class OcrLineItem with _$OcrLineItem {
  const factory OcrLineItem({
    required String description,
    required double quantity,
    required double unitPrice,
    required double taxRate,
    required double total,
  }) = _OcrLineItem;

  factory OcrLineItem.fromJson(Map<String, dynamic> json) =>
      _$OcrLineItemFromJson(json);
}

@freezed
class ScanResult with _$ScanResult {
  const factory ScanResult({
    String? supplierName,
    String? supplierCif,
    String? supplierAddress,
    String? invoiceNumber,
    String? date,
    @Default('EUR') String currency,
    @Default([]) List<OcrLineItem> lines,
    @Default(0) double subtotal,
    @Default(0) double taxAmount,
    @Default(0) double total,
    @Default(0) double confidence,
  }) = _ScanResult;

  factory ScanResult.fromJson(Map<String, dynamic> json) =>
      _$ScanResultFromJson(json);
}
