// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardSummary {

 int get invoicesThisMonth;@JsonKey(fromJson: toDouble) double get totalBilled;@JsonKey(fromJson: toDouble) double get totalCollected;@JsonKey(fromJson: toDouble) double get totalPending; List<DashboardInvoice> get recentInvoices;
/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardSummaryCopyWith<DashboardSummary> get copyWith => _$DashboardSummaryCopyWithImpl<DashboardSummary>(this as DashboardSummary, _$identity);

  /// Serializes this DashboardSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardSummary&&(identical(other.invoicesThisMonth, invoicesThisMonth) || other.invoicesThisMonth == invoicesThisMonth)&&(identical(other.totalBilled, totalBilled) || other.totalBilled == totalBilled)&&(identical(other.totalCollected, totalCollected) || other.totalCollected == totalCollected)&&(identical(other.totalPending, totalPending) || other.totalPending == totalPending)&&const DeepCollectionEquality().equals(other.recentInvoices, recentInvoices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,invoicesThisMonth,totalBilled,totalCollected,totalPending,const DeepCollectionEquality().hash(recentInvoices));

@override
String toString() {
  return 'DashboardSummary(invoicesThisMonth: $invoicesThisMonth, totalBilled: $totalBilled, totalCollected: $totalCollected, totalPending: $totalPending, recentInvoices: $recentInvoices)';
}


}

/// @nodoc
abstract mixin class $DashboardSummaryCopyWith<$Res>  {
  factory $DashboardSummaryCopyWith(DashboardSummary value, $Res Function(DashboardSummary) _then) = _$DashboardSummaryCopyWithImpl;
@useResult
$Res call({
 int invoicesThisMonth,@JsonKey(fromJson: toDouble) double totalBilled,@JsonKey(fromJson: toDouble) double totalCollected,@JsonKey(fromJson: toDouble) double totalPending, List<DashboardInvoice> recentInvoices
});




}
/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._self, this._then);

  final DashboardSummary _self;
  final $Res Function(DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? invoicesThisMonth = null,Object? totalBilled = null,Object? totalCollected = null,Object? totalPending = null,Object? recentInvoices = null,}) {
  return _then(_self.copyWith(
invoicesThisMonth: null == invoicesThisMonth ? _self.invoicesThisMonth : invoicesThisMonth // ignore: cast_nullable_to_non_nullable
as int,totalBilled: null == totalBilled ? _self.totalBilled : totalBilled // ignore: cast_nullable_to_non_nullable
as double,totalCollected: null == totalCollected ? _self.totalCollected : totalCollected // ignore: cast_nullable_to_non_nullable
as double,totalPending: null == totalPending ? _self.totalPending : totalPending // ignore: cast_nullable_to_non_nullable
as double,recentInvoices: null == recentInvoices ? _self.recentInvoices : recentInvoices // ignore: cast_nullable_to_non_nullable
as List<DashboardInvoice>,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardSummary].
extension DashboardSummaryPatterns on DashboardSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardSummary value)  $default,){
final _that = this;
switch (_that) {
case _DashboardSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int invoicesThisMonth, @JsonKey(fromJson: toDouble)  double totalBilled, @JsonKey(fromJson: toDouble)  double totalCollected, @JsonKey(fromJson: toDouble)  double totalPending,  List<DashboardInvoice> recentInvoices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that.invoicesThisMonth,_that.totalBilled,_that.totalCollected,_that.totalPending,_that.recentInvoices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int invoicesThisMonth, @JsonKey(fromJson: toDouble)  double totalBilled, @JsonKey(fromJson: toDouble)  double totalCollected, @JsonKey(fromJson: toDouble)  double totalPending,  List<DashboardInvoice> recentInvoices)  $default,) {final _that = this;
switch (_that) {
case _DashboardSummary():
return $default(_that.invoicesThisMonth,_that.totalBilled,_that.totalCollected,_that.totalPending,_that.recentInvoices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int invoicesThisMonth, @JsonKey(fromJson: toDouble)  double totalBilled, @JsonKey(fromJson: toDouble)  double totalCollected, @JsonKey(fromJson: toDouble)  double totalPending,  List<DashboardInvoice> recentInvoices)?  $default,) {final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that.invoicesThisMonth,_that.totalBilled,_that.totalCollected,_that.totalPending,_that.recentInvoices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardSummary implements DashboardSummary {
  const _DashboardSummary({required this.invoicesThisMonth, @JsonKey(fromJson: toDouble) required this.totalBilled, @JsonKey(fromJson: toDouble) required this.totalCollected, @JsonKey(fromJson: toDouble) required this.totalPending, required final  List<DashboardInvoice> recentInvoices}): _recentInvoices = recentInvoices;
  factory _DashboardSummary.fromJson(Map<String, dynamic> json) => _$DashboardSummaryFromJson(json);

@override final  int invoicesThisMonth;
@override@JsonKey(fromJson: toDouble) final  double totalBilled;
@override@JsonKey(fromJson: toDouble) final  double totalCollected;
@override@JsonKey(fromJson: toDouble) final  double totalPending;
 final  List<DashboardInvoice> _recentInvoices;
@override List<DashboardInvoice> get recentInvoices {
  if (_recentInvoices is EqualUnmodifiableListView) return _recentInvoices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentInvoices);
}


/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardSummaryCopyWith<_DashboardSummary> get copyWith => __$DashboardSummaryCopyWithImpl<_DashboardSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardSummary&&(identical(other.invoicesThisMonth, invoicesThisMonth) || other.invoicesThisMonth == invoicesThisMonth)&&(identical(other.totalBilled, totalBilled) || other.totalBilled == totalBilled)&&(identical(other.totalCollected, totalCollected) || other.totalCollected == totalCollected)&&(identical(other.totalPending, totalPending) || other.totalPending == totalPending)&&const DeepCollectionEquality().equals(other._recentInvoices, _recentInvoices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,invoicesThisMonth,totalBilled,totalCollected,totalPending,const DeepCollectionEquality().hash(_recentInvoices));

@override
String toString() {
  return 'DashboardSummary(invoicesThisMonth: $invoicesThisMonth, totalBilled: $totalBilled, totalCollected: $totalCollected, totalPending: $totalPending, recentInvoices: $recentInvoices)';
}


}

/// @nodoc
abstract mixin class _$DashboardSummaryCopyWith<$Res> implements $DashboardSummaryCopyWith<$Res> {
  factory _$DashboardSummaryCopyWith(_DashboardSummary value, $Res Function(_DashboardSummary) _then) = __$DashboardSummaryCopyWithImpl;
@override @useResult
$Res call({
 int invoicesThisMonth,@JsonKey(fromJson: toDouble) double totalBilled,@JsonKey(fromJson: toDouble) double totalCollected,@JsonKey(fromJson: toDouble) double totalPending, List<DashboardInvoice> recentInvoices
});




}
/// @nodoc
class __$DashboardSummaryCopyWithImpl<$Res>
    implements _$DashboardSummaryCopyWith<$Res> {
  __$DashboardSummaryCopyWithImpl(this._self, this._then);

  final _DashboardSummary _self;
  final $Res Function(_DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invoicesThisMonth = null,Object? totalBilled = null,Object? totalCollected = null,Object? totalPending = null,Object? recentInvoices = null,}) {
  return _then(_DashboardSummary(
invoicesThisMonth: null == invoicesThisMonth ? _self.invoicesThisMonth : invoicesThisMonth // ignore: cast_nullable_to_non_nullable
as int,totalBilled: null == totalBilled ? _self.totalBilled : totalBilled // ignore: cast_nullable_to_non_nullable
as double,totalCollected: null == totalCollected ? _self.totalCollected : totalCollected // ignore: cast_nullable_to_non_nullable
as double,totalPending: null == totalPending ? _self.totalPending : totalPending // ignore: cast_nullable_to_non_nullable
as double,recentInvoices: null == recentInvoices ? _self._recentInvoices : recentInvoices // ignore: cast_nullable_to_non_nullable
as List<DashboardInvoice>,
  ));
}


}


/// @nodoc
mixin _$DashboardInvoice {

 int get id; String get series; int get number; String get status;@JsonKey(fromJson: toDouble) double get total; String? get clientName; String? get issuedAt;
/// Create a copy of DashboardInvoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardInvoiceCopyWith<DashboardInvoice> get copyWith => _$DashboardInvoiceCopyWithImpl<DashboardInvoice>(this as DashboardInvoice, _$identity);

  /// Serializes this DashboardInvoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardInvoice&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.total, total) || other.total == total)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,status,total,clientName,issuedAt);

@override
String toString() {
  return 'DashboardInvoice(id: $id, series: $series, number: $number, status: $status, total: $total, clientName: $clientName, issuedAt: $issuedAt)';
}


}

/// @nodoc
abstract mixin class $DashboardInvoiceCopyWith<$Res>  {
  factory $DashboardInvoiceCopyWith(DashboardInvoice value, $Res Function(DashboardInvoice) _then) = _$DashboardInvoiceCopyWithImpl;
@useResult
$Res call({
 int id, String series, int number, String status,@JsonKey(fromJson: toDouble) double total, String? clientName, String? issuedAt
});




}
/// @nodoc
class _$DashboardInvoiceCopyWithImpl<$Res>
    implements $DashboardInvoiceCopyWith<$Res> {
  _$DashboardInvoiceCopyWithImpl(this._self, this._then);

  final DashboardInvoice _self;
  final $Res Function(DashboardInvoice) _then;

/// Create a copy of DashboardInvoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? series = null,Object? number = null,Object? status = null,Object? total = null,Object? clientName = freezed,Object? issuedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardInvoice].
extension DashboardInvoicePatterns on DashboardInvoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardInvoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardInvoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardInvoice value)  $default,){
final _that = this;
switch (_that) {
case _DashboardInvoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardInvoice value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardInvoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String status, @JsonKey(fromJson: toDouble)  double total,  String? clientName,  String? issuedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardInvoice() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.status,_that.total,_that.clientName,_that.issuedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String series,  int number,  String status, @JsonKey(fromJson: toDouble)  double total,  String? clientName,  String? issuedAt)  $default,) {final _that = this;
switch (_that) {
case _DashboardInvoice():
return $default(_that.id,_that.series,_that.number,_that.status,_that.total,_that.clientName,_that.issuedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String series,  int number,  String status, @JsonKey(fromJson: toDouble)  double total,  String? clientName,  String? issuedAt)?  $default,) {final _that = this;
switch (_that) {
case _DashboardInvoice() when $default != null:
return $default(_that.id,_that.series,_that.number,_that.status,_that.total,_that.clientName,_that.issuedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardInvoice implements DashboardInvoice {
  const _DashboardInvoice({required this.id, required this.series, required this.number, required this.status, @JsonKey(fromJson: toDouble) required this.total, this.clientName, this.issuedAt});
  factory _DashboardInvoice.fromJson(Map<String, dynamic> json) => _$DashboardInvoiceFromJson(json);

@override final  int id;
@override final  String series;
@override final  int number;
@override final  String status;
@override@JsonKey(fromJson: toDouble) final  double total;
@override final  String? clientName;
@override final  String? issuedAt;

/// Create a copy of DashboardInvoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardInvoiceCopyWith<_DashboardInvoice> get copyWith => __$DashboardInvoiceCopyWithImpl<_DashboardInvoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardInvoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardInvoice&&(identical(other.id, id) || other.id == id)&&(identical(other.series, series) || other.series == series)&&(identical(other.number, number) || other.number == number)&&(identical(other.status, status) || other.status == status)&&(identical(other.total, total) || other.total == total)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,series,number,status,total,clientName,issuedAt);

@override
String toString() {
  return 'DashboardInvoice(id: $id, series: $series, number: $number, status: $status, total: $total, clientName: $clientName, issuedAt: $issuedAt)';
}


}

/// @nodoc
abstract mixin class _$DashboardInvoiceCopyWith<$Res> implements $DashboardInvoiceCopyWith<$Res> {
  factory _$DashboardInvoiceCopyWith(_DashboardInvoice value, $Res Function(_DashboardInvoice) _then) = __$DashboardInvoiceCopyWithImpl;
@override @useResult
$Res call({
 int id, String series, int number, String status,@JsonKey(fromJson: toDouble) double total, String? clientName, String? issuedAt
});




}
/// @nodoc
class __$DashboardInvoiceCopyWithImpl<$Res>
    implements _$DashboardInvoiceCopyWith<$Res> {
  __$DashboardInvoiceCopyWithImpl(this._self, this._then);

  final _DashboardInvoice _self;
  final $Res Function(_DashboardInvoice) _then;

/// Create a copy of DashboardInvoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? series = null,Object? number = null,Object? status = null,Object? total = null,Object? clientName = freezed,Object? issuedAt = freezed,}) {
  return _then(_DashboardInvoice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
