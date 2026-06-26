// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BudgetListItem {

 int get id; String get series; int get number; String get status; String? get quoteStatus; String get issuedAt;@JsonKey(fromJson: toDouble) double get total; String? get taxKind; int? get saleId; BudgetClient? get client;
/// Create a copy of BudgetListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetListItemCopyWith<BudgetListItem> get copyWith => _$BudgetListItemCopyWithImpl<BudgetListItem>(this as BudgetListItem, _$identity);

  /// Serializes this BudgetListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.quoteStatus, quoteStatus) || other.quoteStatus == quoteStatus)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.saleId, saleId) || other.saleId == saleId)&&(identical(other.client, client) || other.client == client));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,status,quoteStatus,issuedAt,total,taxKind,saleId,client);

@override
String toString() {
  return 'BudgetListItem(id: $id, series: $series, number: $number, status: $status, quoteStatus: $quoteStatus, issuedAt: $issuedAt, total: $total, taxKind: $taxKind, saleId: $saleId, client: $client)';
}


}

/// @nodoc
abstract mixin class $BudgetListItemCopyWith<$Res>  {
  factory $BudgetListItemCopyWith(BudgetListItem value, $Res Function(BudgetListItem) _then) = _$BudgetListItemCopyWithImpl;
@useResult
$Res call({
 int id, String series, int number, String status, String? quoteStatus, String issuedAt,@JsonKey(fromJson: toDouble) double total, String? taxKind, int? saleId, BudgetClient? client
});


$BudgetClientCopyWith<$Res>? get client;

}
/// @nodoc
class _$BudgetListItemCopyWithImpl<$Res>
    implements $BudgetListItemCopyWith<$Res> {
  _$BudgetListItemCopyWithImpl(this._self, this._then);

  final BudgetListItem _self;
  final $Res Function(BudgetListItem) _then;

/// Create a copy of BudgetListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? series = null,Object? number = null,Object? status = null,Object? quoteStatus = freezed,Object? issuedAt = null,Object? total = null,Object? taxKind = freezed,Object? saleId = freezed,Object? client = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quoteStatus: freezed == quoteStatus ? _self.quoteStatus : quoteStatus // ignore: cast_nullable_to_non_nullable
as String?,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,saleId: freezed == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as BudgetClient?,
  ));
}
/// Create a copy of BudgetListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetClientCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $BudgetClientCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// Adds pattern-matching-related methods to [BudgetListItem].
extension BudgetListItemPatterns on BudgetListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetListItem value)  $default,){
final _that = this;
switch (_that) {
case _BudgetListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetListItem value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String status,  String? quoteStatus,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind,  int? saleId,  BudgetClient? client)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetListItem() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.status,_that.quoteStatus,_that.issuedAt,_that.total,_that.taxKind,_that.saleId,_that.client);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String status,  String? quoteStatus,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind,  int? saleId,  BudgetClient? client)  $default,) {final _that = this;
switch (_that) {
case _BudgetListItem():
return $default(_that.id,_that.series,_that.number,_that.status,_that.quoteStatus,_that.issuedAt,_that.total,_that.taxKind,_that.saleId,_that.client);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String series,  int number,  String status,  String? quoteStatus,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind,  int? saleId,  BudgetClient? client)?  $default,) {final _that = this;
switch (_that) {
case _BudgetListItem() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.status,_that.quoteStatus,_that.issuedAt,_that.total,_that.taxKind,_that.saleId,_that.client);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetListItem implements BudgetListItem {
  const _BudgetListItem({required this.id, required this.series, required this.number, required this.status, this.quoteStatus, required this.issuedAt, @JsonKey(fromJson: toDouble) required this.total, this.taxKind, this.saleId, this.client});
  factory _BudgetListItem.fromJson(Map<String, dynamic> json) => _$BudgetListItemFromJson(json);

@override final  int id;
@override final  String series;
@override final  int number;
@override final  String status;
@override final  String? quoteStatus;
@override final  String issuedAt;
@override@JsonKey(fromJson: toDouble) final  double total;
@override final  String? taxKind;
@override final  int? saleId;
@override final  BudgetClient? client;

/// Create a copy of BudgetListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetListItemCopyWith<_BudgetListItem> get copyWith => __$BudgetListItemCopyWithImpl<_BudgetListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.quoteStatus, quoteStatus) || other.quoteStatus == quoteStatus)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.saleId, saleId) || other.saleId == saleId)&&(identical(other.client, client) || other.client == client));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,status,quoteStatus,issuedAt,total,taxKind,saleId,client);

@override
String toString() {
  return 'BudgetListItem(id: $id, series: $series, number: $number, status: $status, quoteStatus: $quoteStatus, issuedAt: $issuedAt, total: $total, taxKind: $taxKind, saleId: $saleId, client: $client)';
}


}

/// @nodoc
abstract mixin class _$BudgetListItemCopyWith<$Res> implements $BudgetListItemCopyWith<$Res> {
  factory _$BudgetListItemCopyWith(_BudgetListItem value, $Res Function(_BudgetListItem) _then) = __$BudgetListItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String series, int number, String status, String? quoteStatus, String issuedAt,@JsonKey(fromJson: toDouble) double total, String? taxKind, int? saleId, BudgetClient? client
});


@override $BudgetClientCopyWith<$Res>? get client;

}
/// @nodoc
class __$BudgetListItemCopyWithImpl<$Res>
    implements _$BudgetListItemCopyWith<$Res> {
  __$BudgetListItemCopyWithImpl(this._self, this._then);

  final _BudgetListItem _self;
  final $Res Function(_BudgetListItem) _then;

/// Create a copy of BudgetListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? series = null,Object? number = null,Object? status = null,Object? quoteStatus = freezed,Object? issuedAt = null,Object? total = null,Object? taxKind = freezed,Object? saleId = freezed,Object? client = freezed,}) {
  return _then(_BudgetListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quoteStatus: freezed == quoteStatus ? _self.quoteStatus : quoteStatus // ignore: cast_nullable_to_non_nullable
as String?,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,saleId: freezed == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as BudgetClient?,
  ));
}

/// Create a copy of BudgetListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetClientCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $BudgetClientCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// @nodoc
mixin _$BudgetClient {

 int get id; String get name; String? get taxId;
/// Create a copy of BudgetClient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetClientCopyWith<BudgetClient> get copyWith => _$BudgetClientCopyWithImpl<BudgetClient>(this as BudgetClient, _$identity);

  /// Serializes this BudgetClient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetClient&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.taxId, taxId) || other.taxId == taxId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,taxId);

@override
String toString() {
  return 'BudgetClient(id: $id, name: $name, taxId: $taxId)';
}


}

/// @nodoc
abstract mixin class $BudgetClientCopyWith<$Res>  {
  factory $BudgetClientCopyWith(BudgetClient value, $Res Function(BudgetClient) _then) = _$BudgetClientCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? taxId
});




}
/// @nodoc
class _$BudgetClientCopyWithImpl<$Res>
    implements $BudgetClientCopyWith<$Res> {
  _$BudgetClientCopyWithImpl(this._self, this._then);

  final BudgetClient _self;
  final $Res Function(BudgetClient) _then;

/// Create a copy of BudgetClient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? taxId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,taxId: freezed == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetClient].
extension BudgetClientPatterns on BudgetClient {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetClient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetClient() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetClient value)  $default,){
final _that = this;
switch (_that) {
case _BudgetClient():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetClient value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetClient() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? taxId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetClient() when $default != null:
return $default(_that.id,_that.name,_that.taxId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? taxId)  $default,) {final _that = this;
switch (_that) {
case _BudgetClient():
return $default(_that.id,_that.name,_that.taxId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? taxId)?  $default,) {final _that = this;
switch (_that) {
case _BudgetClient() when $default != null:
return $default(_that.id,_that.name,_that.taxId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetClient implements BudgetClient {
  const _BudgetClient({required this.id, required this.name, this.taxId});
  factory _BudgetClient.fromJson(Map<String, dynamic> json) => _$BudgetClientFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? taxId;

/// Create a copy of BudgetClient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetClientCopyWith<_BudgetClient> get copyWith => __$BudgetClientCopyWithImpl<_BudgetClient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetClientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetClient&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.taxId, taxId) || other.taxId == taxId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,taxId);

@override
String toString() {
  return 'BudgetClient(id: $id, name: $name, taxId: $taxId)';
}


}

/// @nodoc
abstract mixin class _$BudgetClientCopyWith<$Res> implements $BudgetClientCopyWith<$Res> {
  factory _$BudgetClientCopyWith(_BudgetClient value, $Res Function(_BudgetClient) _then) = __$BudgetClientCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? taxId
});




}
/// @nodoc
class __$BudgetClientCopyWithImpl<$Res>
    implements _$BudgetClientCopyWith<$Res> {
  __$BudgetClientCopyWithImpl(this._self, this._then);

  final _BudgetClient _self;
  final $Res Function(_BudgetClient) _then;

/// Create a copy of BudgetClient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? taxId = freezed,}) {
  return _then(_BudgetClient(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,taxId: freezed == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BudgetDetail {

 int get id; String get series; int get number; String get status; String? get quoteStatus; String get issuedAt;@JsonKey(fromJson: toDouble) double get total; String? get taxKind; int? get paymentPlanCount; int? get saleId; String? get internalNotes; String? get publicNotes; BudgetClient? get client; List<BudgetLine> get lines;
/// Create a copy of BudgetDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetDetailCopyWith<BudgetDetail> get copyWith => _$BudgetDetailCopyWithImpl<BudgetDetail>(this as BudgetDetail, _$identity);

  /// Serializes this BudgetDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.quoteStatus, quoteStatus) || other.quoteStatus == quoteStatus)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.paymentPlanCount, paymentPlanCount) || other.paymentPlanCount == paymentPlanCount)&&(identical(other.saleId, saleId) || other.saleId == saleId)&&(identical(other.internalNotes, internalNotes) || other.internalNotes == internalNotes)&&(identical(other.publicNotes, publicNotes) || other.publicNotes == publicNotes)&&(identical(other.client, client) || other.client == client)&&const DeepCollectionEquality().equals(other.lines, lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,status,quoteStatus,issuedAt,total,taxKind,paymentPlanCount,saleId,internalNotes,publicNotes,client,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'BudgetDetail(id: $id, series: $series, number: $number, status: $status, quoteStatus: $quoteStatus, issuedAt: $issuedAt, total: $total, taxKind: $taxKind, paymentPlanCount: $paymentPlanCount, saleId: $saleId, internalNotes: $internalNotes, publicNotes: $publicNotes, client: $client, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $BudgetDetailCopyWith<$Res>  {
  factory $BudgetDetailCopyWith(BudgetDetail value, $Res Function(BudgetDetail) _then) = _$BudgetDetailCopyWithImpl;
@useResult
$Res call({
 int id, String series, int number, String status, String? quoteStatus, String issuedAt,@JsonKey(fromJson: toDouble) double total, String? taxKind, int? paymentPlanCount, int? saleId, String? internalNotes, String? publicNotes, BudgetClient? client, List<BudgetLine> lines
});


$BudgetClientCopyWith<$Res>? get client;

}
/// @nodoc
class _$BudgetDetailCopyWithImpl<$Res>
    implements $BudgetDetailCopyWith<$Res> {
  _$BudgetDetailCopyWithImpl(this._self, this._then);

  final BudgetDetail _self;
  final $Res Function(BudgetDetail) _then;

/// Create a copy of BudgetDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? series = null,Object? number = null,Object? status = null,Object? quoteStatus = freezed,Object? issuedAt = null,Object? total = null,Object? taxKind = freezed,Object? paymentPlanCount = freezed,Object? saleId = freezed,Object? internalNotes = freezed,Object? publicNotes = freezed,Object? client = freezed,Object? lines = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quoteStatus: freezed == quoteStatus ? _self.quoteStatus : quoteStatus // ignore: cast_nullable_to_non_nullable
as String?,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,paymentPlanCount: freezed == paymentPlanCount ? _self.paymentPlanCount : paymentPlanCount // ignore: cast_nullable_to_non_nullable
as int?,saleId: freezed == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int?,internalNotes: freezed == internalNotes ? _self.internalNotes : internalNotes // ignore: cast_nullable_to_non_nullable
as String?,publicNotes: freezed == publicNotes ? _self.publicNotes : publicNotes // ignore: cast_nullable_to_non_nullable
as String?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as BudgetClient?,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<BudgetLine>,
  ));
}
/// Create a copy of BudgetDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetClientCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $BudgetClientCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// Adds pattern-matching-related methods to [BudgetDetail].
extension BudgetDetailPatterns on BudgetDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetDetail value)  $default,){
final _that = this;
switch (_that) {
case _BudgetDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetDetail value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String status,  String? quoteStatus,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind,  int? paymentPlanCount,  int? saleId,  String? internalNotes,  String? publicNotes,  BudgetClient? client,  List<BudgetLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetDetail() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.status,_that.quoteStatus,_that.issuedAt,_that.total,_that.taxKind,_that.paymentPlanCount,_that.saleId,_that.internalNotes,_that.publicNotes,_that.client,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String status,  String? quoteStatus,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind,  int? paymentPlanCount,  int? saleId,  String? internalNotes,  String? publicNotes,  BudgetClient? client,  List<BudgetLine> lines)  $default,) {final _that = this;
switch (_that) {
case _BudgetDetail():
return $default(_that.id,_that.series,_that.number,_that.status,_that.quoteStatus,_that.issuedAt,_that.total,_that.taxKind,_that.paymentPlanCount,_that.saleId,_that.internalNotes,_that.publicNotes,_that.client,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String series,  int number,  String status,  String? quoteStatus,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String? taxKind,  int? paymentPlanCount,  int? saleId,  String? internalNotes,  String? publicNotes,  BudgetClient? client,  List<BudgetLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _BudgetDetail() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.status,_that.quoteStatus,_that.issuedAt,_that.total,_that.taxKind,_that.paymentPlanCount,_that.saleId,_that.internalNotes,_that.publicNotes,_that.client,_that.lines);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetDetail implements BudgetDetail {
  const _BudgetDetail({required this.id, required this.series, required this.number, required this.status, this.quoteStatus, required this.issuedAt, @JsonKey(fromJson: toDouble) required this.total, this.taxKind, this.paymentPlanCount, this.saleId, this.internalNotes, this.publicNotes, this.client, final  List<BudgetLine> lines = const []}): _lines = lines;
  factory _BudgetDetail.fromJson(Map<String, dynamic> json) => _$BudgetDetailFromJson(json);

@override final  int id;
@override final  String series;
@override final  int number;
@override final  String status;
@override final  String? quoteStatus;
@override final  String issuedAt;
@override@JsonKey(fromJson: toDouble) final  double total;
@override final  String? taxKind;
@override final  int? paymentPlanCount;
@override final  int? saleId;
@override final  String? internalNotes;
@override final  String? publicNotes;
@override final  BudgetClient? client;
 final  List<BudgetLine> _lines;
@override@JsonKey() List<BudgetLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of BudgetDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetDetailCopyWith<_BudgetDetail> get copyWith => __$BudgetDetailCopyWithImpl<_BudgetDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.quoteStatus, quoteStatus) || other.quoteStatus == quoteStatus)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.paymentPlanCount, paymentPlanCount) || other.paymentPlanCount == paymentPlanCount)&&(identical(other.saleId, saleId) || other.saleId == saleId)&&(identical(other.internalNotes, internalNotes) || other.internalNotes == internalNotes)&&(identical(other.publicNotes, publicNotes) || other.publicNotes == publicNotes)&&(identical(other.client, client) || other.client == client)&&const DeepCollectionEquality().equals(other._lines, _lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,status,quoteStatus,issuedAt,total,taxKind,paymentPlanCount,saleId,internalNotes,publicNotes,client,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'BudgetDetail(id: $id, series: $series, number: $number, status: $status, quoteStatus: $quoteStatus, issuedAt: $issuedAt, total: $total, taxKind: $taxKind, paymentPlanCount: $paymentPlanCount, saleId: $saleId, internalNotes: $internalNotes, publicNotes: $publicNotes, client: $client, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$BudgetDetailCopyWith<$Res> implements $BudgetDetailCopyWith<$Res> {
  factory _$BudgetDetailCopyWith(_BudgetDetail value, $Res Function(_BudgetDetail) _then) = __$BudgetDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String series, int number, String status, String? quoteStatus, String issuedAt,@JsonKey(fromJson: toDouble) double total, String? taxKind, int? paymentPlanCount, int? saleId, String? internalNotes, String? publicNotes, BudgetClient? client, List<BudgetLine> lines
});


@override $BudgetClientCopyWith<$Res>? get client;

}
/// @nodoc
class __$BudgetDetailCopyWithImpl<$Res>
    implements _$BudgetDetailCopyWith<$Res> {
  __$BudgetDetailCopyWithImpl(this._self, this._then);

  final _BudgetDetail _self;
  final $Res Function(_BudgetDetail) _then;

/// Create a copy of BudgetDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? series = null,Object? number = null,Object? status = null,Object? quoteStatus = freezed,Object? issuedAt = null,Object? total = null,Object? taxKind = freezed,Object? paymentPlanCount = freezed,Object? saleId = freezed,Object? internalNotes = freezed,Object? publicNotes = freezed,Object? client = freezed,Object? lines = null,}) {
  return _then(_BudgetDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,quoteStatus: freezed == quoteStatus ? _self.quoteStatus : quoteStatus // ignore: cast_nullable_to_non_nullable
as String?,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,paymentPlanCount: freezed == paymentPlanCount ? _self.paymentPlanCount : paymentPlanCount // ignore: cast_nullable_to_non_nullable
as int?,saleId: freezed == saleId ? _self.saleId : saleId // ignore: cast_nullable_to_non_nullable
as int?,internalNotes: freezed == internalNotes ? _self.internalNotes : internalNotes // ignore: cast_nullable_to_non_nullable
as String?,publicNotes: freezed == publicNotes ? _self.publicNotes : publicNotes // ignore: cast_nullable_to_non_nullable
as String?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as BudgetClient?,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<BudgetLine>,
  ));
}

/// Create a copy of BudgetDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetClientCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $BudgetClientCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// @nodoc
mixin _$BudgetLine {

 int get id; int? get productId; int? get serviceId; String get description;@JsonKey(fromJson: toDouble) double get quantity;@JsonKey(fromJson: toDouble) double get unitPrice;@JsonKey(fromJson: toDouble) double get discountRate;@JsonKey(fromJson: toDouble) double get taxRate;@JsonKey(fromJson: toDouble) double get taxAmount;@JsonKey(fromJson: toDouble) double get total;
/// Create a copy of BudgetLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetLineCopyWith<BudgetLine> get copyWith => _$BudgetLineCopyWithImpl<BudgetLine>(this as BudgetLine, _$identity);

  /// Serializes this BudgetLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetLine&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.discountRate, discountRate) || other.discountRate == discountRate)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,serviceId,description,quantity,unitPrice,discountRate,taxRate,taxAmount,total);

@override
String toString() {
  return 'BudgetLine(id: $id, productId: $productId, serviceId: $serviceId, description: $description, quantity: $quantity, unitPrice: $unitPrice, discountRate: $discountRate, taxRate: $taxRate, taxAmount: $taxAmount, total: $total)';
}


}

/// @nodoc
abstract mixin class $BudgetLineCopyWith<$Res>  {
  factory $BudgetLineCopyWith(BudgetLine value, $Res Function(BudgetLine) _then) = _$BudgetLineCopyWithImpl;
@useResult
$Res call({
 int id, int? productId, int? serviceId, String description,@JsonKey(fromJson: toDouble) double quantity,@JsonKey(fromJson: toDouble) double unitPrice,@JsonKey(fromJson: toDouble) double discountRate,@JsonKey(fromJson: toDouble) double taxRate,@JsonKey(fromJson: toDouble) double taxAmount,@JsonKey(fromJson: toDouble) double total
});




}
/// @nodoc
class _$BudgetLineCopyWithImpl<$Res>
    implements $BudgetLineCopyWith<$Res> {
  _$BudgetLineCopyWithImpl(this._self, this._then);

  final BudgetLine _self;
  final $Res Function(BudgetLine) _then;

/// Create a copy of BudgetLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = freezed,Object? serviceId = freezed,Object? description = null,Object? quantity = null,Object? unitPrice = null,Object? discountRate = null,Object? taxRate = null,Object? taxAmount = null,Object? total = null,}) {
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
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetLine].
extension BudgetLinePatterns on BudgetLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetLine value)  $default,){
final _that = this;
switch (_that) {
case _BudgetLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetLine value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? productId,  int? serviceId,  String description, @JsonKey(fromJson: toDouble)  double quantity, @JsonKey(fromJson: toDouble)  double unitPrice, @JsonKey(fromJson: toDouble)  double discountRate, @JsonKey(fromJson: toDouble)  double taxRate, @JsonKey(fromJson: toDouble)  double taxAmount, @JsonKey(fromJson: toDouble)  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetLine() when $default != null:
return $default(_that.id,_that.productId,_that.serviceId,_that.description,_that.quantity,_that.unitPrice,_that.discountRate,_that.taxRate,_that.taxAmount,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? productId,  int? serviceId,  String description, @JsonKey(fromJson: toDouble)  double quantity, @JsonKey(fromJson: toDouble)  double unitPrice, @JsonKey(fromJson: toDouble)  double discountRate, @JsonKey(fromJson: toDouble)  double taxRate, @JsonKey(fromJson: toDouble)  double taxAmount, @JsonKey(fromJson: toDouble)  double total)  $default,) {final _that = this;
switch (_that) {
case _BudgetLine():
return $default(_that.id,_that.productId,_that.serviceId,_that.description,_that.quantity,_that.unitPrice,_that.discountRate,_that.taxRate,_that.taxAmount,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? productId,  int? serviceId,  String description, @JsonKey(fromJson: toDouble)  double quantity, @JsonKey(fromJson: toDouble)  double unitPrice, @JsonKey(fromJson: toDouble)  double discountRate, @JsonKey(fromJson: toDouble)  double taxRate, @JsonKey(fromJson: toDouble)  double taxAmount, @JsonKey(fromJson: toDouble)  double total)?  $default,) {final _that = this;
switch (_that) {
case _BudgetLine() when $default != null:
return $default(_that.id,_that.productId,_that.serviceId,_that.description,_that.quantity,_that.unitPrice,_that.discountRate,_that.taxRate,_that.taxAmount,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetLine implements BudgetLine {
  const _BudgetLine({required this.id, this.productId, this.serviceId, required this.description, @JsonKey(fromJson: toDouble) required this.quantity, @JsonKey(fromJson: toDouble) required this.unitPrice, @JsonKey(fromJson: toDouble) required this.discountRate, @JsonKey(fromJson: toDouble) required this.taxRate, @JsonKey(fromJson: toDouble) required this.taxAmount, @JsonKey(fromJson: toDouble) required this.total});
  factory _BudgetLine.fromJson(Map<String, dynamic> json) => _$BudgetLineFromJson(json);

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

/// Create a copy of BudgetLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetLineCopyWith<_BudgetLine> get copyWith => __$BudgetLineCopyWithImpl<_BudgetLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetLine&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.discountRate, discountRate) || other.discountRate == discountRate)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,serviceId,description,quantity,unitPrice,discountRate,taxRate,taxAmount,total);

@override
String toString() {
  return 'BudgetLine(id: $id, productId: $productId, serviceId: $serviceId, description: $description, quantity: $quantity, unitPrice: $unitPrice, discountRate: $discountRate, taxRate: $taxRate, taxAmount: $taxAmount, total: $total)';
}


}

/// @nodoc
abstract mixin class _$BudgetLineCopyWith<$Res> implements $BudgetLineCopyWith<$Res> {
  factory _$BudgetLineCopyWith(_BudgetLine value, $Res Function(_BudgetLine) _then) = __$BudgetLineCopyWithImpl;
@override @useResult
$Res call({
 int id, int? productId, int? serviceId, String description,@JsonKey(fromJson: toDouble) double quantity,@JsonKey(fromJson: toDouble) double unitPrice,@JsonKey(fromJson: toDouble) double discountRate,@JsonKey(fromJson: toDouble) double taxRate,@JsonKey(fromJson: toDouble) double taxAmount,@JsonKey(fromJson: toDouble) double total
});




}
/// @nodoc
class __$BudgetLineCopyWithImpl<$Res>
    implements _$BudgetLineCopyWith<$Res> {
  __$BudgetLineCopyWithImpl(this._self, this._then);

  final _BudgetLine _self;
  final $Res Function(_BudgetLine) _then;

/// Create a copy of BudgetLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = freezed,Object? serviceId = freezed,Object? description = null,Object? quantity = null,Object? unitPrice = null,Object? discountRate = null,Object? taxRate = null,Object? taxAmount = null,Object? total = null,}) {
  return _then(_BudgetLine(
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
as double,
  ));
}


}

// dart format on
