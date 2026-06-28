// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SaleListItem _$SaleListItemFromJson(Map<String, dynamic> json) =>
    _SaleListItem(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      status: json['status'] as String,
      regime: json['regime'] as String?,
      budgetId: (json['budgetId'] as num?)?.toInt(),
      totalPlanned: toDouble(json['totalPlanned']),
      totalInvoiced: toDouble(json['totalInvoiced']),
      totalPending: toDouble(json['totalPending']),
      createdAt: json['createdAt'] as String,
      client: json['client'] == null
          ? null
          : SaleParty.fromJson(json['client'] as Map<String, dynamic>),
      vendor: json['vendor'] == null
          ? null
          : SaleParty.fromJson(json['vendor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SaleListItemToJson(_SaleListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'status': instance.status,
      'regime': instance.regime,
      'budgetId': instance.budgetId,
      'totalPlanned': instance.totalPlanned,
      'totalInvoiced': instance.totalInvoiced,
      'totalPending': instance.totalPending,
      'createdAt': instance.createdAt,
      'client': instance.client,
      'vendor': instance.vendor,
    };

_SaleParty _$SalePartyFromJson(Map<String, dynamic> json) => _SaleParty(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  taxId: json['taxId'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$SalePartyToJson(_SaleParty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'taxId': instance.taxId,
      'email': instance.email,
    };

_AvailableBudget _$AvailableBudgetFromJson(Map<String, dynamic> json) =>
    _AvailableBudget(
      id: (json['id'] as num).toInt(),
      series: json['series'] as String,
      number: (json['number'] as num).toInt(),
      issuedAt: json['issuedAt'] as String,
      total: toDouble(json['total']),
      taxKind: json['taxKind'] as String?,
      quoteStatus: json['quoteStatus'] as String?,
      client: json['client'] == null
          ? null
          : SaleParty.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AvailableBudgetToJson(_AvailableBudget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'series': instance.series,
      'number': instance.number,
      'issuedAt': instance.issuedAt,
      'total': instance.total,
      'taxKind': instance.taxKind,
      'quoteStatus': instance.quoteStatus,
      'client': instance.client,
    };

_SaleDetail _$SaleDetailFromJson(Map<String, dynamic> json) => _SaleDetail(
  id: (json['id'] as num).toInt(),
  code: json['code'] as String,
  status: json['status'] as String,
  regime: json['regime'] as String?,
  taxKind: json['taxKind'] as String?,
  budgetId: (json['budgetId'] as num?)?.toInt(),
  internalNotes: json['internalNotes'] as String?,
  totalPlanned: toDouble(json['totalPlanned']),
  totalInvoiced: toDouble(json['totalInvoiced']),
  totalPending: toDouble(json['totalPending']),
  client: json['client'] == null
      ? null
      : SaleParty.fromJson(json['client'] as Map<String, dynamic>),
  vendor: json['vendor'] == null
      ? null
      : SaleParty.fromJson(json['vendor'] as Map<String, dynamic>),
  budget: json['budget'] == null
      ? null
      : SaleBudgetRef.fromJson(json['budget'] as Map<String, dynamic>),
  lines:
      (json['lines'] as List<dynamic>?)
          ?.map((e) => SaleDetailLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  installments:
      (json['installments'] as List<dynamic>?)
          ?.map((e) => SaleInstallment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  invoices:
      (json['invoices'] as List<dynamic>?)
          ?.map((e) => SaleInvoiceRef.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$SaleDetailToJson(_SaleDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'status': instance.status,
      'regime': instance.regime,
      'taxKind': instance.taxKind,
      'budgetId': instance.budgetId,
      'internalNotes': instance.internalNotes,
      'totalPlanned': instance.totalPlanned,
      'totalInvoiced': instance.totalInvoiced,
      'totalPending': instance.totalPending,
      'client': instance.client,
      'vendor': instance.vendor,
      'budget': instance.budget,
      'lines': instance.lines,
      'installments': instance.installments,
      'invoices': instance.invoices,
    };

_SaleBudgetRef _$SaleBudgetRefFromJson(Map<String, dynamic> json) =>
    _SaleBudgetRef(
      id: (json['id'] as num).toInt(),
      series: json['series'] as String,
      number: (json['number'] as num).toInt(),
      status: json['status'] as String,
      issuedAt: json['issuedAt'] as String,
      total: toDouble(json['total']),
      taxKind: json['taxKind'] as String?,
    );

Map<String, dynamic> _$SaleBudgetRefToJson(_SaleBudgetRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'series': instance.series,
      'number': instance.number,
      'status': instance.status,
      'issuedAt': instance.issuedAt,
      'total': instance.total,
      'taxKind': instance.taxKind,
    };

_SaleDetailLine _$SaleDetailLineFromJson(Map<String, dynamic> json) =>
    _SaleDetailLine(
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
      invoicedQuantity: json['invoicedQuantity'] == null
          ? 0
          : toDouble(json['invoicedQuantity']),
      invoicedTotal: json['invoicedTotal'] == null
          ? 0
          : toDouble(json['invoicedTotal']),
      pendingQuantity: json['pendingQuantity'] == null
          ? 0
          : toDouble(json['pendingQuantity']),
      pendingTotal: json['pendingTotal'] == null
          ? 0
          : toDouble(json['pendingTotal']),
    );

Map<String, dynamic> _$SaleDetailLineToJson(_SaleDetailLine instance) =>
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
      'invoicedQuantity': instance.invoicedQuantity,
      'invoicedTotal': instance.invoicedTotal,
      'pendingQuantity': instance.pendingQuantity,
      'pendingTotal': instance.pendingTotal,
    };

_SaleInstallment _$SaleInstallmentFromJson(Map<String, dynamic> json) =>
    _SaleInstallment(
      id: (json['id'] as num).toInt(),
      index: (json['index'] as num).toInt(),
      dueDate: json['dueDate'] as String?,
      percentage: toDoubleN(json['percentage']),
      plannedAmount: toDoubleN(json['plannedAmount']),
    );

Map<String, dynamic> _$SaleInstallmentToJson(_SaleInstallment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'dueDate': instance.dueDate,
      'percentage': instance.percentage,
      'plannedAmount': instance.plannedAmount,
    };

_SaleInvoiceRef _$SaleInvoiceRefFromJson(Map<String, dynamic> json) =>
    _SaleInvoiceRef(
      id: (json['id'] as num).toInt(),
      series: json['series'] as String,
      number: (json['number'] as num).toInt(),
      status: json['status'] as String,
      issuedAt: json['issuedAt'] as String,
      total: toDouble(json['total']),
      isFinal: json['isFinal'] as bool? ?? false,
    );

Map<String, dynamic> _$SaleInvoiceRefToJson(_SaleInvoiceRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'series': instance.series,
      'number': instance.number,
      'status': instance.status,
      'issuedAt': instance.issuedAt,
      'total': instance.total,
      'isFinal': instance.isFinal,
    };
