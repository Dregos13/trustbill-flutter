// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvoiceListItem {

 int get id; String get type; String get status; String get series; int get number; String get issuedAt;@JsonKey(fromJson: toDouble) double get total; String get invoiceType; String? get taxKind; InvoiceClient? get client;
/// Create a copy of InvoiceListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceListItemCopyWith<InvoiceListItem> get copyWith => _$InvoiceListItemCopyWithImpl<InvoiceListItem>(this as InvoiceListItem, _$identity);

  /// Serializes this InvoiceListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.invoiceType, invoiceType) || other.invoiceType == invoiceType)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.client, client) || other.client == client));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,status,series,number,issuedAt,total,invoiceType,taxKind,client);

@override
String toString() {
  return 'InvoiceListItem(id: $id, type: $type, status: $status, series: $series, number: $number, issuedAt: $issuedAt, total: $total, invoiceType: $invoiceType, taxKind: $taxKind, client: $client)';
}


}

/// @nodoc
abstract mixin class $InvoiceListItemCopyWith<$Res>  {
  factory $InvoiceListItemCopyWith(InvoiceListItem value, $Res Function(InvoiceListItem) _then) = _$InvoiceListItemCopyWithImpl;
@useResult
$Res call({
 int id, String type, String status, String series, int number, String issuedAt,@JsonKey(fromJson: toDouble) double total, String invoiceType, String? taxKind, InvoiceClient? client
});


$InvoiceClientCopyWith<$Res>? get client;

}
/// @nodoc
class _$InvoiceListItemCopyWithImpl<$Res>
    implements $InvoiceListItemCopyWith<$Res> {
  _$InvoiceListItemCopyWithImpl(this._self, this._then);

  final InvoiceListItem _self;
  final $Res Function(InvoiceListItem) _then;

/// Create a copy of InvoiceListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? status = null,Object? series = null,Object? number = null,Object? issuedAt = null,Object? total = null,Object? invoiceType = null,Object? taxKind = freezed,Object? client = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,invoiceType: null == invoiceType ? _self.invoiceType : invoiceType // ignore: cast_nullable_to_non_nullable
as String,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as InvoiceClient?,
  ));
}
/// Create a copy of InvoiceListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvoiceClientCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $InvoiceClientCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// Adds pattern-matching-related methods to [InvoiceListItem].
extension InvoiceListItemPatterns on InvoiceListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceListItem value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceListItem value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  String status,  String series,  int number,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String invoiceType,  String? taxKind,  InvoiceClient? client)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceListItem() when $default != null:
return $default(_that.id,_that.type,_that.status,_that.series,_that.number,_that.issuedAt,_that.total,_that.invoiceType,_that.taxKind,_that.client);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  String status,  String series,  int number,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String invoiceType,  String? taxKind,  InvoiceClient? client)  $default,) {final _that = this;
switch (_that) {
case _InvoiceListItem():
return $default(_that.id,_that.type,_that.status,_that.series,_that.number,_that.issuedAt,_that.total,_that.invoiceType,_that.taxKind,_that.client);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  String status,  String series,  int number,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String invoiceType,  String? taxKind,  InvoiceClient? client)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceListItem() when $default != null:
return $default(_that.id,_that.type,_that.status,_that.series,_that.number,_that.issuedAt,_that.total,_that.invoiceType,_that.taxKind,_that.client);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceListItem implements InvoiceListItem {
  const _InvoiceListItem({required this.id, required this.type, required this.status, required this.series, required this.number, required this.issuedAt, @JsonKey(fromJson: toDouble) required this.total, required this.invoiceType, this.taxKind, this.client});
  factory _InvoiceListItem.fromJson(Map<String, dynamic> json) => _$InvoiceListItemFromJson(json);

@override final  int id;
@override final  String type;
@override final  String status;
@override final  String series;
@override final  int number;
@override final  String issuedAt;
@override@JsonKey(fromJson: toDouble) final  double total;
@override final  String invoiceType;
@override final  String? taxKind;
@override final  InvoiceClient? client;

/// Create a copy of InvoiceListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceListItemCopyWith<_InvoiceListItem> get copyWith => __$InvoiceListItemCopyWithImpl<_InvoiceListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.invoiceType, invoiceType) || other.invoiceType == invoiceType)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.client, client) || other.client == client));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,status,series,number,issuedAt,total,invoiceType,taxKind,client);

@override
String toString() {
  return 'InvoiceListItem(id: $id, type: $type, status: $status, series: $series, number: $number, issuedAt: $issuedAt, total: $total, invoiceType: $invoiceType, taxKind: $taxKind, client: $client)';
}


}

/// @nodoc
abstract mixin class _$InvoiceListItemCopyWith<$Res> implements $InvoiceListItemCopyWith<$Res> {
  factory _$InvoiceListItemCopyWith(_InvoiceListItem value, $Res Function(_InvoiceListItem) _then) = __$InvoiceListItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, String status, String series, int number, String issuedAt,@JsonKey(fromJson: toDouble) double total, String invoiceType, String? taxKind, InvoiceClient? client
});


@override $InvoiceClientCopyWith<$Res>? get client;

}
/// @nodoc
class __$InvoiceListItemCopyWithImpl<$Res>
    implements _$InvoiceListItemCopyWith<$Res> {
  __$InvoiceListItemCopyWithImpl(this._self, this._then);

  final _InvoiceListItem _self;
  final $Res Function(_InvoiceListItem) _then;

/// Create a copy of InvoiceListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? status = null,Object? series = null,Object? number = null,Object? issuedAt = null,Object? total = null,Object? invoiceType = null,Object? taxKind = freezed,Object? client = freezed,}) {
  return _then(_InvoiceListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,invoiceType: null == invoiceType ? _self.invoiceType : invoiceType // ignore: cast_nullable_to_non_nullable
as String,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as InvoiceClient?,
  ));
}

/// Create a copy of InvoiceListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvoiceClientCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $InvoiceClientCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}
}


/// @nodoc
mixin _$InvoiceClient {

 int get id; String get name; String get taxId;
/// Create a copy of InvoiceClient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceClientCopyWith<InvoiceClient> get copyWith => _$InvoiceClientCopyWithImpl<InvoiceClient>(this as InvoiceClient, _$identity);

  /// Serializes this InvoiceClient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceClient&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.taxId, taxId) || other.taxId == taxId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,taxId);

@override
String toString() {
  return 'InvoiceClient(id: $id, name: $name, taxId: $taxId)';
}


}

/// @nodoc
abstract mixin class $InvoiceClientCopyWith<$Res>  {
  factory $InvoiceClientCopyWith(InvoiceClient value, $Res Function(InvoiceClient) _then) = _$InvoiceClientCopyWithImpl;
@useResult
$Res call({
 int id, String name, String taxId
});




}
/// @nodoc
class _$InvoiceClientCopyWithImpl<$Res>
    implements $InvoiceClientCopyWith<$Res> {
  _$InvoiceClientCopyWithImpl(this._self, this._then);

  final InvoiceClient _self;
  final $Res Function(InvoiceClient) _then;

/// Create a copy of InvoiceClient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? taxId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,taxId: null == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InvoiceClient].
extension InvoiceClientPatterns on InvoiceClient {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceClient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceClient() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceClient value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceClient():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceClient value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceClient() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String taxId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceClient() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String taxId)  $default,) {final _that = this;
switch (_that) {
case _InvoiceClient():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String taxId)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceClient() when $default != null:
return $default(_that.id,_that.name,_that.taxId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceClient implements InvoiceClient {
  const _InvoiceClient({required this.id, required this.name, required this.taxId});
  factory _InvoiceClient.fromJson(Map<String, dynamic> json) => _$InvoiceClientFromJson(json);

@override final  int id;
@override final  String name;
@override final  String taxId;

/// Create a copy of InvoiceClient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceClientCopyWith<_InvoiceClient> get copyWith => __$InvoiceClientCopyWithImpl<_InvoiceClient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceClientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceClient&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.taxId, taxId) || other.taxId == taxId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,taxId);

@override
String toString() {
  return 'InvoiceClient(id: $id, name: $name, taxId: $taxId)';
}


}

/// @nodoc
abstract mixin class _$InvoiceClientCopyWith<$Res> implements $InvoiceClientCopyWith<$Res> {
  factory _$InvoiceClientCopyWith(_InvoiceClient value, $Res Function(_InvoiceClient) _then) = __$InvoiceClientCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String taxId
});




}
/// @nodoc
class __$InvoiceClientCopyWithImpl<$Res>
    implements _$InvoiceClientCopyWith<$Res> {
  __$InvoiceClientCopyWithImpl(this._self, this._then);

  final _InvoiceClient _self;
  final $Res Function(_InvoiceClient) _then;

/// Create a copy of InvoiceClient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? taxId = null,}) {
  return _then(_InvoiceClient(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,taxId: null == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$InvoiceDetail {

 int get id; String get type; String get status; String get series; int get number; String get issuedAt;@JsonKey(fromJson: toDouble) double get total; String get invoiceType; String? get taxKind; String? get internalNotes; String? get publicNotes; String? get invoiceNote; InvoiceDetailClient? get client; CreatedBy? get createdBy; List<InvoiceLine> get lines; List<Payment> get payments;
/// Create a copy of InvoiceDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceDetailCopyWith<InvoiceDetail> get copyWith => _$InvoiceDetailCopyWithImpl<InvoiceDetail>(this as InvoiceDetail, _$identity);

  /// Serializes this InvoiceDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.invoiceType, invoiceType) || other.invoiceType == invoiceType)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.internalNotes, internalNotes) || other.internalNotes == internalNotes)&&(identical(other.publicNotes, publicNotes) || other.publicNotes == publicNotes)&&(identical(other.invoiceNote, invoiceNote) || other.invoiceNote == invoiceNote)&&(identical(other.client, client) || other.client == client)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other.lines, lines)&&const DeepCollectionEquality().equals(other.payments, payments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,status,series,number,issuedAt,total,invoiceType,taxKind,internalNotes,publicNotes,invoiceNote,client,createdBy,const DeepCollectionEquality().hash(lines),const DeepCollectionEquality().hash(payments));

@override
String toString() {
  return 'InvoiceDetail(id: $id, type: $type, status: $status, series: $series, number: $number, issuedAt: $issuedAt, total: $total, invoiceType: $invoiceType, taxKind: $taxKind, internalNotes: $internalNotes, publicNotes: $publicNotes, invoiceNote: $invoiceNote, client: $client, createdBy: $createdBy, lines: $lines, payments: $payments)';
}


}

/// @nodoc
abstract mixin class $InvoiceDetailCopyWith<$Res>  {
  factory $InvoiceDetailCopyWith(InvoiceDetail value, $Res Function(InvoiceDetail) _then) = _$InvoiceDetailCopyWithImpl;
@useResult
$Res call({
 int id, String type, String status, String series, int number, String issuedAt,@JsonKey(fromJson: toDouble) double total, String invoiceType, String? taxKind, String? internalNotes, String? publicNotes, String? invoiceNote, InvoiceDetailClient? client, CreatedBy? createdBy, List<InvoiceLine> lines, List<Payment> payments
});


$InvoiceDetailClientCopyWith<$Res>? get client;$CreatedByCopyWith<$Res>? get createdBy;

}
/// @nodoc
class _$InvoiceDetailCopyWithImpl<$Res>
    implements $InvoiceDetailCopyWith<$Res> {
  _$InvoiceDetailCopyWithImpl(this._self, this._then);

  final InvoiceDetail _self;
  final $Res Function(InvoiceDetail) _then;

/// Create a copy of InvoiceDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? status = null,Object? series = null,Object? number = null,Object? issuedAt = null,Object? total = null,Object? invoiceType = null,Object? taxKind = freezed,Object? internalNotes = freezed,Object? publicNotes = freezed,Object? invoiceNote = freezed,Object? client = freezed,Object? createdBy = freezed,Object? lines = null,Object? payments = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,invoiceType: null == invoiceType ? _self.invoiceType : invoiceType // ignore: cast_nullable_to_non_nullable
as String,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,internalNotes: freezed == internalNotes ? _self.internalNotes : internalNotes // ignore: cast_nullable_to_non_nullable
as String?,publicNotes: freezed == publicNotes ? _self.publicNotes : publicNotes // ignore: cast_nullable_to_non_nullable
as String?,invoiceNote: freezed == invoiceNote ? _self.invoiceNote : invoiceNote // ignore: cast_nullable_to_non_nullable
as String?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as InvoiceDetailClient?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CreatedBy?,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<InvoiceLine>,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<Payment>,
  ));
}
/// Create a copy of InvoiceDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvoiceDetailClientCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $InvoiceDetailClientCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of InvoiceDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreatedByCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $CreatedByCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [InvoiceDetail].
extension InvoiceDetailPatterns on InvoiceDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceDetail value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceDetail value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  String status,  String series,  int number,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String invoiceType,  String? taxKind,  String? internalNotes,  String? publicNotes,  String? invoiceNote,  InvoiceDetailClient? client,  CreatedBy? createdBy,  List<InvoiceLine> lines,  List<Payment> payments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceDetail() when $default != null:
return $default(_that.id,_that.type,_that.status,_that.series,_that.number,_that.issuedAt,_that.total,_that.invoiceType,_that.taxKind,_that.internalNotes,_that.publicNotes,_that.invoiceNote,_that.client,_that.createdBy,_that.lines,_that.payments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  String status,  String series,  int number,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String invoiceType,  String? taxKind,  String? internalNotes,  String? publicNotes,  String? invoiceNote,  InvoiceDetailClient? client,  CreatedBy? createdBy,  List<InvoiceLine> lines,  List<Payment> payments)  $default,) {final _that = this;
switch (_that) {
case _InvoiceDetail():
return $default(_that.id,_that.type,_that.status,_that.series,_that.number,_that.issuedAt,_that.total,_that.invoiceType,_that.taxKind,_that.internalNotes,_that.publicNotes,_that.invoiceNote,_that.client,_that.createdBy,_that.lines,_that.payments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  String status,  String series,  int number,  String issuedAt, @JsonKey(fromJson: toDouble)  double total,  String invoiceType,  String? taxKind,  String? internalNotes,  String? publicNotes,  String? invoiceNote,  InvoiceDetailClient? client,  CreatedBy? createdBy,  List<InvoiceLine> lines,  List<Payment> payments)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceDetail() when $default != null:
return $default(_that.id,_that.type,_that.status,_that.series,_that.number,_that.issuedAt,_that.total,_that.invoiceType,_that.taxKind,_that.internalNotes,_that.publicNotes,_that.invoiceNote,_that.client,_that.createdBy,_that.lines,_that.payments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceDetail implements InvoiceDetail {
  const _InvoiceDetail({required this.id, required this.type, required this.status, required this.series, required this.number, required this.issuedAt, @JsonKey(fromJson: toDouble) required this.total, required this.invoiceType, this.taxKind, this.internalNotes, this.publicNotes, this.invoiceNote, this.client, this.createdBy, required final  List<InvoiceLine> lines, required final  List<Payment> payments}): _lines = lines,_payments = payments;
  factory _InvoiceDetail.fromJson(Map<String, dynamic> json) => _$InvoiceDetailFromJson(json);

@override final  int id;
@override final  String type;
@override final  String status;
@override final  String series;
@override final  int number;
@override final  String issuedAt;
@override@JsonKey(fromJson: toDouble) final  double total;
@override final  String invoiceType;
@override final  String? taxKind;
@override final  String? internalNotes;
@override final  String? publicNotes;
@override final  String? invoiceNote;
@override final  InvoiceDetailClient? client;
@override final  CreatedBy? createdBy;
 final  List<InvoiceLine> _lines;
@override List<InvoiceLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

 final  List<Payment> _payments;
@override List<Payment> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}


/// Create a copy of InvoiceDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceDetailCopyWith<_InvoiceDetail> get copyWith => __$InvoiceDetailCopyWithImpl<_InvoiceDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.invoiceType, invoiceType) || other.invoiceType == invoiceType)&&(identical(other.taxKind, taxKind) || other.taxKind == taxKind)&&(identical(other.internalNotes, internalNotes) || other.internalNotes == internalNotes)&&(identical(other.publicNotes, publicNotes) || other.publicNotes == publicNotes)&&(identical(other.invoiceNote, invoiceNote) || other.invoiceNote == invoiceNote)&&(identical(other.client, client) || other.client == client)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other._lines, _lines)&&const DeepCollectionEquality().equals(other._payments, _payments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,status,series,number,issuedAt,total,invoiceType,taxKind,internalNotes,publicNotes,invoiceNote,client,createdBy,const DeepCollectionEquality().hash(_lines),const DeepCollectionEquality().hash(_payments));

@override
String toString() {
  return 'InvoiceDetail(id: $id, type: $type, status: $status, series: $series, number: $number, issuedAt: $issuedAt, total: $total, invoiceType: $invoiceType, taxKind: $taxKind, internalNotes: $internalNotes, publicNotes: $publicNotes, invoiceNote: $invoiceNote, client: $client, createdBy: $createdBy, lines: $lines, payments: $payments)';
}


}

/// @nodoc
abstract mixin class _$InvoiceDetailCopyWith<$Res> implements $InvoiceDetailCopyWith<$Res> {
  factory _$InvoiceDetailCopyWith(_InvoiceDetail value, $Res Function(_InvoiceDetail) _then) = __$InvoiceDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, String status, String series, int number, String issuedAt,@JsonKey(fromJson: toDouble) double total, String invoiceType, String? taxKind, String? internalNotes, String? publicNotes, String? invoiceNote, InvoiceDetailClient? client, CreatedBy? createdBy, List<InvoiceLine> lines, List<Payment> payments
});


@override $InvoiceDetailClientCopyWith<$Res>? get client;@override $CreatedByCopyWith<$Res>? get createdBy;

}
/// @nodoc
class __$InvoiceDetailCopyWithImpl<$Res>
    implements _$InvoiceDetailCopyWith<$Res> {
  __$InvoiceDetailCopyWithImpl(this._self, this._then);

  final _InvoiceDetail _self;
  final $Res Function(_InvoiceDetail) _then;

/// Create a copy of InvoiceDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? status = null,Object? series = null,Object? number = null,Object? issuedAt = null,Object? total = null,Object? invoiceType = null,Object? taxKind = freezed,Object? internalNotes = freezed,Object? publicNotes = freezed,Object? invoiceNote = freezed,Object? client = freezed,Object? createdBy = freezed,Object? lines = null,Object? payments = null,}) {
  return _then(_InvoiceDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,invoiceType: null == invoiceType ? _self.invoiceType : invoiceType // ignore: cast_nullable_to_non_nullable
as String,taxKind: freezed == taxKind ? _self.taxKind : taxKind // ignore: cast_nullable_to_non_nullable
as String?,internalNotes: freezed == internalNotes ? _self.internalNotes : internalNotes // ignore: cast_nullable_to_non_nullable
as String?,publicNotes: freezed == publicNotes ? _self.publicNotes : publicNotes // ignore: cast_nullable_to_non_nullable
as String?,invoiceNote: freezed == invoiceNote ? _self.invoiceNote : invoiceNote // ignore: cast_nullable_to_non_nullable
as String?,client: freezed == client ? _self.client : client // ignore: cast_nullable_to_non_nullable
as InvoiceDetailClient?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as CreatedBy?,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<InvoiceLine>,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<Payment>,
  ));
}

/// Create a copy of InvoiceDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvoiceDetailClientCopyWith<$Res>? get client {
    if (_self.client == null) {
    return null;
  }

  return $InvoiceDetailClientCopyWith<$Res>(_self.client!, (value) {
    return _then(_self.copyWith(client: value));
  });
}/// Create a copy of InvoiceDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreatedByCopyWith<$Res>? get createdBy {
    if (_self.createdBy == null) {
    return null;
  }

  return $CreatedByCopyWith<$Res>(_self.createdBy!, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// @nodoc
mixin _$InvoiceDetailClient {

 int get id; String get name; String get taxId; String? get email; String? get phone; String? get address; String? get city;
/// Create a copy of InvoiceDetailClient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceDetailClientCopyWith<InvoiceDetailClient> get copyWith => _$InvoiceDetailClientCopyWithImpl<InvoiceDetailClient>(this as InvoiceDetailClient, _$identity);

  /// Serializes this InvoiceDetailClient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceDetailClient&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,taxId,email,phone,address,city);

@override
String toString() {
  return 'InvoiceDetailClient(id: $id, name: $name, taxId: $taxId, email: $email, phone: $phone, address: $address, city: $city)';
}


}

/// @nodoc
abstract mixin class $InvoiceDetailClientCopyWith<$Res>  {
  factory $InvoiceDetailClientCopyWith(InvoiceDetailClient value, $Res Function(InvoiceDetailClient) _then) = _$InvoiceDetailClientCopyWithImpl;
@useResult
$Res call({
 int id, String name, String taxId, String? email, String? phone, String? address, String? city
});




}
/// @nodoc
class _$InvoiceDetailClientCopyWithImpl<$Res>
    implements $InvoiceDetailClientCopyWith<$Res> {
  _$InvoiceDetailClientCopyWithImpl(this._self, this._then);

  final InvoiceDetailClient _self;
  final $Res Function(InvoiceDetailClient) _then;

/// Create a copy of InvoiceDetailClient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? taxId = null,Object? email = freezed,Object? phone = freezed,Object? address = freezed,Object? city = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,taxId: null == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InvoiceDetailClient].
extension InvoiceDetailClientPatterns on InvoiceDetailClient {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceDetailClient value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceDetailClient() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceDetailClient value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceDetailClient():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceDetailClient value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceDetailClient() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String taxId,  String? email,  String? phone,  String? address,  String? city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceDetailClient() when $default != null:
return $default(_that.id,_that.name,_that.taxId,_that.email,_that.phone,_that.address,_that.city);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String taxId,  String? email,  String? phone,  String? address,  String? city)  $default,) {final _that = this;
switch (_that) {
case _InvoiceDetailClient():
return $default(_that.id,_that.name,_that.taxId,_that.email,_that.phone,_that.address,_that.city);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String taxId,  String? email,  String? phone,  String? address,  String? city)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceDetailClient() when $default != null:
return $default(_that.id,_that.name,_that.taxId,_that.email,_that.phone,_that.address,_that.city);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceDetailClient implements InvoiceDetailClient {
  const _InvoiceDetailClient({required this.id, required this.name, required this.taxId, this.email, this.phone, this.address, this.city});
  factory _InvoiceDetailClient.fromJson(Map<String, dynamic> json) => _$InvoiceDetailClientFromJson(json);

@override final  int id;
@override final  String name;
@override final  String taxId;
@override final  String? email;
@override final  String? phone;
@override final  String? address;
@override final  String? city;

/// Create a copy of InvoiceDetailClient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceDetailClientCopyWith<_InvoiceDetailClient> get copyWith => __$InvoiceDetailClientCopyWithImpl<_InvoiceDetailClient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceDetailClientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceDetailClient&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,taxId,email,phone,address,city);

@override
String toString() {
  return 'InvoiceDetailClient(id: $id, name: $name, taxId: $taxId, email: $email, phone: $phone, address: $address, city: $city)';
}


}

/// @nodoc
abstract mixin class _$InvoiceDetailClientCopyWith<$Res> implements $InvoiceDetailClientCopyWith<$Res> {
  factory _$InvoiceDetailClientCopyWith(_InvoiceDetailClient value, $Res Function(_InvoiceDetailClient) _then) = __$InvoiceDetailClientCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String taxId, String? email, String? phone, String? address, String? city
});




}
/// @nodoc
class __$InvoiceDetailClientCopyWithImpl<$Res>
    implements _$InvoiceDetailClientCopyWith<$Res> {
  __$InvoiceDetailClientCopyWithImpl(this._self, this._then);

  final _InvoiceDetailClient _self;
  final $Res Function(_InvoiceDetailClient) _then;

/// Create a copy of InvoiceDetailClient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? taxId = null,Object? email = freezed,Object? phone = freezed,Object? address = freezed,Object? city = freezed,}) {
  return _then(_InvoiceDetailClient(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,taxId: null == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CreatedBy {

 int get id; String get name;
/// Create a copy of CreatedBy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatedByCopyWith<CreatedBy> get copyWith => _$CreatedByCopyWithImpl<CreatedBy>(this as CreatedBy, _$identity);

  /// Serializes this CreatedBy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatedBy&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'CreatedBy(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $CreatedByCopyWith<$Res>  {
  factory $CreatedByCopyWith(CreatedBy value, $Res Function(CreatedBy) _then) = _$CreatedByCopyWithImpl;
@useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class _$CreatedByCopyWithImpl<$Res>
    implements $CreatedByCopyWith<$Res> {
  _$CreatedByCopyWithImpl(this._self, this._then);

  final CreatedBy _self;
  final $Res Function(CreatedBy) _then;

/// Create a copy of CreatedBy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatedBy].
extension CreatedByPatterns on CreatedBy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatedBy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatedBy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatedBy value)  $default,){
final _that = this;
switch (_that) {
case _CreatedBy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatedBy value)?  $default,){
final _that = this;
switch (_that) {
case _CreatedBy() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatedBy() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name)  $default,) {final _that = this;
switch (_that) {
case _CreatedBy():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _CreatedBy() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatedBy implements CreatedBy {
  const _CreatedBy({required this.id, required this.name});
  factory _CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);

@override final  int id;
@override final  String name;

/// Create a copy of CreatedBy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedByCopyWith<_CreatedBy> get copyWith => __$CreatedByCopyWithImpl<_CreatedBy>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatedByToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedBy&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'CreatedBy(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$CreatedByCopyWith<$Res> implements $CreatedByCopyWith<$Res> {
  factory _$CreatedByCopyWith(_CreatedBy value, $Res Function(_CreatedBy) _then) = __$CreatedByCopyWithImpl;
@override @useResult
$Res call({
 int id, String name
});




}
/// @nodoc
class __$CreatedByCopyWithImpl<$Res>
    implements _$CreatedByCopyWith<$Res> {
  __$CreatedByCopyWithImpl(this._self, this._then);

  final _CreatedBy _self;
  final $Res Function(_CreatedBy) _then;

/// Create a copy of CreatedBy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_CreatedBy(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$InvoiceLine {

 int get id; String get description;@JsonKey(fromJson: toDouble) double get quantity;@JsonKey(fromJson: toDouble) double get unitPrice;@JsonKey(fromJson: toDouble) double get discountRate;@JsonKey(fromJson: toDouble) double get taxRate;@JsonKey(fromJson: toDouble) double get taxAmount;@JsonKey(fromJson: toDouble) double get total;
/// Create a copy of InvoiceLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceLineCopyWith<InvoiceLine> get copyWith => _$InvoiceLineCopyWithImpl<InvoiceLine>(this as InvoiceLine, _$identity);

  /// Serializes this InvoiceLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceLine&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.discountRate, discountRate) || other.discountRate == discountRate)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,quantity,unitPrice,discountRate,taxRate,taxAmount,total);

@override
String toString() {
  return 'InvoiceLine(id: $id, description: $description, quantity: $quantity, unitPrice: $unitPrice, discountRate: $discountRate, taxRate: $taxRate, taxAmount: $taxAmount, total: $total)';
}


}

/// @nodoc
abstract mixin class $InvoiceLineCopyWith<$Res>  {
  factory $InvoiceLineCopyWith(InvoiceLine value, $Res Function(InvoiceLine) _then) = _$InvoiceLineCopyWithImpl;
@useResult
$Res call({
 int id, String description,@JsonKey(fromJson: toDouble) double quantity,@JsonKey(fromJson: toDouble) double unitPrice,@JsonKey(fromJson: toDouble) double discountRate,@JsonKey(fromJson: toDouble) double taxRate,@JsonKey(fromJson: toDouble) double taxAmount,@JsonKey(fromJson: toDouble) double total
});




}
/// @nodoc
class _$InvoiceLineCopyWithImpl<$Res>
    implements $InvoiceLineCopyWith<$Res> {
  _$InvoiceLineCopyWithImpl(this._self, this._then);

  final InvoiceLine _self;
  final $Res Function(InvoiceLine) _then;

/// Create a copy of InvoiceLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? quantity = null,Object? unitPrice = null,Object? discountRate = null,Object? taxRate = null,Object? taxAmount = null,Object? total = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [InvoiceLine].
extension InvoiceLinePatterns on InvoiceLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceLine value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceLine value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String description, @JsonKey(fromJson: toDouble)  double quantity, @JsonKey(fromJson: toDouble)  double unitPrice, @JsonKey(fromJson: toDouble)  double discountRate, @JsonKey(fromJson: toDouble)  double taxRate, @JsonKey(fromJson: toDouble)  double taxAmount, @JsonKey(fromJson: toDouble)  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceLine() when $default != null:
return $default(_that.id,_that.description,_that.quantity,_that.unitPrice,_that.discountRate,_that.taxRate,_that.taxAmount,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String description, @JsonKey(fromJson: toDouble)  double quantity, @JsonKey(fromJson: toDouble)  double unitPrice, @JsonKey(fromJson: toDouble)  double discountRate, @JsonKey(fromJson: toDouble)  double taxRate, @JsonKey(fromJson: toDouble)  double taxAmount, @JsonKey(fromJson: toDouble)  double total)  $default,) {final _that = this;
switch (_that) {
case _InvoiceLine():
return $default(_that.id,_that.description,_that.quantity,_that.unitPrice,_that.discountRate,_that.taxRate,_that.taxAmount,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String description, @JsonKey(fromJson: toDouble)  double quantity, @JsonKey(fromJson: toDouble)  double unitPrice, @JsonKey(fromJson: toDouble)  double discountRate, @JsonKey(fromJson: toDouble)  double taxRate, @JsonKey(fromJson: toDouble)  double taxAmount, @JsonKey(fromJson: toDouble)  double total)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceLine() when $default != null:
return $default(_that.id,_that.description,_that.quantity,_that.unitPrice,_that.discountRate,_that.taxRate,_that.taxAmount,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceLine implements InvoiceLine {
  const _InvoiceLine({required this.id, required this.description, @JsonKey(fromJson: toDouble) required this.quantity, @JsonKey(fromJson: toDouble) required this.unitPrice, @JsonKey(fromJson: toDouble) required this.discountRate, @JsonKey(fromJson: toDouble) required this.taxRate, @JsonKey(fromJson: toDouble) required this.taxAmount, @JsonKey(fromJson: toDouble) required this.total});
  factory _InvoiceLine.fromJson(Map<String, dynamic> json) => _$InvoiceLineFromJson(json);

@override final  int id;
@override final  String description;
@override@JsonKey(fromJson: toDouble) final  double quantity;
@override@JsonKey(fromJson: toDouble) final  double unitPrice;
@override@JsonKey(fromJson: toDouble) final  double discountRate;
@override@JsonKey(fromJson: toDouble) final  double taxRate;
@override@JsonKey(fromJson: toDouble) final  double taxAmount;
@override@JsonKey(fromJson: toDouble) final  double total;

/// Create a copy of InvoiceLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceLineCopyWith<_InvoiceLine> get copyWith => __$InvoiceLineCopyWithImpl<_InvoiceLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceLine&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.discountRate, discountRate) || other.discountRate == discountRate)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description,quantity,unitPrice,discountRate,taxRate,taxAmount,total);

@override
String toString() {
  return 'InvoiceLine(id: $id, description: $description, quantity: $quantity, unitPrice: $unitPrice, discountRate: $discountRate, taxRate: $taxRate, taxAmount: $taxAmount, total: $total)';
}


}

/// @nodoc
abstract mixin class _$InvoiceLineCopyWith<$Res> implements $InvoiceLineCopyWith<$Res> {
  factory _$InvoiceLineCopyWith(_InvoiceLine value, $Res Function(_InvoiceLine) _then) = __$InvoiceLineCopyWithImpl;
@override @useResult
$Res call({
 int id, String description,@JsonKey(fromJson: toDouble) double quantity,@JsonKey(fromJson: toDouble) double unitPrice,@JsonKey(fromJson: toDouble) double discountRate,@JsonKey(fromJson: toDouble) double taxRate,@JsonKey(fromJson: toDouble) double taxAmount,@JsonKey(fromJson: toDouble) double total
});




}
/// @nodoc
class __$InvoiceLineCopyWithImpl<$Res>
    implements _$InvoiceLineCopyWith<$Res> {
  __$InvoiceLineCopyWithImpl(this._self, this._then);

  final _InvoiceLine _self;
  final $Res Function(_InvoiceLine) _then;

/// Create a copy of InvoiceLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? quantity = null,Object? unitPrice = null,Object? discountRate = null,Object? taxRate = null,Object? taxAmount = null,Object? total = null,}) {
  return _then(_InvoiceLine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
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
