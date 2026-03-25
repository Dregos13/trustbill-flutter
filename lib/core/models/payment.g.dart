// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      id: (json['id'] as num).toInt(),
      amount: toDouble(json['amount']),
      method: json['method'] as String,
      paidAt: json['paidAt'] as String,
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'method': instance.method,
      'paidAt': instance.paidAt,
      'reference': instance.reference,
    };
