import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
class ExpenseConfirmPayload with _$ExpenseConfirmPayload {
  const factory ExpenseConfirmPayload({
    required String supplierName,
    @Default('') String supplierCif,
    String? supplierAddress,
    required String date,
    @Default('OTHER') String category,
    required String description,
    required double baseAmount,
    String? taxKind,
    @Default(0) double taxRate,
    @Default(0) double vatAmount,
    required double totalAmount,
    required String imageBase64,
    required String imageMimeType,
  }) = _ExpenseConfirmPayload;

  factory ExpenseConfirmPayload.fromJson(Map<String, dynamic> json) =>
      _$ExpenseConfirmPayloadFromJson(json);
}

@freezed
class ExpenseCreatedResponse with _$ExpenseCreatedResponse {
  const factory ExpenseCreatedResponse({
    required ExpenseInfo expense,
    required SupplierInfo supplier,
  }) = _ExpenseCreatedResponse;

  factory ExpenseCreatedResponse.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCreatedResponseFromJson(json);
}

@freezed
class ExpenseInfo with _$ExpenseInfo {
  const factory ExpenseInfo({
    required int id,
    required String category,
    required String description,
    required double totalAmount,
  }) = _ExpenseInfo;

  factory ExpenseInfo.fromJson(Map<String, dynamic> json) =>
      _$ExpenseInfoFromJson(json);
}

@freezed
class SupplierInfo with _$SupplierInfo {
  const factory SupplierInfo({
    required int id,
    required String name,
    @Default('') String taxId,
    @Default(false) bool created,
  }) = _SupplierInfo;

  factory SupplierInfo.fromJson(Map<String, dynamic> json) =>
      _$SupplierInfoFromJson(json);
}
