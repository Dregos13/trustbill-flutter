// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SaleListItem {

 int get id; String get code; String get status; String? get regime; int? get budgetId;@JsonKey(fromJson: toDouble) double get totalPlanned;@JsonKey(fromJson: toDouble) double get totalInvoiced;@JsonKey(fromJson: toDouble) double get totalPending; String get createdAt; SaleParty? get client; SaleParty? get vendor;
/// Create a copy of SaleListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleListItemCopyWith<SaleListItem> get copyWith => _$SaleListItemCopyWithImpl<SaleListItem>(this as SaleListItem, _$identity);

  /// Serializes this SaleListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.regime, regime) || other.regime == regime)&&(identical(other.budgetId, budgetId) || other.budgetId == budgetId)&&(identical(other.totalPlanned, totalPlanned) || other.totalPlanned == totalPlanned)&&(identical(other.totalInvoiced, totalInvoiced) || other.totalInvoiced == totalInvoiced)&&(identical(other.totalPending, totalPending) || other.totalPending == totalPending)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.client, client) || other.client == client)&&(identical(other.vendor, vendor) || other.vendor == vendor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,status,regime,budgetId,totalPlanned,totalInvoiced,totalPending,createdAt,client,vendor);

@override
String toString() {
  return 'SaleListItem(id: $id, code: $code, status: $status, regime: $regime, budgetId: $budgetId, totalPlanned: $totalPlanned, totalInvoiced: $totalInvoiced, totalPending: $totalPending, createdAt: $createdAt, client: $client, vendor: $vendor)';
}


}

/// @nodoc
abstract mixin class $SaleListItemCopyWith<$Res>  {
  factory $SaleListItemCopyWith(SaleListItem value, $Res Function(SaleListItem) _then) = _$SaleListItemCopyWithImpl;
@useResult
$Res call({
 int id, String code, String status, String? regime, int? budgetId,@JsonKey(fromJson: toDouble) double totalPlanned,@JsonKey(fromJson: toDouble) double totalInvoiced,@JsonKey(fromJson: toDouble) double totalPending, String createdAt, SaleParty? client, SaleParty? vendor
});


$SalePartyCopyWith<$Res>? get client;$SalePartyCopyWith<$Res>? get vendor;

}
/// @nodoc
class _$SaleListItemCopyWithImpl<$Res>
    implements $SaleListItemCopyWith<$Res> {
  _$SaleListItemCopyWithImpl(this._self, this._then);

  final SaleListItem _self;
  final $Res Function(SaleListItem) _then;

/// Create a copy of SaleListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? status = null,Object? regime = freezed,Object? budgetId = freezed,Object? totalPlanned = null,Object? totalInvoiced = null,Object? totalPending = null,Object? createdAt = null,Object? client = freezed,Object? vendor = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,regime: freezed == regime ? _self.regime : regime // ignore: cast_nullable_to_non_nullable
as String?,budgetId: freezed == budgetId ? _self.budgetId : budgetId // ignore: cast_nullable_to_non_nullable
as int?,totalPlanned: null == totalPlanned ? _self.totalPlanned : totalPlanned // ignore: cast_nullable_to_non_nullable
as double,totalInvoiced: null == totalInvoiced ? _self.totalInvoiced : totalInvoiced // ignore: cast_nullable_to_non_nullable
as double,totalPending: null == totalPending ? _self.totalPending : totalPending // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as SaleParty?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as SaleParty?,
  ));
}
/// Create a copy of SaleListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalePartyCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $SalePartyCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of SaleListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalePartyCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $SalePartyCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}


/// Adds pattern-matching-related methods to [SaleListItem].
extension SaleListItemPatterns on SaleListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleListItem value)  $default,){
final _that = this;
switch (_that) {
case _SaleListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleListItem value)?  $default,){
final _that = this;
switch (_that) {
case _SaleListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String status,  String? regime,  int? budgetId, @JsonKey(fromJson: toDouble)  double totalPlanned, @JsonKey(fromJson: toDouble)  double totalInvoiced, @JsonKey(fromJson: toDouble)  double totalPending,  String createdAt,  SaleParty? client,  SaleParty? vendor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleListItem() when $default != null:
return $default(_that.id,_that.code,_that.status,_that.regime,_that.budgetId,_that.totalPlanned,_that.totalInvoiced,_that.totalPending,_that.createdAt,_that.client,_that.vendor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String status,  String? regime,  int? budgetId, @JsonKey(fromJson: toDouble)  double totalPlanned, @JsonKey(fromJson: toDouble)  double totalInvoiced, @JsonKey(fromJson: toDouble)  double totalPending,  String createdAt,  SaleParty? client,  SaleParty? vendor)  $default,) {final _that = this;
switch (_that) {
case _SaleListItem():
return $default(_that.id,_that.code,_that.status,_that.regime,_that.budgetId,_that.totalPlanned,_that.totalInvoiced,_that.totalPending,_that.createdAt,_that.client,_that.vendor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String status,  String? regime,  int? budgetId, @JsonKey(fromJson: toDouble)  double totalPlanned, @JsonKey(fromJson: toDouble)  double totalInvoiced, @JsonKey(fromJson: toDouble)  double totalPending,  String createdAt,  SaleParty? client,  SaleParty? vendor)?  $default,) {final _that = this;
switch (_that) {
case _SaleListItem() when $default != null:
return $default(_that.id,_that.code,_that.status,_that.regime,_that.budgetId,_that.totalPlanned,_that.totalInvoiced,_that.totalPending,_that.createdAt,_that.client,_that.vendor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaleListItem implements SaleListItem {
  const _SaleListItem({required this.id, required this.code, required this.status, this.regime, this.budgetId, @JsonKey(fromJson: toDouble) required this.totalPlanned, @JsonKey(fromJson: toDouble) required this.totalInvoiced, @JsonKey(fromJson: toDouble) required this.totalPending, required this.createdAt, this.client, this.vendor});
  factory _SaleListItem.fromJson(Map<String, dynamic> json) => _$SaleListItemFromJson(json);

@override final  int id;
@override final  String code;
@override final  String status;
@override final  String? regime;
@override final  int? budgetId;
@override@JsonKey(fromJson: toDouble) final  double totalPlanned;
@override@JsonKey(fromJson: toDouble) final  double totalInvoiced;
@override@JsonKey(fromJson: toDouble) final  double totalPending;
@override final  String createdAt;
@override final  SaleParty? client;
@override final  SaleParty? vendor;

/// Create a copy of SaleListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleListItemCopyWith<_SaleListItem> get copyWith => __$SaleListItemCopyWithImpl<_SaleListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaleListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.regime, regime) || other.regime == regime)&&(identical(other.budgetId, budgetId) || other.budgetId == budgetId)&&(identical(other.totalPlanned, totalPlanned) || other.totalPlanned == totalPlanned)&&(identical(other.totalInvoiced, totalInvoiced) || other.totalInvoiced == totalInvoiced)&&(identical(other.totalPending, totalPending) || other.totalPending == totalPending)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.client, client) || other.client == client)&&(identical(other.vendor, vendor) || other.vendor == vendor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,status,regime,budgetId,totalPlanned,totalInvoiced,totalPending,createdAt,client,vendor);

@override
String toString() {
  return 'SaleListItem(id: $id, code: $code, status: $status, regime: $regime, budgetId: $budgetId, totalPlanned: $totalPlanned, totalInvoiced: $totalInvoiced, totalPending: $totalPending, createdAt: $createdAt, client: $client, vendor: $vendor)';
}


}

/// @nodoc
abstract mixin class _$SaleListItemCopyWith<$Res> implements $SaleListItemCopyWith<$Res> {
  factory _$SaleListItemCopyWith(_SaleListItem value, $Res Function(_SaleListItem) _then) = __$SaleListItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String status, String? regime, int? budgetId,@JsonKey(fromJson: toDouble) double totalPlanned,@JsonKey(fromJson: toDouble) double totalInvoiced,@JsonKey(fromJson: toDouble) double totalPending, String createdAt, SaleParty? client, SaleParty? vendor
});


@override $SalePartyCopyWith<$Res>? get client;@override $SalePartyCopyWith<$Res>? get vendor;

}
/// @nodoc
class __$SaleListItemCopyWithImpl<$Res>
    implements _$SaleListItemCopyWith<$Res> {
  __$SaleListItemCopyWithImpl(this._self, this._then);

  final _SaleListItem _self;
  final $Res Function(_SaleListItem) _then;

/// Create a copy of SaleListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? status = null,Object? regime = freezed,Object? budgetId = freezed,Object? totalPlanned = null,Object? totalInvoiced = null,Object? totalPending = null,Object? createdAt = null,Object? client = freezed,Object? vendor = freezed,}) {
  return _then(_SaleListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,regime: freezed == regime ? _self.regime : regime // ignore: cast_nullable_to_non_nullable
as String?,budgetId: freezed == budgetId ? _self.budgetId : budgetId // ignore: cast_nullable_to_non_nullable
as int?,totalPlanned: null == totalPlanned ? _self.totalPlanned : totalPlanned // ignore: cast_nullable_to_non_nullable
as double,totalInvoiced: null == totalInvoiced ? _self.totalInvoiced : totalInvoiced // ignore: cast_nullable_to_non_nullable
as double,totalPending: null == totalPending ? _self.totalPending : totalPending // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as SaleParty?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as SaleParty?,
  ));
}

/// Create a copy of SaleListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalePartyCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $SalePartyCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of SaleListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalePartyCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $SalePartyCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}
}


/// @nodoc
mixin _$SaleParty {

 int get id; String? get name; String? get taxId; String? get email;
/// Create a copy of SaleParty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalePartyCopyWith<SaleParty> get copyWith => _$SalePartyCopyWithImpl<SaleParty>(this as SaleParty, _$identity);

  /// Serializes this SaleParty to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleParty&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,taxId,email);

@override
String toString() {
  return 'SaleParty(id: $id, name: $name, taxId: $taxId, email: $email)';
}


}

/// @nodoc
abstract mixin class $SalePartyCopyWith<$Res>  {
  factory $SalePartyCopyWith(SaleParty value, $Res Function(SaleParty) _then) = _$SalePartyCopyWithImpl;
@useResult
$Res call({
 int id, String? name, String? taxId, String? email
});




}
/// @nodoc
class _$SalePartyCopyWithImpl<$Res>
    implements $SalePartyCopyWith<$Res> {
  _$SalePartyCopyWithImpl(this._self, this._then);

  final SaleParty _self;
  final $Res Function(SaleParty) _then;

/// Create a copy of SaleParty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? taxId = freezed,Object? email = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,taxId: freezed == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleParty].
extension SalePartyPatterns on SaleParty {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleParty value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleParty() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleParty value)  $default,){
final _that = this;
switch (_that) {
case _SaleParty():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleParty value)?  $default,){
final _that = this;
switch (_that) {
case _SaleParty() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? name,  String? taxId,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleParty() when $default != null:
return $default(_that.id,_that.name,_that.taxId,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? name,  String? taxId,  String? email)  $default,) {final _that = this;
switch (_that) {
case _SaleParty():
return $default(_that.id,_that.name,_that.taxId,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? name,  String? taxId,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _SaleParty() when $default != null:
return $default(_that.id,_that.name,_that.taxId,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaleParty implements SaleParty {
  const _SaleParty({required this.id, this.name, this.taxId, this.email});
  factory _SaleParty.fromJson(Map<String, dynamic> json) => _$SalePartyFromJson(json);

@override final  int id;
@override final  String? name;
@override final  String? taxId;
@override final  String? email;

/// Create a copy of SaleParty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalePartyCopyWith<_SaleParty> get copyWith => __$SalePartyCopyWithImpl<_SaleParty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SalePartyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleParty&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,taxId,email);

@override
String toString() {
  return 'SaleParty(id: $id, name: $name, taxId: $taxId, email: $email)';
}


}

/// @nodoc
abstract mixin class _$SalePartyCopyWith<$Res> implements $SalePartyCopyWith<$Res> {
  factory _$SalePartyCopyWith(_SaleParty value, $Res Function(_SaleParty) _then) = __$SalePartyCopyWithImpl;
@override @useResult
$Res call({
 int id, String? name, String? taxId, String? email
});




}
/// @nodoc
class __$SalePartyCopyWithImpl<$Res>
    implements _$SalePartyCopyWith<$Res> {
  __$SalePartyCopyWithImpl(this._self, this._then);

  final _SaleParty _self;
  final $Res Function(_SaleParty) _then;

/// Create a copy of SaleParty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? taxId = freezed,Object? email = freezed,}) {
  return _then(_SaleParty(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,taxId: freezed == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AvailableBudget {

 int get id; String get series; int get number; String get issuedAt;@JsonKey(fromJson: toDouble) double get total; String? get taxKind; String? get quoteStatus; SaleParty? get client;
/// Create a copy of AvailableBudget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailableBudgetCopyWith<AvailableBudget> get copyWith => _$AvailableBudgetCopyWithImpl<AvailableBudget>(this as AvailableBudget, _$identity);

  /// Serializes this AvailableBudget to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailableBudget&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.quoteStatus, quoteStatus) || other.quoteStatus == quoteStatus)&&(identical(other.client, client) || other.client == client));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,issuedAt,total,taxKind,quoteStatus,client);

@override
String toString() {
  return 'AvailableBudget(id: $id, series: $series, number: $number, issuedAt: $issuedAt, total: $total, taxKind: $taxKind, quoteStatus: $quoteStatus, client: $client)';
}


}

/// @nodoc
abstract mixin class $AvailableBudgetCopyWith<$Res>  {
  factory $AvailableBudgetCopyWith(AvailableBudget value, $Res Function(AvailableBudget) _then) = _$AvailableBudgetCopyWithImpl;
@useResult
$Res call({
 int id, String series, int number, String issuedAt,@JsonKey(fromJson: toDouble) double total, String? taxKind, String? quoteStatus, SaleParty? client
});


$SalePartyCopyWith<$Res>? get client;

}
/// @nodoc
class _$AvailableBudgetCopyWithImpl<$Res>
    implements $AvailableBudgetCopyWith<$Res> {
  _$AvailableBudgetCopyWithImpl(this._self, this._then);

  final AvailableBudget _self;
  final $Res Function(AvailableBudget) _then;

/// Create a copy of AvailableBudget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? series = null,Object? number = null,Object? issuedAt = null,Object? total = null,Object? taxKind = freezed,Object? quoteStatus = freezed,Object? client = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,quoteStatus: freezed == quoteStatus ? _self.quoteStatus : quoteStatus // ignore: cast_nullable_to_non_nullable
as String?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as SaleParty?,
  ));
}
/// Create a copy of AvailableBudget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalePartyCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $SalePartyCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// Adds pattern-matching-related methods to [AvailableBudget].
extension AvailableBudgetPatterns on AvailableBudget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailableBudget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailableBudget() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailableBudget value)  $default,){
final _that = this;
switch (_that) {
case _AvailableBudget():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailableBudget value)?  $default,){
final _that = this;
switch (_that) {
case _AvailableBudget() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind,  String? quoteStatus,  SaleParty? client)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailableBudget() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.issuedAt,_that.total,_that.taxKind,_that.quoteStatus,_that.client);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind,  String? quoteStatus,  SaleParty? client)  $default,) {final _that = this;
switch (_that) {
case _AvailableBudget():
return $default(_that.id,_that.series,_that.number,_that.issuedAt,_that.total,_that.taxKind,_that.quoteStatus,_that.client);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String series,  int number,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind,  String? quoteStatus,  SaleParty? client)?  $default,) {final _that = this;
switch (_that) {
case _AvailableBudget() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.issuedAt,_that.total,_that.taxKind,_that.quoteStatus,_that.client);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailableBudget implements AvailableBudget {
  const _AvailableBudget({required this.id, required this.series, required this.number, required this.issuedAt, @JsonKey(fromJson: toDouble) required this.total, this.taxKind, this.quoteStatus, this.client});
  factory _AvailableBudget.fromJson(Map<String, dynamic> json) => _$AvailableBudgetFromJson(json);

@override final  int id;
@override final  String series;
@override final  int number;
@override final  String issuedAt;
@override@JsonKey(fromJson: toDouble) final  double total;
@override final  String? taxKind;
@override final  String? quoteStatus;
@override final  SaleParty? client;

/// Create a copy of AvailableBudget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailableBudgetCopyWith<_AvailableBudget> get copyWith => __$AvailableBudgetCopyWithImpl<_AvailableBudget>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailableBudgetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailableBudget&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.quoteStatus, quoteStatus) || other.quoteStatus == quoteStatus)&&(identical(other.client, client) || other.client == client));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,issuedAt,total,taxKind,quoteStatus,client);

@override
String toString() {
  return 'AvailableBudget(id: $id, series: $series, number: $number, issuedAt: $issuedAt, total: $total, taxKind: $taxKind, quoteStatus: $quoteStatus, client: $client)';
}


}

/// @nodoc
abstract mixin class _$AvailableBudgetCopyWith<$Res> implements $AvailableBudgetCopyWith<$Res> {
  factory _$AvailableBudgetCopyWith(_AvailableBudget value, $Res Function(_AvailableBudget) _then) = __$AvailableBudgetCopyWithImpl;
@override @useResult
$Res call({
 int id, String series, int number, String issuedAt,@JsonKey(fromJson: toDouble) double total, String? taxKind, String? quoteStatus, SaleParty? client
});


@override $SalePartyCopyWith<$Res>? get client;

}
/// @nodoc
class __$AvailableBudgetCopyWithImpl<$Res>
    implements _$AvailableBudgetCopyWith<$Res> {
  __$AvailableBudgetCopyWithImpl(this._self, this._then);

  final _AvailableBudget _self;
  final $Res Function(_AvailableBudget) _then;

/// Create a copy of AvailableBudget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? series = null,Object? number = null,Object? issuedAt = null,Object? total = null,Object? taxKind = freezed,Object? quoteStatus = freezed,Object? client = freezed,}) {
  return _then(_AvailableBudget(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,quoteStatus: freezed == quoteStatus ? _self.quoteStatus : quoteStatus // ignore: cast_nullable_to_non_nullable
as String?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as SaleParty?,
  ));
}

/// Create a copy of AvailableBudget
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalePartyCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $SalePartyCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// @nodoc
mixin _$SaleDetail {

 int get id; String get code; String get status; String? get regime; String? get taxKind; int? get budgetId; String? get internalNotes;@JsonKey(fromJson: toDouble) double get totalPlanned;@JsonKey(fromJson: toDouble) double get totalInvoiced;@JsonKey(fromJson: toDouble) double get totalPending; SaleParty? get client; SaleParty? get vendor; SaleBudgetRef? get budget; List<SaleDetailLine> get lines; List<SaleInstallment> get installments; List<SaleInvoiceRef> get invoices;
/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleDetailCopyWith<SaleDetail> get copyWith => _$SaleDetailCopyWithImpl<SaleDetail>(this as SaleDetail, _$identity);

  /// Serializes this SaleDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.regime, regime) || other.regime == regime)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.budgetId, budgetId) || other.budgetId == budgetId)&&(identical(other.internalNotes, internalNotes) || other.internalNotes == internalNotes)&&(identical(other.totalPlanned, totalPlanned) || other.totalPlanned == totalPlanned)&&(identical(other.totalInvoiced, totalInvoiced) || other.totalInvoiced == totalInvoiced)&&(identical(other.totalPending, totalPending) || other.totalPending == totalPending)&&(identical(other.client, client) || other.client == client)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.budget, budget) || other.budget == budget)&&const DeepCollectionEquality().equals(other.lines, lines)&&const DeepCollectionEquality().equals(other.installments, installments)&&const DeepCollectionEquality().equals(other.invoices, invoices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,status,regime,taxKind,budgetId,internalNotes,totalPlanned,totalInvoiced,totalPending,client,vendor,budget,const DeepCollectionEquality().hash(lines),const DeepCollectionEquality().hash(installments),const DeepCollectionEquality().hash(invoices));

@override
String toString() {
  return 'SaleDetail(id: $id, code: $code, status: $status, regime: $regime, taxKind: $taxKind, budgetId: $budgetId, internalNotes: $internalNotes, totalPlanned: $totalPlanned, totalInvoiced: $totalInvoiced, totalPending: $totalPending, client: $client, vendor: $vendor, budget: $budget, lines: $lines, installments: $installments, invoices: $invoices)';
}


}

/// @nodoc
abstract mixin class $SaleDetailCopyWith<$Res>  {
  factory $SaleDetailCopyWith(SaleDetail value, $Res Function(SaleDetail) _then) = _$SaleDetailCopyWithImpl;
@useResult
$Res call({
 int id, String code, String status, String? regime, String? taxKind, int? budgetId, String? internalNotes,@JsonKey(fromJson: toDouble) double totalPlanned,@JsonKey(fromJson: toDouble) double totalInvoiced,@JsonKey(fromJson: toDouble) double totalPending, SaleParty? client, SaleParty? vendor, SaleBudgetRef? budget, List<SaleDetailLine> lines, List<SaleInstallment> installments, List<SaleInvoiceRef> invoices
});


$SalePartyCopyWith<$Res>? get client;$SalePartyCopyWith<$Res>? get vendor;$SaleBudgetRefCopyWith<$Res>? get budget;

}
/// @nodoc
class _$SaleDetailCopyWithImpl<$Res>
    implements $SaleDetailCopyWith<$Res> {
  _$SaleDetailCopyWithImpl(this._self, this._then);

  final SaleDetail _self;
  final $Res Function(SaleDetail) _then;

/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? status = null,Object? regime = freezed,Object? taxKind = freezed,Object? budgetId = freezed,Object? internalNotes = freezed,Object? totalPlanned = null,Object? totalInvoiced = null,Object? totalPending = null,Object? client = freezed,Object? vendor = freezed,Object? budget = freezed,Object? lines = null,Object? installments = null,Object? invoices = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,regime: freezed == regime ? _self.regime : regime // ignore: cast_nullable_to_non_nullable
as String?,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,budgetId: freezed == budgetId ? _self.budgetId : budgetId // ignore: cast_nullable_to_non_nullable
as int?,internalNotes: freezed == internalNotes ? _self.internalNotes : internalNotes // ignore: cast_nullable_to_non_nullable
as String?,totalPlanned: null == totalPlanned ? _self.totalPlanned : totalPlanned // ignore: cast_nullable_to_non_nullable
as double,totalInvoiced: null == totalInvoiced ? _self.totalInvoiced : totalInvoiced // ignore: cast_nullable_to_non_nullable
as double,totalPending: null == totalPending ? _self.totalPending : totalPending // ignore: cast_nullable_to_non_nullable
as double,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as SaleParty?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as SaleParty?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as SaleBudgetRef?,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<SaleDetailLine>,installments: null == installments ? _self.installments : installments // ignore: cast_nullable_to_non_nullable
as List<SaleInstallment>,invoices: null == invoices ? _self.invoices : invoices // ignore: cast_nullable_to_non_nullable
as List<SaleInvoiceRef>,
  ));
}
/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalePartyCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $SalePartyCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalePartyCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $SalePartyCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SaleBudgetRefCopyWith<$Res>? get budget {
    if (_self.budget == null) {
    return null;
  }

  return $SaleBudgetRefCopyWith<$Res>(_self.budget!, (value) {
    return _then(_self.copyWith(budget: value));
  });
}
}


/// Adds pattern-matching-related methods to [SaleDetail].
extension SaleDetailPatterns on SaleDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleDetail value)  $default,){
final _that = this;
switch (_that) {
case _SaleDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SaleDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String status,  String? regime,  String? taxKind,  int? budgetId,  String? internalNotes, @JsonKey(fromJson: toDouble)  double totalPlanned, @JsonKey(fromJson: toDouble)  double totalInvoiced, @JsonKey(fromJson: toDouble)  double totalPending,  SaleParty? client,  SaleParty? vendor,  SaleBudgetRef? budget,  List<SaleDetailLine> lines,  List<SaleInstallment> installments,  List<SaleInvoiceRef> invoices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleDetail() when $default != null:
return $default(_that.id,_that.code,_that.status,_that.regime,_that.taxKind,_that.budgetId,_that.internalNotes,_that.totalPlanned,_that.totalInvoiced,_that.totalPending,_that.client,_that.vendor,_that.budget,_that.lines,_that.installments,_that.invoices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String status,  String? regime,  String? taxKind,  int? budgetId,  String? internalNotes, @JsonKey(fromJson: toDouble)  double totalPlanned, @JsonKey(fromJson: toDouble)  double totalInvoiced, @JsonKey(fromJson: toDouble)  double totalPending,  SaleParty? client,  SaleParty? vendor,  SaleBudgetRef? budget,  List<SaleDetailLine> lines,  List<SaleInstallment> installments,  List<SaleInvoiceRef> invoices)  $default,) {final _that = this;
switch (_that) {
case _SaleDetail():
return $default(_that.id,_that.code,_that.status,_that.regime,_that.taxKind,_that.budgetId,_that.internalNotes,_that.totalPlanned,_that.totalInvoiced,_that.totalPending,_that.client,_that.vendor,_that.budget,_that.lines,_that.installments,_that.invoices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String status,  String? regime,  String? taxKind,  int? budgetId,  String? internalNotes, @JsonKey(fromJson: toDouble)  double totalPlanned, @JsonKey(fromJson: toDouble)  double totalInvoiced, @JsonKey(fromJson: toDouble)  double totalPending,  SaleParty? client,  SaleParty? vendor,  SaleBudgetRef? budget,  List<SaleDetailLine> lines,  List<SaleInstallment> installments,  List<SaleInvoiceRef> invoices)?  $default,) {final _that = this;
switch (_that) {
case _SaleDetail() when $default != null:
return $default(_that.id,_that.code,_that.status,_that.regime,_that.taxKind,_that.budgetId,_that.internalNotes,_that.totalPlanned,_that.totalInvoiced,_that.totalPending,_that.client,_that.vendor,_that.budget,_that.lines,_that.installments,_that.invoices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaleDetail implements SaleDetail {
  const _SaleDetail({required this.id, required this.code, required this.status, this.regime, this.taxKind, this.budgetId, this.internalNotes, @JsonKey(fromJson: toDouble) required this.totalPlanned, @JsonKey(fromJson: toDouble) required this.totalInvoiced, @JsonKey(fromJson: toDouble) required this.totalPending, this.client, this.vendor, this.budget, final  List<SaleDetailLine> lines = const [], final  List<SaleInstallment> installments = const [], final  List<SaleInvoiceRef> invoices = const []}): _lines = lines,_installments = installments,_invoices = invoices;
  factory _SaleDetail.fromJson(Map<String, dynamic> json) => _$SaleDetailFromJson(json);

@override final  int id;
@override final  String code;
@override final  String status;
@override final  String? regime;
@override final  String? taxKind;
@override final  int? budgetId;
@override final  String? internalNotes;
@override@JsonKey(fromJson: toDouble) final  double totalPlanned;
@override@JsonKey(fromJson: toDouble) final  double totalInvoiced;
@override@JsonKey(fromJson: toDouble) final  double totalPending;
@override final  SaleParty? client;
@override final  SaleParty? vendor;
@override final  SaleBudgetRef? budget;
 final  List<SaleDetailLine> _lines;
@override@JsonKey() List<SaleDetailLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

 final  List<SaleInstallment> _installments;
@override@JsonKey() List<SaleInstallment> get installments {
  if (_installments is EqualUnmodifiableListView) return _installments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_installments);
}

 final  List<SaleInvoiceRef> _invoices;
@override@JsonKey() List<SaleInvoiceRef> get invoices {
  if (_invoices is EqualUnmodifiableListView) return _invoices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invoices);
}


/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleDetailCopyWith<_SaleDetail> get copyWith => __$SaleDetailCopyWithImpl<_SaleDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaleDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.status, status) || other.status == status)&&(identical(other.regime, regime) || other.regime == regime)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.budgetId, budgetId) || other.budgetId == budgetId)&&(identical(other.internalNotes, internalNotes) || other.internalNotes == internalNotes)&&(identical(other.totalPlanned, totalPlanned) || other.totalPlanned == totalPlanned)&&(identical(other.totalInvoiced, totalInvoiced) || other.totalInvoiced == totalInvoiced)&&(identical(other.totalPending, totalPending) || other.totalPending == totalPending)&&(identical(other.client, client) || other.client == client)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.budget, budget) || other.budget == budget)&&const DeepCollectionEquality().equals(other._lines, _lines)&&const DeepCollectionEquality().equals(other._installments, _installments)&&const DeepCollectionEquality().equals(other._invoices, _invoices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,status,regime,taxKind,budgetId,internalNotes,totalPlanned,totalInvoiced,totalPending,client,vendor,budget,const DeepCollectionEquality().hash(_lines),const DeepCollectionEquality().hash(_installments),const DeepCollectionEquality().hash(_invoices));

@override
String toString() {
  return 'SaleDetail(id: $id, code: $code, status: $status, regime: $regime, taxKind: $taxKind, budgetId: $budgetId, internalNotes: $internalNotes, totalPlanned: $totalPlanned, totalInvoiced: $totalInvoiced, totalPending: $totalPending, client: $client, vendor: $vendor, budget: $budget, lines: $lines, installments: $installments, invoices: $invoices)';
}


}

/// @nodoc
abstract mixin class _$SaleDetailCopyWith<$Res> implements $SaleDetailCopyWith<$Res> {
  factory _$SaleDetailCopyWith(_SaleDetail value, $Res Function(_SaleDetail) _then) = __$SaleDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String status, String? regime, String? taxKind, int? budgetId, String? internalNotes,@JsonKey(fromJson: toDouble) double totalPlanned,@JsonKey(fromJson: toDouble) double totalInvoiced,@JsonKey(fromJson: toDouble) double totalPending, SaleParty? client, SaleParty? vendor, SaleBudgetRef? budget, List<SaleDetailLine> lines, List<SaleInstallment> installments, List<SaleInvoiceRef> invoices
});


@override $SalePartyCopyWith<$Res>? get client;@override $SalePartyCopyWith<$Res>? get vendor;@override $SaleBudgetRefCopyWith<$Res>? get budget;

}
/// @nodoc
class __$SaleDetailCopyWithImpl<$Res>
    implements _$SaleDetailCopyWith<$Res> {
  __$SaleDetailCopyWithImpl(this._self, this._then);

  final _SaleDetail _self;
  final $Res Function(_SaleDetail) _then;

/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? status = null,Object? regime = freezed,Object? taxKind = freezed,Object? budgetId = freezed,Object? internalNotes = freezed,Object? totalPlanned = null,Object? totalInvoiced = null,Object? totalPending = null,Object? client = freezed,Object? vendor = freezed,Object? budget = freezed,Object? lines = null,Object? installments = null,Object? invoices = null,}) {
  return _then(_SaleDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,regime: freezed == regime ? _self.regime : regime // ignore: cast_nullable_to_non_nullable
as String?,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,budgetId: freezed == budgetId ? _self.budgetId : budgetId // ignore: cast_nullable_to_non_nullable
as int?,internalNotes: freezed == internalNotes ? _self.internalNotes : internalNotes // ignore: cast_nullable_to_non_nullable
as String?,totalPlanned: null == totalPlanned ? _self.totalPlanned : totalPlanned // ignore: cast_nullable_to_non_nullable
as double,totalInvoiced: null == totalInvoiced ? _self.totalInvoiced : totalInvoiced // ignore: cast_nullable_to_non_nullable
as double,totalPending: null == totalPending ? _self.totalPending : totalPending // ignore: cast_nullable_to_non_nullable
as double,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as SaleParty?,vendor: freezed == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as SaleParty?,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as SaleBudgetRef?,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<SaleDetailLine>,installments: null == installments ? _self._installments : installments // ignore: cast_nullable_to_non_nullable
as List<SaleInstallment>,invoices: null == invoices ? _self._invoices : invoices // ignore: cast_nullable_to_non_nullable
as List<SaleInvoiceRef>,
  ));
}

/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalePartyCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $SalePartyCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalePartyCopyWith<$Res>? get vendor {
    if (_self.vendor == null) {
    return null;
  }

  return $SalePartyCopyWith<$Res>(_self.vendor!, (value) {
    return _then(_self.copyWith(vendor: value));
  });
}/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SaleBudgetRefCopyWith<$Res>? get budget {
    if (_self.budget == null) {
    return null;
  }

  return $SaleBudgetRefCopyWith<$Res>(_self.budget!, (value) {
    return _then(_self.copyWith(budget: value));
  });
}
}


/// @nodoc
mixin _$SaleBudgetRef {

 int get id; String get series; int get number; String get status; String get issuedAt;@JsonKey(fromJson: toDouble) double get total; String? get taxKind;
/// Create a copy of SaleBudgetRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleBudgetRefCopyWith<SaleBudgetRef> get copyWith => _$SaleBudgetRefCopyWithImpl<SaleBudgetRef>(this as SaleBudgetRef, _$identity);

  /// Serializes this SaleBudgetRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleBudgetRef&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,status,issuedAt,total,taxKind);

@override
String toString() {
  return 'SaleBudgetRef(id: $id, series: $series, number: $number, status: $status, issuedAt: $issuedAt, total: $total, taxKind: $taxKind)';
}


}

/// @nodoc
abstract mixin class $SaleBudgetRefCopyWith<$Res>  {
  factory $SaleBudgetRefCopyWith(SaleBudgetRef value, $Res Function(SaleBudgetRef) _then) = _$SaleBudgetRefCopyWithImpl;
@useResult
$Res call({
 int id, String series, int number, String status, String issuedAt,@JsonKey(fromJson: toDouble) double total, String? taxKind
});




}
/// @nodoc
class _$SaleBudgetRefCopyWithImpl<$Res>
    implements $SaleBudgetRefCopyWith<$Res> {
  _$SaleBudgetRefCopyWithImpl(this._self, this._then);

  final SaleBudgetRef _self;
  final $Res Function(SaleBudgetRef) _then;

/// Create a copy of SaleBudgetRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? series = null,Object? number = null,Object? status = null,Object? issuedAt = null,Object? total = null,Object? taxKind = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleBudgetRef].
extension SaleBudgetRefPatterns on SaleBudgetRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleBudgetRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleBudgetRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleBudgetRef value)  $default,){
final _that = this;
switch (_that) {
case _SaleBudgetRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleBudgetRef value)?  $default,){
final _that = this;
switch (_that) {
case _SaleBudgetRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String status,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleBudgetRef() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.status,_that.issuedAt,_that.total,_that.taxKind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String status,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind)  $default,) {final _that = this;
switch (_that) {
case _SaleBudgetRef():
return $default(_that.id,_that.series,_that.number,_that.status,_that.issuedAt,_that.total,_that.taxKind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String series,  int number,  String status,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind)?  $default,) {final _that = this;
switch (_that) {
case _SaleBudgetRef() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.status,_that.issuedAt,_that.total,_that.taxKind);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaleBudgetRef implements SaleBudgetRef {
  const _SaleBudgetRef({required this.id, required this.series, required this.number, required this.status, required this.issuedAt, @JsonKey(fromJson: toDouble) required this.total, this.taxKind});
  factory _SaleBudgetRef.fromJson(Map<String, dynamic> json) => _$SaleBudgetRefFromJson(json);

@override final  int id;
@override final  String series;
@override final  int number;
@override final  String status;
@override final  String issuedAt;
@override@JsonKey(fromJson: toDouble) final  double total;
@override final  String? taxKind;

/// Create a copy of SaleBudgetRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleBudgetRefCopyWith<_SaleBudgetRef> get copyWith => __$SaleBudgetRefCopyWithImpl<_SaleBudgetRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaleBudgetRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleBudgetRef&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,status,issuedAt,total,taxKind);

@override
String toString() {
  return 'SaleBudgetRef(id: $id, series: $series, number: $number, status: $status, issuedAt: $issuedAt, total: $total, taxKind: $taxKind)';
}


}

/// @nodoc
abstract mixin class _$SaleBudgetRefCopyWith<$Res> implements $SaleBudgetRefCopyWith<$Res> {
  factory _$SaleBudgetRefCopyWith(_SaleBudgetRef value, $Res Function(_SaleBudgetRef) _then) = __$SaleBudgetRefCopyWithImpl;
@override @useResult
$Res call({
 int id, String series, int number, String status, String issuedAt,@JsonKey(fromJson: toDouble) double total, String? taxKind
});




}
/// @nodoc
class __$SaleBudgetRefCopyWithImpl<$Res>
    implements _$SaleBudgetRefCopyWith<$Res> {
  __$SaleBudgetRefCopyWithImpl(this._self, this._then);

  final _SaleBudgetRef _self;
  final $Res Function(_SaleBudgetRef) _then;

/// Create a copy of SaleBudgetRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? series = null,Object? number = null,Object? status = null,Object? issuedAt = null,Object? total = null,Object? taxKind = freezed,}) {
  return _then(_SaleBudgetRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SaleDetailLine {

 int get id; int? get productId; int? get serviceId; String get description;@JsonKey(fromJson: toDouble) double get quantity;@JsonKey(fromJson: toDouble) double get unitPrice;@JsonKey(fromJson: toDouble) double get discountRate;@JsonKey(fromJson: toDouble) double get taxRate;@JsonKey(fromJson: toDouble) double get taxAmount;@JsonKey(fromJson: toDouble) double get total;@JsonKey(fromJson: toDouble) double get invoicedQuantity;@JsonKey(fromJson: toDouble) double get invoicedTotal;@JsonKey(fromJson: toDouble) double get pendingQuantity;@JsonKey(fromJson: toDouble) double get pendingTotal;
/// Create a copy of SaleDetailLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleDetailLineCopyWith<SaleDetailLine> get copyWith => _$SaleDetailLineCopyWithImpl<SaleDetailLine>(this as SaleDetailLine, _$identity);

  /// Serializes this SaleDetailLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleDetailLine&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.discountRate, discountRate) || other.discountRate == discountRate)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.total, total) || other.total == total)&&(identical(other.invoicedQuantity, invoicedQuantity) || other.invoicedQuantity == invoicedQuantity)&&(identical(other.invoicedTotal, invoicedTotal) || other.invoicedTotal == invoicedTotal)&&(identical(other.pendingQuantity, pendingQuantity) || other.pendingQuantity == pendingQuantity)&&(identical(other.pendingTotal, pendingTotal) || other.pendingTotal == pendingTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,serviceId,description,quantity,unitPrice,discountRate,taxRate,taxAmount,total,invoicedQuantity,invoicedTotal,pendingQuantity,pendingTotal);

@override
String toString() {
  return 'SaleDetailLine(id: $id, productId: $productId, serviceId: $serviceId, description: $description, quantity: $quantity, unitPrice: $unitPrice, discountRate: $discountRate, taxRate: $taxRate, taxAmount: $taxAmount, total: $total, invoicedQuantity: $invoicedQuantity, invoicedTotal: $invoicedTotal, pendingQuantity: $pendingQuantity, pendingTotal: $pendingTotal)';
}


}

/// @nodoc
abstract mixin class $SaleDetailLineCopyWith<$Res>  {
  factory $SaleDetailLineCopyWith(SaleDetailLine value, $Res Function(SaleDetailLine) _then) = _$SaleDetailLineCopyWithImpl;
@useResult
$Res call({
 int id, int? productId, int? serviceId, String description,@JsonKey(fromJson: toDouble) double quantity,@JsonKey(fromJson: toDouble) double unitPrice,@JsonKey(fromJson: toDouble) double discountRate,@JsonKey(fromJson: toDouble) double taxRate,@JsonKey(fromJson: toDouble) double taxAmount,@JsonKey(fromJson: toDouble) double total,@JsonKey(fromJson: toDouble) double invoicedQuantity,@JsonKey(fromJson: toDouble) double invoicedTotal,@JsonKey(fromJson: toDouble) double pendingQuantity,@JsonKey(fromJson: toDouble) double pendingTotal
});




}
/// @nodoc
class _$SaleDetailLineCopyWithImpl<$Res>
    implements $SaleDetailLineCopyWith<$Res> {
  _$SaleDetailLineCopyWithImpl(this._self, this._then);

  final SaleDetailLine _self;
  final $Res Function(SaleDetailLine) _then;

/// Create a copy of SaleDetailLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = freezed,Object? serviceId = freezed,Object? description = null,Object? quantity = null,Object? unitPrice = null,Object? discountRate = null,Object? taxRate = null,Object? taxAmount = null,Object? total = null,Object? invoicedQuantity = null,Object? invoicedTotal = null,Object? pendingQuantity = null,Object? pendingTotal = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,discountRate: null == discountRate ? _self.discountRate : discountRate // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,invoicedQuantity: null == invoicedQuantity ? _self.invoicedQuantity : invoicedQuantity // ignore: cast_nullable_to_non_nullable
as double,invoicedTotal: null == invoicedTotal ? _self.invoicedTotal : invoicedTotal // ignore: cast_nullable_to_non_nullable
as double,pendingQuantity: null == pendingQuantity ? _self.pendingQuantity : pendingQuantity // ignore: cast_nullable_to_non_nullable
as double,pendingTotal: null == pendingTotal ? _self.pendingTotal : pendingTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleDetailLine].
extension SaleDetailLinePatterns on SaleDetailLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleDetailLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleDetailLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleDetailLine value)  $default,){
final _that = this;
switch (_that) {
case _SaleDetailLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleDetailLine value)?  $default,){
final _that = this;
switch (_that) {
case _SaleDetailLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? productId,  int? serviceId,  String description, @JsonKey(fromJson: toDouble)  double quantity, @JsonKey(fromJson: toDouble)  double unitPrice, @JsonKey(fromJson: toDouble)  double discountRate, @JsonKey(fromJson: toDouble)  double taxRate, @JsonKey(fromJson: toDouble)  double taxAmount, @JsonKey(fromJson: toDouble)  double total, @JsonKey(fromJson: toDouble)  double invoicedQuantity, @JsonKey(fromJson: toDouble)  double invoicedTotal, @JsonKey(fromJson: toDouble)  double pendingQuantity, @JsonKey(fromJson: toDouble)  double pendingTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleDetailLine() when $default != null:
return $default(_that.id,_that.productId,_that.serviceId,_that.description,_that.quantity,_that.unitPrice,_that.discountRate,_that.taxRate,_that.taxAmount,_that.total,_that.invoicedQuantity,_that.invoicedTotal,_that.pendingQuantity,_that.pendingTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? productId,  int? serviceId,  String description, @JsonKey(fromJson: toDouble)  double quantity, @JsonKey(fromJson: toDouble)  double unitPrice, @JsonKey(fromJson: toDouble)  double discountRate, @JsonKey(fromJson: toDouble)  double taxRate, @JsonKey(fromJson: toDouble)  double taxAmount, @JsonKey(fromJson: toDouble)  double total, @JsonKey(fromJson: toDouble)  double invoicedQuantity, @JsonKey(fromJson: toDouble)  double invoicedTotal, @JsonKey(fromJson: toDouble)  double pendingQuantity, @JsonKey(fromJson: toDouble)  double pendingTotal)  $default,) {final _that = this;
switch (_that) {
case _SaleDetailLine():
return $default(_that.id,_that.productId,_that.serviceId,_that.description,_that.quantity,_that.unitPrice,_that.discountRate,_that.taxRate,_that.taxAmount,_that.total,_that.invoicedQuantity,_that.invoicedTotal,_that.pendingQuantity,_that.pendingTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? productId,  int? serviceId,  String description, @JsonKey(fromJson: toDouble)  double quantity, @JsonKey(fromJson: toDouble)  double unitPrice, @JsonKey(fromJson: toDouble)  double discountRate, @JsonKey(fromJson: toDouble)  double taxRate, @JsonKey(fromJson: toDouble)  double taxAmount, @JsonKey(fromJson: toDouble)  double total, @JsonKey(fromJson: toDouble)  double invoicedQuantity, @JsonKey(fromJson: toDouble)  double invoicedTotal, @JsonKey(fromJson: toDouble)  double pendingQuantity, @JsonKey(fromJson: toDouble)  double pendingTotal)?  $default,) {final _that = this;
switch (_that) {
case _SaleDetailLine() when $default != null:
return $default(_that.id,_that.productId,_that.serviceId,_that.description,_that.quantity,_that.unitPrice,_that.discountRate,_that.taxRate,_that.taxAmount,_that.total,_that.invoicedQuantity,_that.invoicedTotal,_that.pendingQuantity,_that.pendingTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaleDetailLine implements SaleDetailLine {
  const _SaleDetailLine({required this.id, this.productId, this.serviceId, required this.description, @JsonKey(fromJson: toDouble) required this.quantity, @JsonKey(fromJson: toDouble) required this.unitPrice, @JsonKey(fromJson: toDouble) required this.discountRate, @JsonKey(fromJson: toDouble) required this.taxRate, @JsonKey(fromJson: toDouble) required this.taxAmount, @JsonKey(fromJson: toDouble) required this.total, @JsonKey(fromJson: toDouble) this.invoicedQuantity = 0, @JsonKey(fromJson: toDouble) this.invoicedTotal = 0, @JsonKey(fromJson: toDouble) this.pendingQuantity = 0, @JsonKey(fromJson: toDouble) this.pendingTotal = 0});
  factory _SaleDetailLine.fromJson(Map<String, dynamic> json) => _$SaleDetailLineFromJson(json);

@override final  int id;
@override final  int? productId;
@override final  int? serviceId;
@override final  String description;
@override@JsonKey(fromJson: toDouble) final  double quantity;
@override@JsonKey(fromJson: toDouble) final  double unitPrice;
@override@JsonKey(fromJson: toDouble) final  double discountRate;
@override@JsonKey(fromJson: toDouble) final  double taxRate;
@override@JsonKey(fromJson: toDouble) final  double taxAmount;
@override@JsonKey(fromJson: toDouble) final  double total;
@override@JsonKey(fromJson: toDouble) final  double invoicedQuantity;
@override@JsonKey(fromJson: toDouble) final  double invoicedTotal;
@override@JsonKey(fromJson: toDouble) final  double pendingQuantity;
@override@JsonKey(fromJson: toDouble) final  double pendingTotal;

/// Create a copy of SaleDetailLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleDetailLineCopyWith<_SaleDetailLine> get copyWith => __$SaleDetailLineCopyWithImpl<_SaleDetailLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaleDetailLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleDetailLine&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.discountRate, discountRate) || other.discountRate == discountRate)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.total, total) || other.total == total)&&(identical(other.invoicedQuantity, invoicedQuantity) || other.invoicedQuantity == invoicedQuantity)&&(identical(other.invoicedTotal, invoicedTotal) || other.invoicedTotal == invoicedTotal)&&(identical(other.pendingQuantity, pendingQuantity) || other.pendingQuantity == pendingQuantity)&&(identical(other.pendingTotal, pendingTotal) || other.pendingTotal == pendingTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,serviceId,description,quantity,unitPrice,discountRate,taxRate,taxAmount,total,invoicedQuantity,invoicedTotal,pendingQuantity,pendingTotal);

@override
String toString() {
  return 'SaleDetailLine(id: $id, productId: $productId, serviceId: $serviceId, description: $description, quantity: $quantity, unitPrice: $unitPrice, discountRate: $discountRate, taxRate: $taxRate, taxAmount: $taxAmount, total: $total, invoicedQuantity: $invoicedQuantity, invoicedTotal: $invoicedTotal, pendingQuantity: $pendingQuantity, pendingTotal: $pendingTotal)';
}


}

/// @nodoc
abstract mixin class _$SaleDetailLineCopyWith<$Res> implements $SaleDetailLineCopyWith<$Res> {
  factory _$SaleDetailLineCopyWith(_SaleDetailLine value, $Res Function(_SaleDetailLine) _then) = __$SaleDetailLineCopyWithImpl;
@override @useResult
$Res call({
 int id, int? productId, int? serviceId, String description,@JsonKey(fromJson: toDouble) double quantity,@JsonKey(fromJson: toDouble) double unitPrice,@JsonKey(fromJson: toDouble) double discountRate,@JsonKey(fromJson: toDouble) double taxRate,@JsonKey(fromJson: toDouble) double taxAmount,@JsonKey(fromJson: toDouble) double total,@JsonKey(fromJson: toDouble) double invoicedQuantity,@JsonKey(fromJson: toDouble) double invoicedTotal,@JsonKey(fromJson: toDouble) double pendingQuantity,@JsonKey(fromJson: toDouble) double pendingTotal
});




}
/// @nodoc
class __$SaleDetailLineCopyWithImpl<$Res>
    implements _$SaleDetailLineCopyWith<$Res> {
  __$SaleDetailLineCopyWithImpl(this._self, this._then);

  final _SaleDetailLine _self;
  final $Res Function(_SaleDetailLine) _then;

/// Create a copy of SaleDetailLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = freezed,Object? serviceId = freezed,Object? description = null,Object? quantity = null,Object? unitPrice = null,Object? discountRate = null,Object? taxRate = null,Object? taxAmount = null,Object? total = null,Object? invoicedQuantity = null,Object? invoicedTotal = null,Object? pendingQuantity = null,Object? pendingTotal = null,}) {
  return _then(_SaleDetailLine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as int?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,discountRate: null == discountRate ? _self.discountRate : discountRate // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,invoicedQuantity: null == invoicedQuantity ? _self.invoicedQuantity : invoicedQuantity // ignore: cast_nullable_to_non_nullable
as double,invoicedTotal: null == invoicedTotal ? _self.invoicedTotal : invoicedTotal // ignore: cast_nullable_to_non_nullable
as double,pendingQuantity: null == pendingQuantity ? _self.pendingQuantity : pendingQuantity // ignore: cast_nullable_to_non_nullable
as double,pendingTotal: null == pendingTotal ? _self.pendingTotal : pendingTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$SaleInstallment {

 int get id; int get index; String? get dueDate;@JsonKey(fromJson: toDoubleN) double? get percentage;@JsonKey(fromJson: toDoubleN) double? get plannedAmount;
/// Create a copy of SaleInstallment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleInstallmentCopyWith<SaleInstallment> get copyWith => _$SaleInstallmentCopyWithImpl<SaleInstallment>(this as SaleInstallment, _$identity);

  /// Serializes this SaleInstallment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleInstallment&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.plannedAmount, plannedAmount) || other.plannedAmount == plannedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,index,dueDate,percentage,plannedAmount);

@override
String toString() {
  return 'SaleInstallment(id: $id, index: $index, dueDate: $dueDate, percentage: $percentage, plannedAmount: $plannedAmount)';
}


}

/// @nodoc
abstract mixin class $SaleInstallmentCopyWith<$Res>  {
  factory $SaleInstallmentCopyWith(SaleInstallment value, $Res Function(SaleInstallment) _then) = _$SaleInstallmentCopyWithImpl;
@useResult
$Res call({
 int id, int index, String? dueDate,@JsonKey(fromJson: toDoubleN) double? percentage,@JsonKey(fromJson: toDoubleN) double? plannedAmount
});




}
/// @nodoc
class _$SaleInstallmentCopyWithImpl<$Res>
    implements $SaleInstallmentCopyWith<$Res> {
  _$SaleInstallmentCopyWithImpl(this._self, this._then);

  final SaleInstallment _self;
  final $Res Function(SaleInstallment) _then;

/// Create a copy of SaleInstallment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? index = null,Object? dueDate = freezed,Object? percentage = freezed,Object? plannedAmount = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,percentage: freezed == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double?,plannedAmount: freezed == plannedAmount ? _self.plannedAmount : plannedAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleInstallment].
extension SaleInstallmentPatterns on SaleInstallment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleInstallment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleInstallment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleInstallment value)  $default,){
final _that = this;
switch (_that) {
case _SaleInstallment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleInstallment value)?  $default,){
final _that = this;
switch (_that) {
case _SaleInstallment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int index,  String? dueDate, @JsonKey(fromJson: toDoubleN)  double? percentage, @JsonKey(fromJson: toDoubleN)  double? plannedAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleInstallment() when $default != null:
return $default(_that.id,_that.index,_that.dueDate,_that.percentage,_that.plannedAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int index,  String? dueDate, @JsonKey(fromJson: toDoubleN)  double? percentage, @JsonKey(fromJson: toDoubleN)  double? plannedAmount)  $default,) {final _that = this;
switch (_that) {
case _SaleInstallment():
return $default(_that.id,_that.index,_that.dueDate,_that.percentage,_that.plannedAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int index,  String? dueDate, @JsonKey(fromJson: toDoubleN)  double? percentage, @JsonKey(fromJson: toDoubleN)  double? plannedAmount)?  $default,) {final _that = this;
switch (_that) {
case _SaleInstallment() when $default != null:
return $default(_that.id,_that.index,_that.dueDate,_that.percentage,_that.plannedAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaleInstallment implements SaleInstallment {
  const _SaleInstallment({required this.id, required this.index, this.dueDate, @JsonKey(fromJson: toDoubleN) this.percentage, @JsonKey(fromJson: toDoubleN) this.plannedAmount});
  factory _SaleInstallment.fromJson(Map<String, dynamic> json) => _$SaleInstallmentFromJson(json);

@override final  int id;
@override final  int index;
@override final  String? dueDate;
@override@JsonKey(fromJson: toDoubleN) final  double? percentage;
@override@JsonKey(fromJson: toDoubleN) final  double? plannedAmount;

/// Create a copy of SaleInstallment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleInstallmentCopyWith<_SaleInstallment> get copyWith => __$SaleInstallmentCopyWithImpl<_SaleInstallment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaleInstallmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleInstallment&&(identical(other.id, id) || other.id == id)&&(identical(other.index, index) || other.index == index)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.plannedAmount, plannedAmount) || other.plannedAmount == plannedAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,index,dueDate,percentage,plannedAmount);

@override
String toString() {
  return 'SaleInstallment(id: $id, index: $index, dueDate: $dueDate, percentage: $percentage, plannedAmount: $plannedAmount)';
}


}

/// @nodoc
abstract mixin class _$SaleInstallmentCopyWith<$Res> implements $SaleInstallmentCopyWith<$Res> {
  factory _$SaleInstallmentCopyWith(_SaleInstallment value, $Res Function(_SaleInstallment) _then) = __$SaleInstallmentCopyWithImpl;
@override @useResult
$Res call({
 int id, int index, String? dueDate,@JsonKey(fromJson: toDoubleN) double? percentage,@JsonKey(fromJson: toDoubleN) double? plannedAmount
});




}
/// @nodoc
class __$SaleInstallmentCopyWithImpl<$Res>
    implements _$SaleInstallmentCopyWith<$Res> {
  __$SaleInstallmentCopyWithImpl(this._self, this._then);

  final _SaleInstallment _self;
  final $Res Function(_SaleInstallment) _then;

/// Create a copy of SaleInstallment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? index = null,Object? dueDate = freezed,Object? percentage = freezed,Object? plannedAmount = freezed,}) {
  return _then(_SaleInstallment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,percentage: freezed == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double?,plannedAmount: freezed == plannedAmount ? _self.plannedAmount : plannedAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$SaleInvoiceRef {

 int get id; String get series; int get number; String get status; String get issuedAt;@JsonKey(fromJson: toDouble) double get total; bool get isFinal;
/// Create a copy of SaleInvoiceRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleInvoiceRefCopyWith<SaleInvoiceRef> get copyWith => _$SaleInvoiceRefCopyWithImpl<SaleInvoiceRef>(this as SaleInvoiceRef, _$identity);

  /// Serializes this SaleInvoiceRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleInvoiceRef&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,status,issuedAt,total,isFinal);

@override
String toString() {
  return 'SaleInvoiceRef(id: $id, series: $series, number: $number, status: $status, issuedAt: $issuedAt, total: $total, isFinal: $isFinal)';
}


}

/// @nodoc
abstract mixin class $SaleInvoiceRefCopyWith<$Res>  {
  factory $SaleInvoiceRefCopyWith(SaleInvoiceRef value, $Res Function(SaleInvoiceRef) _then) = _$SaleInvoiceRefCopyWithImpl;
@useResult
$Res call({
 int id, String series, int number, String status, String issuedAt,@JsonKey(fromJson: toDouble) double total, bool isFinal
});




}
/// @nodoc
class _$SaleInvoiceRefCopyWithImpl<$Res>
    implements $SaleInvoiceRefCopyWith<$Res> {
  _$SaleInvoiceRefCopyWithImpl(this._self, this._then);

  final SaleInvoiceRef _self;
  final $Res Function(SaleInvoiceRef) _then;

/// Create a copy of SaleInvoiceRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? series = null,Object? number = null,Object? status = null,Object? issuedAt = null,Object? total = null,Object? isFinal = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,isFinal: null == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleInvoiceRef].
extension SaleInvoiceRefPatterns on SaleInvoiceRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleInvoiceRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleInvoiceRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleInvoiceRef value)  $default,){
final _that = this;
switch (_that) {
case _SaleInvoiceRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleInvoiceRef value)?  $default,){
final _that = this;
switch (_that) {
case _SaleInvoiceRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String status,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  bool isFinal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleInvoiceRef() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.status,_that.issuedAt,_that.total,_that.isFinal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String status,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  bool isFinal)  $default,) {final _that = this;
switch (_that) {
case _SaleInvoiceRef():
return $default(_that.id,_that.series,_that.number,_that.status,_that.issuedAt,_that.total,_that.isFinal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String series,  int number,  String status,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  bool isFinal)?  $default,) {final _that = this;
switch (_that) {
case _SaleInvoiceRef() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.status,_that.issuedAt,_that.total,_that.isFinal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaleInvoiceRef implements SaleInvoiceRef {
  const _SaleInvoiceRef({required this.id, required this.series, required this.number, required this.status, required this.issuedAt, @JsonKey(fromJson: toDouble) required this.total, this.isFinal = false});
  factory _SaleInvoiceRef.fromJson(Map<String, dynamic> json) => _$SaleInvoiceRefFromJson(json);

@override final  int id;
@override final  String series;
@override final  int number;
@override final  String status;
@override final  String issuedAt;
@override@JsonKey(fromJson: toDouble) final  double total;
@override@JsonKey() final  bool isFinal;

/// Create a copy of SaleInvoiceRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleInvoiceRefCopyWith<_SaleInvoiceRef> get copyWith => __$SaleInvoiceRefCopyWithImpl<_SaleInvoiceRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaleInvoiceRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleInvoiceRef&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,status,issuedAt,total,isFinal);

@override
String toString() {
  return 'SaleInvoiceRef(id: $id, series: $series, number: $number, status: $status, issuedAt: $issuedAt, total: $total, isFinal: $isFinal)';
}


}

/// @nodoc
abstract mixin class _$SaleInvoiceRefCopyWith<$Res> implements $SaleInvoiceRefCopyWith<$Res> {
  factory _$SaleInvoiceRefCopyWith(_SaleInvoiceRef value, $Res Function(_SaleInvoiceRef) _then) = __$SaleInvoiceRefCopyWithImpl;
@override @useResult
$Res call({
 int id, String series, int number, String status, String issuedAt,@JsonKey(fromJson: toDouble) double total, bool isFinal
});




}
/// @nodoc
class __$SaleInvoiceRefCopyWithImpl<$Res>
    implements _$SaleInvoiceRefCopyWith<$Res> {
  __$SaleInvoiceRefCopyWithImpl(this._self, this._then);

  final _SaleInvoiceRef _self;
  final $Res Function(_SaleInvoiceRef) _then;

/// Create a copy of SaleInvoiceRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? series = null,Object? number = null,Object? status = null,Object? issuedAt = null,Object? total = null,Object? isFinal = null,}) {
  return _then(_SaleInvoiceRef(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,isFinal: null == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
