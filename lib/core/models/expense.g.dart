// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseConfirmPayloadImpl _$$ExpenseConfirmPayloadImplFromJson(
  Map<String, dynamic> json,
) => _$ExpenseConfirmPayloadImpl(
  supplierName: json['supplierName'] as String,
  supplierCif: json['supplierCif'] as String? ?? '',
  supplierAddress: json['supplierAddress'] as String?,
  date: json['date'] as String,
  category: json['category'] as String? ?? 'OTHER',
  description: json['description'] as String,
  baseAmount: (json['baseAmount'] as num).toDouble(),
  taxKind: json['taxKind'] as String?,
  taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0,
  vatAmount: (json['vatAmount'] as num?)?.toDouble() ?? 0,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  imageBase64: json['imageBase64'] as String,
  imageMimeType: json['imageMimeType'] as String,
);

Map<String, dynamic> _$$ExpenseConfirmPayloadImplToJson(
  _$ExpenseConfirmPayloadImpl instance,
) => <String, dynamic>{
  'supplierName': instance.supplierName,
  'supplierCif': instance.supplierCif,
  'supplierAddress': instance.supplierAddress,
  'date': instance.date,
  'category': instance.category,
  'description': instance.description,
  'baseAmount': instance.baseAmount,
  'taxKind': instance.taxKind,
  'taxRate': instance.taxRate,
  'vatAmount': instance.vatAmount,
  'totalAmount': instance.totalAmount,
  'imageBase64': instance.imageBase64,
  'imageMimeType': instance.imageMimeType,
};

_$ExpenseCreatedResponseImpl _$$ExpenseCreatedResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ExpenseCreatedResponseImpl(
  expense: ExpenseInfo.fromJson(json['expense'] as Map<String, dynamic>),
  supplier: SupplierInfo.fromJson(json['supplier'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ExpenseCreatedResponseImplToJson(
  _$ExpenseCreatedResponseImpl instance,
) => <String, dynamic>{
  'expense': instance.expense,
  'supplier': instance.supplier,
};

_$ExpenseInfoImpl _$$ExpenseInfoImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseInfoImpl(
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      description: json['description'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$$ExpenseInfoImplToJson(_$ExpenseInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'description': instance.description,
      'totalAmount': instance.totalAmount,
    };

_$SupplierInfoImpl _$$SupplierInfoImplFromJson(Map<String, dynamic> json) =>
    _$SupplierInfoImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      taxId: json['taxId'] as String? ?? '',
      created: json['created'] as bool? ?? false,
    );

Map<String, dynamic> _$$SupplierInfoImplToJson(_$SupplierInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'taxId': instance.taxId,
      'created': instance.created,
    };
