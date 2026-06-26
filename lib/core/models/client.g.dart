// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Client _$ClientFromJson(Map<String, dynamic> json) => _Client(
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

Map<String, dynamic> _$ClientToJson(_Client instance) => <String, dynamic>{
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
