// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CatalogProductImpl _$$CatalogProductImplFromJson(Map<String, dynamic> json) =>
    _$CatalogProductImpl(
      id: (json['id'] as num).toInt(),
      sku: json['sku'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      stockQty: (json['stockQty'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CatalogProductImplToJson(
  _$CatalogProductImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sku': instance.sku,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'stockQty': instance.stockQty,
};

_$CatalogServiceImpl _$$CatalogServiceImplFromJson(Map<String, dynamic> json) =>
    _$CatalogServiceImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 21.0,
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$$CatalogServiceImplToJson(
  _$CatalogServiceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'unitPrice': instance.unitPrice,
  'taxRate': instance.taxRate,
  'active': instance.active,
};

_$InventoryMovementImpl _$$InventoryMovementImplFromJson(
  Map<String, dynamic> json,
) => _$InventoryMovementImpl(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
  quantity: (json['quantity'] as num).toInt(),
  occurredAt: DateTime.parse(json['occurredAt'] as String),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$InventoryMovementImplToJson(
  _$InventoryMovementImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'quantity': instance.quantity,
  'occurredAt': instance.occurredAt.toIso8601String(),
  'notes': instance.notes,
};
