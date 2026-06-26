// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogProduct _$CatalogProductFromJson(Map<String, dynamic> json) =>
    _CatalogProduct(
      id: (json['id'] as num).toInt(),
      sku: json['sku'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      stockQty: (json['stockQty'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CatalogProductToJson(_CatalogProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'stockQty': instance.stockQty,
    };

_CatalogService _$CatalogServiceFromJson(Map<String, dynamic> json) =>
    _CatalogService(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 21.0,
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$CatalogServiceToJson(_CatalogService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'unitPrice': instance.unitPrice,
      'taxRate': instance.taxRate,
      'active': instance.active,
    };

_InventoryMovement _$InventoryMovementFromJson(Map<String, dynamic> json) =>
    _InventoryMovement(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      quantity: (json['quantity'] as num).toInt(),
      occurredAt: DateTime.parse(json['occurredAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$InventoryMovementToJson(_InventoryMovement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'quantity': instance.quantity,
      'occurredAt': instance.occurredAt.toIso8601String(),
      'notes': instance.notes,
    };
