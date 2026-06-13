// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BudgetListItemImpl _$$BudgetListItemImplFromJson(Map<String, dynamic> json) =>
    _$BudgetListItemImpl(
      id: (json['id'] as num).toInt(),
      series: json['series'] as String,
      number: (json['number'] as num).toInt(),
      status: json['status'] as String,
      quoteStatus: json['quoteStatus'] as String?,
      issuedAt: json['issuedAt'] as String,
      total: toDouble(json['total']),
      taxKind: json['taxKind'] as String?,
      saleId: (json['saleId'] as num?)?.toInt(),
      client: json['client'] == null
          ? null
          : BudgetClient.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BudgetListItemImplToJson(
  _$BudgetListItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'series': instance.series,
  'number': instance.number,
  'status': instance.status,
  'quoteStatus': instance.quoteStatus,
  'issuedAt': instance.issuedAt,
  'total': instance.total,
  'taxKind': instance.taxKind,
  'saleId': instance.saleId,
  'client': instance.client,
};

_$BudgetClientImpl _$$BudgetClientImplFromJson(Map<String, dynamic> json) =>
    _$BudgetClientImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      taxId: json['taxId'] as String?,
    );

Map<String, dynamic> _$$BudgetClientImplToJson(_$BudgetClientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'taxId': instance.taxId,
    };

_$BudgetDetailImpl _$$BudgetDetailImplFromJson(Map<String, dynamic> json) =>
    _$BudgetDetailImpl(
      id: (json['id'] as num).toInt(),
      series: json['series'] as String,
      number: (json['number'] as num).toInt(),
      status: json['status'] as String,
      quoteStatus: json['quoteStatus'] as String?,
      issuedAt: json['issuedAt'] as String,
      total: toDouble(json['total']),
      taxKind: json['taxKind'] as String?,
      paymentPlanCount: (json['paymentPlanCount'] as num?)?.toInt(),
      saleId: (json['saleId'] as num?)?.toInt(),
      internalNotes: json['internalNotes'] as String?,
      publicNotes: json['publicNotes'] as String?,
      client: json['client'] == null
          ? null
          : BudgetClient.fromJson(json['client'] as Map<String, dynamic>),
      lines:
          (json['lines'] as List<dynamic>?)
              ?.map((e) => BudgetLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BudgetDetailImplToJson(_$BudgetDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'series': instance.series,
      'number': instance.number,
      'status': instance.status,
      'quoteStatus': instance.quoteStatus,
      'issuedAt': instance.issuedAt,
      'total': instance.total,
      'taxKind': instance.taxKind,
      'paymentPlanCount': instance.paymentPlanCount,
      'saleId': instance.saleId,
      'internalNotes': instance.internalNotes,
      'publicNotes': instance.publicNotes,
      'client': instance.client,
      'lines': instance.lines,
    };

_$BudgetLineImpl _$$BudgetLineImplFromJson(Map<String, dynamic> json) =>
    _$BudgetLineImpl(
      id: (json['id'] as num).toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      serviceId: (json['serviceId'] as num?)?.toInt(),
      description: json['description'] as String,
      quantity: toDouble(json['quantity']),
      unitPrice: toDouble(json['unitPrice']),
      discountRate: toDouble(json['discountRate']),
      taxRate: toDouble(json['taxRate']),
      taxAmount: toDouble(json['taxAmount']),
      total: toDouble(json['total']),
    );

Map<String, dynamic> _$$BudgetLineImplToJson(_$BudgetLineImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'serviceId': instance.serviceId,
      'description': instance.description,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'discountRate': instance.discountRate,
      'taxRate': instance.taxRate,
      'taxAmount': instance.taxAmount,
      'total': instance.total,
    };
