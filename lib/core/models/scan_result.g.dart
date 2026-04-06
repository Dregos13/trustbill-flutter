// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OcrLineItemImpl _$$OcrLineItemImplFromJson(Map<String, dynamic> json) =>
    _$OcrLineItemImpl(
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      taxRate: (json['taxRate'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$OcrLineItemImplToJson(_$OcrLineItemImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'taxRate': instance.taxRate,
      'total': instance.total,
    };

_$ScanResultImpl _$$ScanResultImplFromJson(Map<String, dynamic> json) =>
    _$ScanResultImpl(
      supplierName: json['supplierName'] as String?,
      supplierCif: json['supplierCif'] as String?,
      supplierAddress: json['supplierAddress'] as String?,
      invoiceNumber: json['invoiceNumber'] as String?,
      date: json['date'] as String?,
      currency: json['currency'] as String? ?? 'EUR',
      lines:
          (json['lines'] as List<dynamic>?)
              ?.map((e) => OcrLineItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
      taxAmount: (json['taxAmount'] as num?)?.toDouble() ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$ScanResultImplToJson(_$ScanResultImpl instance) =>
    <String, dynamic>{
      'supplierName': instance.supplierName,
      'supplierCif': instance.supplierCif,
      'supplierAddress': instance.supplierAddress,
      'invoiceNumber': instance.invoiceNumber,
      'date': instance.date,
      'currency': instance.currency,
      'lines': instance.lines,
      'subtotal': instance.subtotal,
      'taxAmount': instance.taxAmount,
      'total': instance.total,
      'confidence': instance.confidence,
    };
