// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvoiceListItem _$InvoiceListItemFromJson(Map<String, dynamic> json) =>
    _InvoiceListItem(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      status: json['status'] as String,
      series: json['series'] as String,
      number: (json['number'] as num).toInt(),
      issuedAt: json['issuedAt'] as String,
      total: toDouble(json['total']),
      invoiceType: json['invoiceType'] as String,
      taxKind: json['taxKind'] as String?,
      client: json['client'] == null
          ? null
          : InvoiceClient.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceListItemToJson(_InvoiceListItem instance) =>
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
      'client': instance.client,
    };

_InvoiceClient _$InvoiceClientFromJson(Map<String, dynamic> json) =>
    _InvoiceClient(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      taxId: json['taxId'] as String,
    );

Map<String, dynamic> _$InvoiceClientToJson(_InvoiceClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'taxId': instance.taxId,
    };

_InvoiceDetail _$InvoiceDetailFromJson(Map<String, dynamic> json) =>
    _InvoiceDetail(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      status: json['status'] as String,
      series: json['series'] as String,
      number: (json['number'] as num).toInt(),
      issuedAt: json['issuedAt'] as String,
      total: toDouble(json['total']),
      invoiceType: json['invoiceType'] as String,
      taxKind: json['taxKind'] as String?,
      internalNotes: json['internalNotes'] as String?,
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

Map<String, dynamic> _$InvoiceDetailToJson(_InvoiceDetail instance) =>
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
      'internalNotes': instance.internalNotes,
      'publicNotes': instance.publicNotes,
      'invoiceNote': instance.invoiceNote,
      'client': instance.client,
      'createdBy': instance.createdBy,
      'lines': instance.lines,
      'payments': instance.payments,
    };

_InvoiceDetailClient _$InvoiceDetailClientFromJson(Map<String, dynamic> json) =>
    _InvoiceDetailClient(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      taxId: json['taxId'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$InvoiceDetailClientToJson(
  _InvoiceDetailClient instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'taxId': instance.taxId,
  'email': instance.email,
  'phone': instance.phone,
  'address': instance.address,
  'city': instance.city,
};

_CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) =>
    _CreatedBy(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$CreatedByToJson(_CreatedBy instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_InvoiceLine _$InvoiceLineFromJson(Map<String, dynamic> json) => _InvoiceLine(
  id: (json['id'] as num).toInt(),
  description: json['description'] as String,
  quantity: toDouble(json['quantity']),
  unitPrice: toDouble(json['unitPrice']),
  discountRate: toDouble(json['discountRate']),
  taxRate: toDouble(json['taxRate']),
  taxAmount: toDouble(json['taxAmount']),
  total: toDouble(json['total']),
);

Map<String, dynamic> _$InvoiceLineToJson(_InvoiceLine instance) =>
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
