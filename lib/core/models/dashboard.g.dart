// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardSummaryImpl _$$DashboardSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardSummaryImpl(
  invoicesThisMonth: (json['invoicesThisMonth'] as num).toInt(),
  totalBilled: (json['totalBilled'] as num).toDouble(),
  totalCollected: (json['totalCollected'] as num).toDouble(),
  totalPending: (json['totalPending'] as num).toDouble(),
  recentInvoices: (json['recentInvoices'] as List<dynamic>)
      .map((e) => DashboardInvoice.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$DashboardSummaryImplToJson(
  _$DashboardSummaryImpl instance,
) => <String, dynamic>{
  'invoicesThisMonth': instance.invoicesThisMonth,
  'totalBilled': instance.totalBilled,
  'totalCollected': instance.totalCollected,
  'totalPending': instance.totalPending,
  'recentInvoices': instance.recentInvoices,
};

_$DashboardInvoiceImpl _$$DashboardInvoiceImplFromJson(
  Map<String, dynamic> json,
) => _$DashboardInvoiceImpl(
  id: (json['id'] as num).toInt(),
  series: json['series'] as String,
  number: (json['number'] as num).toInt(),
  status: json['status'] as String,
  total: (json['total'] as num).toDouble(),
  clientName: json['clientName'] as String?,
);

Map<String, dynamic> _$$DashboardInvoiceImplToJson(
  _$DashboardInvoiceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'series': instance.series,
  'number': instance.number,
  'status': instance.status,
  'total': instance.total,
  'clientName': instance.clientName,
};
