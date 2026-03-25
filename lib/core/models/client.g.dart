// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientImpl _$$ClientImplFromJson(Map<String, dynamic> json) => _$ClientImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  taxId: json['taxId'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  postalCode: json['postalCode'] as String? ?? '',
  city: json['city'] as String? ?? '',
  companyId: (json['companyId'] as num).toInt(),
);

Map<String, dynamic> _$$ClientImplToJson(_$ClientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'taxId': instance.taxId,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'postalCode': instance.postalCode,
      'city': instance.city,
      'companyId': instance.companyId,
    };
