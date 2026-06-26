// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogProduct {

 int get id; String get sku; String get name; String? get description; double get price; int get stockQty;
/// Create a copy of CatalogProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogProductCopyWith<CatalogProduct> get copyWith => _$CatalogProductCopyWithImpl<CatalogProduct>(this as CatalogProduct, _$identity);

  /// Serializes this CatalogProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.stockQty, stockQty) || other.stockQty == stockQty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sku,name,description,price,stockQty);

@override
String toString() {
  return 'CatalogProduct(id: $id, sku: $sku, name: $name, description: $description, price: $price, stockQty: $stockQty)';
}


}

/// @nodoc
abstract mixin class $CatalogProductCopyWith<$Res>  {
  factory $CatalogProductCopyWith(CatalogProduct value, $Res Function(CatalogProduct) _then) = _$CatalogProductCopyWithImpl;
@useResult
$Res call({
 int id, String sku, String name, String? description, double price, int stockQty
});




}
/// @nodoc
class _$CatalogProductCopyWithImpl<$Res>
    implements $CatalogProductCopyWith<$Res> {
  _$CatalogProductCopyWithImpl(this._self, this._then);

  final CatalogProduct _self;
  final $Res Function(CatalogProduct) _then;

/// Create a copy of CatalogProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sku = null,Object? name = null,Object? description = freezed,Object? price = null,Object? stockQty = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,stockQty: null == stockQty ? _self.stockQty : stockQty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogProduct].
extension CatalogProductPatterns on CatalogProduct {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogProduct() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogProduct value)  $default,){
final _that = this;
switch (_that) {
case _CatalogProduct():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogProduct value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogProduct() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String sku,  String name,  String? description,  double price,  int stockQty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogProduct() when $default != null:
return $default(_that.id,_that.sku,_that.name,_that.description,_that.price,_that.stockQty);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String sku,  String name,  String? description,  double price,  int stockQty)  $default,) {final _that = this;
switch (_that) {
case _CatalogProduct():
return $default(_that.id,_that.sku,_that.name,_that.description,_that.price,_that.stockQty);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String sku,  String name,  String? description,  double price,  int stockQty)?  $default,) {final _that = this;
switch (_that) {
case _CatalogProduct() when $default != null:
return $default(_that.id,_that.sku,_that.name,_that.description,_that.price,_that.stockQty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogProduct implements CatalogProduct {
  const _CatalogProduct({required this.id, required this.sku, required this.name, this.description, required this.price, this.stockQty = 0});
  factory _CatalogProduct.fromJson(Map<String, dynamic> json) => _$CatalogProductFromJson(json);

@override final  int id;
@override final  String sku;
@override final  String name;
@override final  String? description;
@override final  double price;
@override@JsonKey() final  int stockQty;

/// Create a copy of CatalogProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogProductCopyWith<_CatalogProduct> get copyWith => __$CatalogProductCopyWithImpl<_CatalogProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.stockQty, stockQty) || other.stockQty == stockQty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sku,name,description,price,stockQty);

@override
String toString() {
  return 'CatalogProduct(id: $id, sku: $sku, name: $name, description: $description, price: $price, stockQty: $stockQty)';
}


}

/// @nodoc
abstract mixin class _$CatalogProductCopyWith<$Res> implements $CatalogProductCopyWith<$Res> {
  factory _$CatalogProductCopyWith(_CatalogProduct value, $Res Function(_CatalogProduct) _then) = __$CatalogProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String sku, String name, String? description, double price, int stockQty
});




}
/// @nodoc
class __$CatalogProductCopyWithImpl<$Res>
    implements _$CatalogProductCopyWith<$Res> {
  __$CatalogProductCopyWithImpl(this._self, this._then);

  final _CatalogProduct _self;
  final $Res Function(_CatalogProduct) _then;

/// Create a copy of CatalogProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sku = null,Object? name = null,Object? description = freezed,Object? price = null,Object? stockQty = null,}) {
  return _then(_CatalogProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,stockQty: null == stockQty ? _self.stockQty : stockQty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CatalogService {

 int get id; String get name; String? get description; double get unitPrice; double get taxRate; bool get active;
/// Create a copy of CatalogService
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogServiceCopyWith<CatalogService> get copyWith => _$CatalogServiceCopyWithImpl<CatalogService>(this as CatalogService, _$identity);

  /// Serializes this CatalogService to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,unitPrice,taxRate,active);

@override
String toString() {
  return 'CatalogService(id: $id, name: $name, description: $description, unitPrice: $unitPrice, taxRate: $taxRate, active: $active)';
}


}

/// @nodoc
abstract mixin class $CatalogServiceCopyWith<$Res>  {
  factory $CatalogServiceCopyWith(CatalogService value, $Res Function(CatalogService) _then) = _$CatalogServiceCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, double unitPrice, double taxRate, bool active
});




}
/// @nodoc
class _$CatalogServiceCopyWithImpl<$Res>
    implements $CatalogServiceCopyWith<$Res> {
  _$CatalogServiceCopyWithImpl(this._self, this._then);

  final CatalogService _self;
  final $Res Function(CatalogService) _then;

/// Create a copy of CatalogService
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? unitPrice = null,Object? taxRate = null,Object? active = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogService].
extension CatalogServicePatterns on CatalogService {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogService value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogService() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogService value)  $default,){
final _that = this;
switch (_that) {
case _CatalogService():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogService value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogService() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  double unitPrice,  double taxRate,  bool active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogService() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.unitPrice,_that.taxRate,_that.active);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  double unitPrice,  double taxRate,  bool active)  $default,) {final _that = this;
switch (_that) {
case _CatalogService():
return $default(_that.id,_that.name,_that.description,_that.unitPrice,_that.taxRate,_that.active);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  double unitPrice,  double taxRate,  bool active)?  $default,) {final _that = this;
switch (_that) {
case _CatalogService() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.unitPrice,_that.taxRate,_that.active);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogService implements CatalogService {
  const _CatalogService({required this.id, required this.name, this.description, required this.unitPrice, this.taxRate = 21.0, this.active = true});
  factory _CatalogService.fromJson(Map<String, dynamic> json) => _$CatalogServiceFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override final  double unitPrice;
@override@JsonKey() final  double taxRate;
@override@JsonKey() final  bool active;

/// Create a copy of CatalogService
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogServiceCopyWith<_CatalogService> get copyWith => __$CatalogServiceCopyWithImpl<_CatalogService>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogServiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogService&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,unitPrice,taxRate,active);

@override
String toString() {
  return 'CatalogService(id: $id, name: $name, description: $description, unitPrice: $unitPrice, taxRate: $taxRate, active: $active)';
}


}

/// @nodoc
abstract mixin class _$CatalogServiceCopyWith<$Res> implements $CatalogServiceCopyWith<$Res> {
  factory _$CatalogServiceCopyWith(_CatalogService value, $Res Function(_CatalogService) _then) = __$CatalogServiceCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, double unitPrice, double taxRate, bool active
});




}
/// @nodoc
class __$CatalogServiceCopyWithImpl<$Res>
    implements _$CatalogServiceCopyWith<$Res> {
  __$CatalogServiceCopyWithImpl(this._self, this._then);

  final _CatalogService _self;
  final $Res Function(_CatalogService) _then;

/// Create a copy of CatalogService
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? unitPrice = null,Object? taxRate = null,Object? active = null,}) {
  return _then(_CatalogService(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$InventoryMovement {

 int get id; String get type; int get quantity; DateTime get occurredAt; String? get notes;
/// Create a copy of InventoryMovement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryMovementCopyWith<InventoryMovement> get copyWith => _$InventoryMovementCopyWithImpl<InventoryMovement>(this as InventoryMovement, _$identity);

  /// Serializes this InventoryMovement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryMovement&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,quantity,occurredAt,notes);

@override
String toString() {
  return 'InventoryMovement(id: $id, type: $type, quantity: $quantity, occurredAt: $occurredAt, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $InventoryMovementCopyWith<$Res>  {
  factory $InventoryMovementCopyWith(InventoryMovement value, $Res Function(InventoryMovement) _then) = _$InventoryMovementCopyWithImpl;
@useResult
$Res call({
 int id, String type, int quantity, DateTime occurredAt, String? notes
});




}
/// @nodoc
class _$InventoryMovementCopyWithImpl<$Res>
    implements $InventoryMovementCopyWith<$Res> {
  _$InventoryMovementCopyWithImpl(this._self, this._then);

  final InventoryMovement _self;
  final $Res Function(InventoryMovement) _then;

/// Create a copy of InventoryMovement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? quantity = null,Object? occurredAt = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InventoryMovement].
extension InventoryMovementPatterns on InventoryMovement {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InventoryMovement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryMovement() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InventoryMovement value)  $default,){
final _that = this;
switch (_that) {
case _InventoryMovement():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InventoryMovement value)?  $default,){
final _that = this;
switch (_that) {
case _InventoryMovement() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  int quantity,  DateTime occurredAt,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryMovement() when $default != null:
return $default(_that.id,_that.type,_that.quantity,_that.occurredAt,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  int quantity,  DateTime occurredAt,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _InventoryMovement():
return $default(_that.id,_that.type,_that.quantity,_that.occurredAt,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  int quantity,  DateTime occurredAt,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _InventoryMovement() when $default != null:
return $default(_that.id,_that.type,_that.quantity,_that.occurredAt,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InventoryMovement implements InventoryMovement {
  const _InventoryMovement({required this.id, required this.type, required this.quantity, required this.occurredAt, this.notes});
  factory _InventoryMovement.fromJson(Map<String, dynamic> json) => _$InventoryMovementFromJson(json);

@override final  int id;
@override final  String type;
@override final  int quantity;
@override final  DateTime occurredAt;
@override final  String? notes;

/// Create a copy of InventoryMovement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryMovementCopyWith<_InventoryMovement> get copyWith => __$InventoryMovementCopyWithImpl<_InventoryMovement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InventoryMovementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryMovement&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,quantity,occurredAt,notes);

@override
String toString() {
  return 'InventoryMovement(id: $id, type: $type, quantity: $quantity, occurredAt: $occurredAt, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$InventoryMovementCopyWith<$Res> implements $InventoryMovementCopyWith<$Res> {
  factory _$InventoryMovementCopyWith(_InventoryMovement value, $Res Function(_InventoryMovement) _then) = __$InventoryMovementCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, int quantity, DateTime occurredAt, String? notes
});




}
/// @nodoc
class __$InventoryMovementCopyWithImpl<$Res>
    implements _$InventoryMovementCopyWith<$Res> {
  __$InventoryMovementCopyWithImpl(this._self, this._then);

  final _InventoryMovement _self;
  final $Res Function(_InventoryMovement) _then;

/// Create a copy of InventoryMovement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? quantity = null,Object? occurredAt = null,Object? notes = freezed,}) {
  return _then(_InventoryMovement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
