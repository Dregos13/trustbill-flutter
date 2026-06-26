import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog.freezed.dart';
part 'catalog.g.dart';

// ── Product ───────────────────────────────────────────────────────────────────

@freezed
abstract class CatalogProduct with _$CatalogProduct {
  const factory CatalogProduct({
    required int id,
    required String sku,
    required String name,
    String? description,
    required double price,
    @Default(0) int stockQty,
  }) = _CatalogProduct;

  factory CatalogProduct.fromJson(Map<String, dynamic> json) =>
      _$CatalogProductFromJson(json);
}

// ── Service ───────────────────────────────────────────────────────────────────

@freezed
abstract class CatalogService with _$CatalogService {
  const factory CatalogService({
    required int id,
    required String name,
    String? description,
    required double unitPrice,
    @Default(21.0) double taxRate,
    @Default(true) bool active,
  }) = _CatalogService;

  factory CatalogService.fromJson(Map<String, dynamic> json) =>
      _$CatalogServiceFromJson(json);
}

// ── Inventory movement ────────────────────────────────────────────────────────

@freezed
abstract class InventoryMovement with _$InventoryMovement {
  const factory InventoryMovement({
    required int id,
    required String type,
    required int quantity,
    required DateTime occurredAt,
    String? notes,
  }) = _InventoryMovement;

  factory InventoryMovement.fromJson(Map<String, dynamic> json) =>
      _$InventoryMovementFromJson(json);
}
