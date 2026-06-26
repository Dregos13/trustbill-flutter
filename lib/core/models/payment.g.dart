// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  id: (json['id'] as num).toInt(),
  amount: toDouble(json['amount']),
  method: json['method'] as String,
  paidAt: json['paidAt'] as String,
  reference: json['reference'] as String?,
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'method': instance.method,
  'paidAt': instance.paidAt,
  'reference': instance.reference,
};
