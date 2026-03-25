import 'package:freezed_annotation/freezed_annotation.dart';
import '../utils/json_helpers.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
class Payment with _$Payment {
  const factory Payment({
    required int id,
    @JsonKey(fromJson: toDouble) required double amount,
    required String method,
    required String paidAt,
    String? reference,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
