// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CatalogProduct _$CatalogProductFromJson(Map<String, dynamic> json) {
  return _CatalogProduct.fromJson(json);
}

/// @nodoc
mixin _$CatalogProduct {
  int get id => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get stockQty => throw _privateConstructorUsedError;

  /// Serializes this CatalogProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogProductCopyWith<CatalogProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogProductCopyWith<$Res> {
  factory $CatalogProductCopyWith(
    CatalogProduct value,
    $Res Function(CatalogProduct) then,
  ) = _$CatalogProductCopyWithImpl<$Res, CatalogProduct>;
  @useResult
  $Res call({
    int id,
    String sku,
    String name,
    String? description,
    double price,
    int stockQty,
  });
}

/// @nodoc
class _$CatalogProductCopyWithImpl<$Res, $Val extends CatalogProduct>
    implements $CatalogProductCopyWith<$Res> {
  _$CatalogProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sku = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? stockQty = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            sku: null == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            stockQty: null == stockQty
                ? _value.stockQty
                : stockQty // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CatalogProductImplCopyWith<$Res>
    implements $CatalogProductCopyWith<$Res> {
  factory _$$CatalogProductImplCopyWith(
    _$CatalogProductImpl value,
    $Res Function(_$CatalogProductImpl) then,
  ) = __$$CatalogProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String sku,
    String name,
    String? description,
    double price,
    int stockQty,
  });
}

/// @nodoc
class __$$CatalogProductImplCopyWithImpl<$Res>
    extends _$CatalogProductCopyWithImpl<$Res, _$CatalogProductImpl>
    implements _$$CatalogProductImplCopyWith<$Res> {
  __$$CatalogProductImplCopyWithImpl(
    _$CatalogProductImpl _value,
    $Res Function(_$CatalogProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sku = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? stockQty = null,
  }) {
    return _then(
      _$CatalogProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        sku: null == sku
            ? _value.sku
            : sku // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        stockQty: null == stockQty
            ? _value.stockQty
            : stockQty // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogProductImpl implements _CatalogProduct {
  const _$CatalogProductImpl({
    required this.id,
    required this.sku,
    required this.name,
    this.description,
    required this.price,
    this.stockQty = 0,
  });

  factory _$CatalogProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogProductImplFromJson(json);

  @override
  final int id;
  @override
  final String sku;
  @override
  final String name;
  @override
  final String? description;
  @override
  final double price;
  @override
  @JsonKey()
  final int stockQty;

  @override
  String toString() {
    return 'CatalogProduct(id: $id, sku: $sku, name: $name, description: $description, price: $price, stockQty: $stockQty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.stockQty, stockQty) ||
                other.stockQty == stockQty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, sku, name, description, price, stockQty);

  /// Create a copy of CatalogProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogProductImplCopyWith<_$CatalogProductImpl> get copyWith =>
      __$$CatalogProductImplCopyWithImpl<_$CatalogProductImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogProductImplToJson(this);
  }
}

abstract class _CatalogProduct implements CatalogProduct {
  const factory _CatalogProduct({
    required final int id,
    required final String sku,
    required final String name,
    final String? description,
    required final double price,
    final int stockQty,
  }) = _$CatalogProductImpl;

  factory _CatalogProduct.fromJson(Map<String, dynamic> json) =
      _$CatalogProductImpl.fromJson;

  @override
  int get id;
  @override
  String get sku;
  @override
  String get name;
  @override
  String? get description;
  @override
  double get price;
  @override
  int get stockQty;

  /// Create a copy of CatalogProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogProductImplCopyWith<_$CatalogProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CatalogService _$CatalogServiceFromJson(Map<String, dynamic> json) {
  return _CatalogService.fromJson(json);
}

/// @nodoc
mixin _$CatalogService {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this CatalogService to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatalogService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogServiceCopyWith<CatalogService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogServiceCopyWith<$Res> {
  factory $CatalogServiceCopyWith(
    CatalogService value,
    $Res Function(CatalogService) then,
  ) = _$CatalogServiceCopyWithImpl<$Res, CatalogService>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    double unitPrice,
    double taxRate,
    bool active,
  });
}

/// @nodoc
class _$CatalogServiceCopyWithImpl<$Res, $Val extends CatalogService>
    implements $CatalogServiceCopyWith<$Res> {
  _$CatalogServiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? unitPrice = null,
    Object? taxRate = null,
    Object? active = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            taxRate: null == taxRate
                ? _value.taxRate
                : taxRate // ignore: cast_nullable_to_non_nullable
                      as double,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CatalogServiceImplCopyWith<$Res>
    implements $CatalogServiceCopyWith<$Res> {
  factory _$$CatalogServiceImplCopyWith(
    _$CatalogServiceImpl value,
    $Res Function(_$CatalogServiceImpl) then,
  ) = __$$CatalogServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    double unitPrice,
    double taxRate,
    bool active,
  });
}

/// @nodoc
class __$$CatalogServiceImplCopyWithImpl<$Res>
    extends _$CatalogServiceCopyWithImpl<$Res, _$CatalogServiceImpl>
    implements _$$CatalogServiceImplCopyWith<$Res> {
  __$$CatalogServiceImplCopyWithImpl(
    _$CatalogServiceImpl _value,
    $Res Function(_$CatalogServiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CatalogService
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? unitPrice = null,
    Object? taxRate = null,
    Object? active = null,
  }) {
    return _then(
      _$CatalogServiceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        taxRate: null == taxRate
            ? _value.taxRate
            : taxRate // ignore: cast_nullable_to_non_nullable
                  as double,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogServiceImpl implements _CatalogService {
  const _$CatalogServiceImpl({
    required this.id,
    required this.name,
    this.description,
    required this.unitPrice,
    this.taxRate = 21.0,
    this.active = true,
  });

  factory _$CatalogServiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogServiceImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final double unitPrice;
  @override
  @JsonKey()
  final double taxRate;
  @override
  @JsonKey()
  final bool active;

  @override
  String toString() {
    return 'CatalogService(id: $id, name: $name, description: $description, unitPrice: $unitPrice, taxRate: $taxRate, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogServiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    unitPrice,
    taxRate,
    active,
  );

  /// Create a copy of CatalogService
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogServiceImplCopyWith<_$CatalogServiceImpl> get copyWith =>
      __$$CatalogServiceImplCopyWithImpl<_$CatalogServiceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogServiceImplToJson(this);
  }
}

abstract class _CatalogService implements CatalogService {
  const factory _CatalogService({
    required final int id,
    required final String name,
    final String? description,
    required final double unitPrice,
    final double taxRate,
    final bool active,
  }) = _$CatalogServiceImpl;

  factory _CatalogService.fromJson(Map<String, dynamic> json) =
      _$CatalogServiceImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  double get unitPrice;
  @override
  double get taxRate;
  @override
  bool get active;

  /// Create a copy of CatalogService
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogServiceImplCopyWith<_$CatalogServiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InventoryMovement _$InventoryMovementFromJson(Map<String, dynamic> json) {
  return _InventoryMovement.fromJson(json);
}

/// @nodoc
mixin _$InventoryMovement {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  DateTime get occurredAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this InventoryMovement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryMovementCopyWith<InventoryMovement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryMovementCopyWith<$Res> {
  factory $InventoryMovementCopyWith(
    InventoryMovement value,
    $Res Function(InventoryMovement) then,
  ) = _$InventoryMovementCopyWithImpl<$Res, InventoryMovement>;
  @useResult
  $Res call({
    int id,
    String type,
    int quantity,
    DateTime occurredAt,
    String? notes,
  });
}

/// @nodoc
class _$InventoryMovementCopyWithImpl<$Res, $Val extends InventoryMovement>
    implements $InventoryMovementCopyWith<$Res> {
  _$InventoryMovementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? quantity = null,
    Object? occurredAt = null,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            occurredAt: null == occurredAt
                ? _value.occurredAt
                : occurredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryMovementImplCopyWith<$Res>
    implements $InventoryMovementCopyWith<$Res> {
  factory _$$InventoryMovementImplCopyWith(
    _$InventoryMovementImpl value,
    $Res Function(_$InventoryMovementImpl) then,
  ) = __$$InventoryMovementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String type,
    int quantity,
    DateTime occurredAt,
    String? notes,
  });
}

/// @nodoc
class __$$InventoryMovementImplCopyWithImpl<$Res>
    extends _$InventoryMovementCopyWithImpl<$Res, _$InventoryMovementImpl>
    implements _$$InventoryMovementImplCopyWith<$Res> {
  __$$InventoryMovementImplCopyWithImpl(
    _$InventoryMovementImpl _value,
    $Res Function(_$InventoryMovementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? quantity = null,
    Object? occurredAt = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$InventoryMovementImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        occurredAt: null == occurredAt
            ? _value.occurredAt
            : occurredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryMovementImpl implements _InventoryMovement {
  const _$InventoryMovementImpl({
    required this.id,
    required this.type,
    required this.quantity,
    required this.occurredAt,
    this.notes,
  });

  factory _$InventoryMovementImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryMovementImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final int quantity;
  @override
  final DateTime occurredAt;
  @override
  final String? notes;

  @override
  String toString() {
    return 'InventoryMovement(id: $id, type: $type, quantity: $quantity, occurredAt: $occurredAt, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryMovementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, quantity, occurredAt, notes);

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryMovementImplCopyWith<_$InventoryMovementImpl> get copyWith =>
      __$$InventoryMovementImplCopyWithImpl<_$InventoryMovementImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryMovementImplToJson(this);
  }
}

abstract class _InventoryMovement implements InventoryMovement {
  const factory _InventoryMovement({
    required final int id,
    required final String type,
    required final int quantity,
    required final DateTime occurredAt,
    final String? notes,
  }) = _$InventoryMovementImpl;

  factory _InventoryMovement.fromJson(Map<String, dynamic> json) =
      _$InventoryMovementImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  int get quantity;
  @override
  DateTime get occurredAt;
  @override
  String? get notes;

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryMovementImplCopyWith<_$InventoryMovementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
