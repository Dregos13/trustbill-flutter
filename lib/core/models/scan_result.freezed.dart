// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OcrLineItem {

 String get description; double get quantity; double get unitPrice; double get taxRate; double get total;
/// Create a copy of OcrLineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrLineItemCopyWith<OcrLineItem> get copyWith => _$OcrLineItemCopyWithImpl<OcrLineItem>(this as OcrLineItem, _$identity);

  /// Serializes this OcrLineItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrLineItem&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,quantity,unitPrice,taxRate,total);

@override
String toString() {
  return 'OcrLineItem(description: $description, quantity: $quantity, unitPrice: $unitPrice, taxRate: $taxRate, total: $total)';
}


}

/// @nodoc
abstract mixin class $OcrLineItemCopyWith<$Res>  {
  factory $OcrLineItemCopyWith(OcrLineItem value, $Res Function(OcrLineItem) _then) = _$OcrLineItemCopyWithImpl;
@useResult
$Res call({
 String description, double quantity, double unitPrice, double taxRate, double total
});




}
/// @nodoc
class _$OcrLineItemCopyWithImpl<$Res>
    implements $OcrLineItemCopyWith<$Res> {
  _$OcrLineItemCopyWithImpl(this._self, this._then);

  final OcrLineItem _self;
  final $Res Function(OcrLineItem) _then;

/// Create a copy of OcrLineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? quantity = null,Object? unitPrice = null,Object? taxRate = null,Object? total = null,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OcrLineItem].
extension OcrLineItemPatterns on OcrLineItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrLineItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrLineItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrLineItem value)  $default,){
final _that = this;
switch (_that) {
case _OcrLineItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrLineItem value)?  $default,){
final _that = this;
switch (_that) {
case _OcrLineItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description,  double quantity,  double unitPrice,  double taxRate,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrLineItem() when $default != null:
return $default(_that.description,_that.quantity,_that.unitPrice,_that.taxRate,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description,  double quantity,  double unitPrice,  double taxRate,  double total)  $default,) {final _that = this;
switch (_that) {
case _OcrLineItem():
return $default(_that.description,_that.quantity,_that.unitPrice,_that.taxRate,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description,  double quantity,  double unitPrice,  double taxRate,  double total)?  $default,) {final _that = this;
switch (_that) {
case _OcrLineItem() when $default != null:
return $default(_that.description,_that.quantity,_that.unitPrice,_that.taxRate,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OcrLineItem implements OcrLineItem {
  const _OcrLineItem({required this.description, required this.quantity, required this.unitPrice, required this.taxRate, required this.total});
  factory _OcrLineItem.fromJson(Map<String, dynamic> json) => _$OcrLineItemFromJson(json);

@override final  String description;
@override final  double quantity;
@override final  double unitPrice;
@override final  double taxRate;
@override final  double total;

/// Create a copy of OcrLineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrLineItemCopyWith<_OcrLineItem> get copyWith => __$OcrLineItemCopyWithImpl<_OcrLineItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OcrLineItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrLineItem&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,quantity,unitPrice,taxRate,total);

@override
String toString() {
  return 'OcrLineItem(description: $description, quantity: $quantity, unitPrice: $unitPrice, taxRate: $taxRate, total: $total)';
}


}

/// @nodoc
abstract mixin class _$OcrLineItemCopyWith<$Res> implements $OcrLineItemCopyWith<$Res> {
  factory _$OcrLineItemCopyWith(_OcrLineItem value, $Res Function(_OcrLineItem) _then) = __$OcrLineItemCopyWithImpl;
@override @useResult
$Res call({
 String description, double quantity, double unitPrice, double taxRate, double total
});




}
/// @nodoc
class __$OcrLineItemCopyWithImpl<$Res>
    implements _$OcrLineItemCopyWith<$Res> {
  __$OcrLineItemCopyWithImpl(this._self, this._then);

  final _OcrLineItem _self;
  final $Res Function(_OcrLineItem) _then;

/// Create a copy of OcrLineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? quantity = null,Object? unitPrice = null,Object? taxRate = null,Object? total = null,}) {
  return _then(_OcrLineItem(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ScanResult {

 String? get supplierName; String? get supplierCif; String? get supplierAddress; String? get supplierPhone; String? get invoiceNumber; String? get date; String? get dueDate; String get currency; List<OcrLineItem> get lines; double get subtotal; double get taxAmount; double get total; double get confidence;
/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanResultCopyWith<ScanResult> get copyWith => _$ScanResultCopyWithImpl<ScanResult>(this as ScanResult, _$identity);

  /// Serializes this ScanResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanResult&&(identical(other.supplierName, supplierName) || other.supplierName == supplierName)&&(identical(other.supplierCif, supplierCif) || other.supplierCif == supplierCif)&&(identical(other.supplierAddress, supplierAddress) || other.supplierAddress == supplierAddress)&&(identical(other.supplierPhone, supplierPhone) || other.supplierPhone == supplierPhone)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.date, date) || other.date == date)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.total, total) || other.total == total)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,supplierName,supplierCif,supplierAddress,supplierPhone,invoiceNumber,date,dueDate,currency,const DeepCollectionEquality().hash(lines),subtotal,taxAmount,total,confidence);

@override
String toString() {
  return 'ScanResult(supplierName: $supplierName, supplierCif: $supplierCif, supplierAddress: $supplierAddress, supplierPhone: $supplierPhone, invoiceNumber: $invoiceNumber, date: $date, dueDate: $dueDate, currency: $currency, lines: $lines, subtotal: $subtotal, taxAmount: $taxAmount, total: $total, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $ScanResultCopyWith<$Res>  {
  factory $ScanResultCopyWith(ScanResult value, $Res Function(ScanResult) _then) = _$ScanResultCopyWithImpl;
@useResult
$Res call({
 String? supplierName, String? supplierCif, String? supplierAddress, String? supplierPhone, String? invoiceNumber, String? date, String? dueDate, String currency, List<OcrLineItem> lines, double subtotal, double taxAmount, double total, double confidence
});




}
/// @nodoc
class _$ScanResultCopyWithImpl<$Res>
    implements $ScanResultCopyWith<$Res> {
  _$ScanResultCopyWithImpl(this._self, this._then);

  final ScanResult _self;
  final $Res Function(ScanResult) _then;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? supplierName = freezed,Object? supplierCif = freezed,Object? supplierAddress = freezed,Object? supplierPhone = freezed,Object? invoiceNumber = freezed,Object? date = freezed,Object? dueDate = freezed,Object? currency = null,Object? lines = null,Object? subtotal = null,Object? taxAmount = null,Object? total = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
supplierName: freezed == supplierName ? _self.supplierName : supplierName // ignore: cast_nullable_to_non_nullable
as String?,supplierCif: freezed == supplierCif ? _self.supplierCif : supplierCif // ignore: cast_nullable_to_non_nullable
as String?,supplierAddress: freezed == supplierAddress ? _self.supplierAddress : supplierAddress // ignore: cast_nullable_to_non_nullable
as String?,supplierPhone: freezed == supplierPhone ? _self.supplierPhone : supplierPhone // ignore: cast_nullable_to_non_nullable
as String?,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<OcrLineItem>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanResult].
extension ScanResultPatterns on ScanResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanResult value)  $default,){
final _that = this;
switch (_that) {
case _ScanResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanResult value)?  $default,){
final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? supplierName,  String? supplierCif,  String? supplierAddress,  String? supplierPhone,  String? invoiceNumber,  String? date,  String? dueDate,  String currency,  List<OcrLineItem> lines,  double subtotal,  double taxAmount,  double total,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
return $default(_that.supplierName,_that.supplierCif,_that.supplierAddress,_that.supplierPhone,_that.invoiceNumber,_that.date,_that.dueDate,_that.currency,_that.lines,_that.subtotal,_that.taxAmount,_that.total,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? supplierName,  String? supplierCif,  String? supplierAddress,  String? supplierPhone,  String? invoiceNumber,  String? date,  String? dueDate,  String currency,  List<OcrLineItem> lines,  double subtotal,  double taxAmount,  double total,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _ScanResult():
return $default(_that.supplierName,_that.supplierCif,_that.supplierAddress,_that.supplierPhone,_that.invoiceNumber,_that.date,_that.dueDate,_that.currency,_that.lines,_that.subtotal,_that.taxAmount,_that.total,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? supplierName,  String? supplierCif,  String? supplierAddress,  String? supplierPhone,  String? invoiceNumber,  String? date,  String? dueDate,  String currency,  List<OcrLineItem> lines,  double subtotal,  double taxAmount,  double total,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
return $default(_that.supplierName,_that.supplierCif,_that.supplierAddress,_that.supplierPhone,_that.invoiceNumber,_that.date,_that.dueDate,_that.currency,_that.lines,_that.subtotal,_that.taxAmount,_that.total,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanResult implements ScanResult {
  const _ScanResult({this.supplierName, this.supplierCif, this.supplierAddress, this.supplierPhone, this.invoiceNumber, this.date, this.dueDate, this.currency = 'EUR', final  List<OcrLineItem> lines = const [], this.subtotal = 0, this.taxAmount = 0, this.total = 0, this.confidence = 0}): _lines = lines;
  factory _ScanResult.fromJson(Map<String, dynamic> json) => _$ScanResultFromJson(json);

@override final  String? supplierName;
@override final  String? supplierCif;
@override final  String? supplierAddress;
@override final  String? supplierPhone;
@override final  String? invoiceNumber;
@override final  String? date;
@override final  String? dueDate;
@override@JsonKey() final  String currency;
 final  List<OcrLineItem> _lines;
@override@JsonKey() List<OcrLineItem> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override@JsonKey() final  double subtotal;
@override@JsonKey() final  double taxAmount;
@override@JsonKey() final  double total;
@override@JsonKey() final  double confidence;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanResultCopyWith<_ScanResult> get copyWith => __$ScanResultCopyWithImpl<_ScanResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanResult&&(identical(other.supplierName, supplierName) || other.supplierName == supplierName)&&(identical(other.supplierCif, supplierCif) || other.supplierCif == supplierCif)&&(identical(other.supplierAddress, supplierAddress) || other.supplierAddress == supplierAddress)&&(identical(other.supplierPhone, supplierPhone) || other.supplierPhone == supplierPhone)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber)&&(identical(other.date, date) || other.date == date)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.taxAmount, taxAmount) || other.taxAmount == taxAmount)&&(identical(other.total, total) || other.total == total)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,supplierName,supplierCif,supplierAddress,supplierPhone,invoiceNumber,date,dueDate,currency,const DeepCollectionEquality().hash(_lines),subtotal,taxAmount,total,confidence);

@override
String toString() {
  return 'ScanResult(supplierName: $supplierName, supplierCif: $supplierCif, supplierAddress: $supplierAddress, supplierPhone: $supplierPhone, invoiceNumber: $invoiceNumber, date: $date, dueDate: $dueDate, currency: $currency, lines: $lines, subtotal: $subtotal, taxAmount: $taxAmount, total: $total, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$ScanResultCopyWith<$Res> implements $ScanResultCopyWith<$Res> {
  factory _$ScanResultCopyWith(_ScanResult value, $Res Function(_ScanResult) _then) = __$ScanResultCopyWithImpl;
@override @useResult
$Res call({
 String? supplierName, String? supplierCif, String? supplierAddress, String? supplierPhone, String? invoiceNumber, String? date, String? dueDate, String currency, List<OcrLineItem> lines, double subtotal, double taxAmount, double total, double confidence
});




}
/// @nodoc
class __$ScanResultCopyWithImpl<$Res>
    implements _$ScanResultCopyWith<$Res> {
  __$ScanResultCopyWithImpl(this._self, this._then);

  final _ScanResult _self;
  final $Res Function(_ScanResult) _then;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? supplierName = freezed,Object? supplierCif = freezed,Object? supplierAddress = freezed,Object? supplierPhone = freezed,Object? invoiceNumber = freezed,Object? date = freezed,Object? dueDate = freezed,Object? currency = null,Object? lines = null,Object? subtotal = null,Object? taxAmount = null,Object? total = null,Object? confidence = null,}) {
  return _then(_ScanResult(
supplierName: freezed == supplierName ? _self.supplierName : supplierName // ignore: cast_nullable_to_non_nullable
as String?,supplierCif: freezed == supplierCif ? _self.supplierCif : supplierCif // ignore: cast_nullable_to_non_nullable
as String?,supplierAddress: freezed == supplierAddress ? _self.supplierAddress : supplierAddress // ignore: cast_nullable_to_non_nullable
as String?,supplierPhone: freezed == supplierPhone ? _self.supplierPhone : supplierPhone // ignore: cast_nullable_to_non_nullable
as String?,invoiceNumber: freezed == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as String?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<OcrLineItem>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,taxAmount: null == taxAmount ? _self.taxAmount : taxAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
