// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceListItemImpl _$$InvoiceListItemImplFromJson(
  Map<String, dynamic> json,
) => _$InvoiceListItemImpl(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
  status: json['status'] as String,
  series: json['series'] as String,
  number: (json['number'] as num).toInt(),
  issuedAt: json['issuedAt'] as String,
  total: (json['total'] as num).toDouble(),
  invoiceType: json['invoiceType'] as String,
  taxKind: json['taxKind'] as String?,
  client: json['client'] == null
      ? null
      : InvoiceClient.fromJson(json['client'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$InvoiceListItemImplToJson(
  _$InvoiceListItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'status': instance.status,
  'series': instance.series,
  'number': instance.number,
  'issuedAt': instance.issuedAt,
  'total': instance.total,
  'invoiceType': instance.invoiceType,
  'taxKind': instance.taxKind,
  'client': instance.client,
};

_$InvoiceClientImpl _$$InvoiceClientImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceClientImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      taxId: json['taxId'] as String,
    );

Map<String, dynamic> _$$InvoiceClientImplToJson(_$InvoiceClientImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'taxId': instance.taxId,
    };

_$InvoiceDetailImpl _$$InvoiceDetailImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceDetailImpl(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      status: json['status'] as String,
      series: json['series'] as String,
      number: (json['number'] as num).toInt(),
      issuedAt: json['issuedAt'] as String,
      total: (json['total'] as num).toDouble(),
      invoiceType: json['invoiceType'] as String,
      taxKind: json['taxKind'] as String?,
      publicNotes: json['publicNotes'] as String?,
      invoiceNote: json['invoiceNote'] as String?,
      client: json['client'] == null
          ? null
          : InvoiceDetailClient.fromJson(
              json['client'] as Map<String, dynamic>,
            ),
      createdBy: json['createdBy'] == null
          ? null
          : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
      lines: (json['lines'] as List<dynamic>)
          .map((e) => InvoiceLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      payments: (json['payments'] as List<dynamic>)
          .map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$InvoiceDetailImplToJson(_$InvoiceDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'status': instance.status,
      'series': instance.series,
      'number': instance.number,
      'issuedAt': instance.issuedAt,
      'total': instance.total,
      'invoiceType': instance.invoiceType,
      'taxKind': instance.taxKind,
      'publicNotes': instance.publicNotes,
      'invoiceNote': instance.invoiceNote,
      'client': instance.client,
      'createdBy': instance.createdBy,
      'lines': instance.lines,
      'payments': instance.payments,
    };

_$InvoiceDetailClientImpl _$$InvoiceDetailClientImplFromJson(
  Map<String, dynamic> json,
) => _$InvoiceDetailClientImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  taxId: json['taxId'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  city: json['city'] as String?,
);

Map<String, dynamic> _$$InvoiceDetailClientImplToJson(
  _$InvoiceDetailClientImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'taxId': instance.taxId,
  'email': instance.email,
  'phone': instance.phone,
  'address': instance.address,
  'city': instance.city,
};

_$CreatedByImpl _$$CreatedByImplFromJson(Map<String, dynamic> json) =>
    _$CreatedByImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$CreatedByImplToJson(_$CreatedByImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$InvoiceLineImpl _$$InvoiceLineImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceLineImpl(
      id: (json['id'] as num).toInt(),
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      discountRate: (json['discountRate'] as num).toDouble(),
      taxRate: (json['taxRate'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$InvoiceLineImplToJson(_$InvoiceLineImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'discountRate': instance.discountRate,
      'taxRate': instance.taxRate,
      'taxAmount': instance.taxAmount,
      'total': instance.total,
    };
