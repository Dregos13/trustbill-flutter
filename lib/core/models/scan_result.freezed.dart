// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OcrLineItem _$OcrLineItemFromJson(Map<String, dynamic> json) {
  return _OcrLineItem.fromJson(json);
}

/// @nodoc
mixin _$OcrLineItem {
  String get description => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  /// Serializes this OcrLineItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OcrLineItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OcrLineItemCopyWith<OcrLineItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OcrLineItemCopyWith<$Res> {
  factory $OcrLineItemCopyWith(
    OcrLineItem value,
    $Res Function(OcrLineItem) then,
  ) = _$OcrLineItemCopyWithImpl<$Res, OcrLineItem>;
  @useResult
  $Res call({
    String description,
    double quantity,
    double unitPrice,
    double taxRate,
    double total,
  });
}

/// @nodoc
class _$OcrLineItemCopyWithImpl<$Res, $Val extends OcrLineItem>
    implements $OcrLineItemCopyWith<$Res> {
  _$OcrLineItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OcrLineItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? taxRate = null,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            taxRate: null == taxRate
                ? _value.taxRate
                : taxRate // ignore: cast_nullable_to_non_nullable
                      as double,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OcrLineItemImplCopyWith<$Res>
    implements $OcrLineItemCopyWith<$Res> {
  factory _$$OcrLineItemImplCopyWith(
    _$OcrLineItemImpl value,
    $Res Function(_$OcrLineItemImpl) then,
  ) = __$$OcrLineItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String description,
    double quantity,
    double unitPrice,
    double taxRate,
    double total,
  });
}

/// @nodoc
class __$$OcrLineItemImplCopyWithImpl<$Res>
    extends _$OcrLineItemCopyWithImpl<$Res, _$OcrLineItemImpl>
    implements _$$OcrLineItemImplCopyWith<$Res> {
  __$$OcrLineItemImplCopyWithImpl(
    _$OcrLineItemImpl _value,
    $Res Function(_$OcrLineItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OcrLineItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? taxRate = null,
    Object? total = null,
  }) {
    return _then(
      _$OcrLineItemImpl(
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        taxRate: null == taxRate
            ? _value.taxRate
            : taxRate // ignore: cast_nullable_to_non_nullable
                  as double,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OcrLineItemImpl implements _OcrLineItem {
  const _$OcrLineItemImpl({
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
    required this.total,
  });

  factory _$OcrLineItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OcrLineItemImplFromJson(json);

  @override
  final String description;
  @override
  final double quantity;
  @override
  final double unitPrice;
  @override
  final double taxRate;
  @override
  final double total;

  @override
  String toString() {
    return 'OcrLineItem(description: $description, quantity: $quantity, unitPrice: $unitPrice, taxRate: $taxRate, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OcrLineItemImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    description,
    quantity,
    unitPrice,
    taxRate,
    total,
  );

  /// Create a copy of OcrLineItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OcrLineItemImplCopyWith<_$OcrLineItemImpl> get copyWith =>
      __$$OcrLineItemImplCopyWithImpl<_$OcrLineItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OcrLineItemImplToJson(this);
  }
}

abstract class _OcrLineItem implements OcrLineItem {
  const factory _OcrLineItem({
    required final String description,
    required final double quantity,
    required final double unitPrice,
    required final double taxRate,
    required final double total,
  }) = _$OcrLineItemImpl;

  factory _OcrLineItem.fromJson(Map<String, dynamic> json) =
      _$OcrLineItemImpl.fromJson;

  @override
  String get description;
  @override
  double get quantity;
  @override
  double get unitPrice;
  @override
  double get taxRate;
  @override
  double get total;

  /// Create a copy of OcrLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OcrLineItemImplCopyWith<_$OcrLineItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScanResult _$ScanResultFromJson(Map<String, dynamic> json) {
  return _ScanResult.fromJson(json);
}

/// @nodoc
mixin _$ScanResult {
  String? get supplierName => throw _privateConstructorUsedError;
  String? get supplierCif => throw _privateConstructorUsedError;
  String? get supplierAddress => throw _privateConstructorUsedError;
  String? get supplierPhone => throw _privateConstructorUsedError;
  String? get invoiceNumber => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  String? get dueDate => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  List<OcrLineItem> get lines => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  double get taxAmount => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  /// Serializes this ScanResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanResultCopyWith<ScanResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanResultCopyWith<$Res> {
  factory $ScanResultCopyWith(
    ScanResult value,
    $Res Function(ScanResult) then,
  ) = _$ScanResultCopyWithImpl<$Res, ScanResult>;
  @useResult
  $Res call({
    String? supplierName,
    String? supplierCif,
    String? supplierAddress,
    String? supplierPhone,
    String? invoiceNumber,
    String? date,
    String? dueDate,
    String currency,
    List<OcrLineItem> lines,
    double subtotal,
    double taxAmount,
    double total,
    double confidence,
  });
}

/// @nodoc
class _$ScanResultCopyWithImpl<$Res, $Val extends ScanResult>
    implements $ScanResultCopyWith<$Res> {
  _$ScanResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supplierName = freezed,
    Object? supplierCif = freezed,
    Object? supplierAddress = freezed,
    Object? supplierPhone = freezed,
    Object? invoiceNumber = freezed,
    Object? date = freezed,
    Object? dueDate = freezed,
    Object? currency = null,
    Object? lines = null,
    Object? subtotal = null,
    Object? taxAmount = null,
    Object? total = null,
    Object? confidence = null,
  }) {
    return _then(
      _value.copyWith(
            supplierName: freezed == supplierName
                ? _value.supplierName
                : supplierName // ignore: cast_nullable_to_non_nullable
                      as String?,
            supplierCif: freezed == supplierCif
                ? _value.supplierCif
                : supplierCif // ignore: cast_nullable_to_non_nullable
                      as String?,
            supplierAddress: freezed == supplierAddress
                ? _value.supplierAddress
                : supplierAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            supplierPhone: freezed == supplierPhone
                ? _value.supplierPhone
                : supplierPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            invoiceNumber: freezed == invoiceNumber
                ? _value.invoiceNumber
                : invoiceNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String?,
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            lines: null == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<OcrLineItem>,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as double,
            taxAmount: null == taxAmount
                ? _value.taxAmount
                : taxAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScanResultImplCopyWith<$Res>
    implements $ScanResultCopyWith<$Res> {
  factory _$$ScanResultImplCopyWith(
    _$ScanResultImpl value,
    $Res Function(_$ScanResultImpl) then,
  ) = __$$ScanResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? supplierName,
    String? supplierCif,
    String? supplierAddress,
    String? supplierPhone,
    String? invoiceNumber,
    String? date,
    String? dueDate,
    String currency,
    List<OcrLineItem> lines,
    double subtotal,
    double taxAmount,
    double total,
    double confidence,
  });
}

/// @nodoc
class __$$ScanResultImplCopyWithImpl<$Res>
    extends _$ScanResultCopyWithImpl<$Res, _$ScanResultImpl>
    implements _$$ScanResultImplCopyWith<$Res> {
  __$$ScanResultImplCopyWithImpl(
    _$ScanResultImpl _value,
    $Res Function(_$ScanResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supplierName = freezed,
    Object? supplierCif = freezed,
    Object? supplierAddress = freezed,
    Object? supplierPhone = freezed,
    Object? invoiceNumber = freezed,
    Object? date = freezed,
    Object? dueDate = freezed,
    Object? currency = null,
    Object? lines = null,
    Object? subtotal = null,
    Object? taxAmount = null,
    Object? total = null,
    Object? confidence = null,
  }) {
    return _then(
      _$ScanResultImpl(
        supplierName: freezed == supplierName
            ? _value.supplierName
            : supplierName // ignore: cast_nullable_to_non_nullable
                  as String?,
        supplierCif: freezed == supplierCif
            ? _value.supplierCif
            : supplierCif // ignore: cast_nullable_to_non_nullable
                  as String?,
        supplierAddress: freezed == supplierAddress
            ? _value.supplierAddress
            : supplierAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        supplierPhone: freezed == supplierPhone
            ? _value.supplierPhone
            : supplierPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        invoiceNumber: freezed == invoiceNumber
            ? _value.invoiceNumber
            : invoiceNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        lines: null == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<OcrLineItem>,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as double,
        taxAmount: null == taxAmount
            ? _value.taxAmount
            : taxAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScanResultImpl implements _ScanResult {
  const _$ScanResultImpl({
    this.supplierName,
    this.supplierCif,
    this.supplierAddress,
    this.supplierPhone,
    this.invoiceNumber,
    this.date,
    this.dueDate,
    this.currency = 'EUR',
    final List<OcrLineItem> lines = const [],
    this.subtotal = 0,
    this.taxAmount = 0,
    this.total = 0,
    this.confidence = 0,
  }) : _lines = lines;

  factory _$ScanResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanResultImplFromJson(json);

  @override
  final String? supplierName;
  @override
  final String? supplierCif;
  @override
  final String? supplierAddress;
  @override
  final String? supplierPhone;
  @override
  final String? invoiceNumber;
  @override
  final String? date;
  @override
  final String? dueDate;
  @override
  @JsonKey()
  final String currency;
  final List<OcrLineItem> _lines;
  @override
  @JsonKey()
  List<OcrLineItem> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  @JsonKey()
  final double subtotal;
  @override
  @JsonKey()
  final double taxAmount;
  @override
  @JsonKey()
  final double total;
  @override
  @JsonKey()
  final double confidence;

  @override
  String toString() {
    return 'ScanResult(supplierName: $supplierName, supplierCif: $supplierCif, supplierAddress: $supplierAddress, supplierPhone: $supplierPhone, invoiceNumber: $invoiceNumber, date: $date, dueDate: $dueDate, currency: $currency, lines: $lines, subtotal: $subtotal, taxAmount: $taxAmount, total: $total, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanResultImpl &&
            (identical(other.supplierName, supplierName) ||
                other.supplierName == supplierName) &&
            (identical(other.supplierCif, supplierCif) ||
                other.supplierCif == supplierCif) &&
            (identical(other.supplierAddress, supplierAddress) ||
                other.supplierAddress == supplierAddress) &&
            (identical(other.supplierPhone, supplierPhone) ||
                other.supplierPhone == supplierPhone) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    supplierName,
    supplierCif,
    supplierAddress,
    supplierPhone,
    invoiceNumber,
    date,
    dueDate,
    currency,
    const DeepCollectionEquality().hash(_lines),
    subtotal,
    taxAmount,
    total,
    confidence,
  );

  /// Create a copy of ScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanResultImplCopyWith<_$ScanResultImpl> get copyWith =>
      __$$ScanResultImplCopyWithImpl<_$ScanResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanResultImplToJson(this);
  }
}

abstract class _ScanResult implements ScanResult {
  const factory _ScanResult({
    final String? supplierName,
    final String? supplierCif,
    final String? supplierAddress,
    final String? supplierPhone,
    final String? invoiceNumber,
    final String? date,
    final String? dueDate,
    final String currency,
    final List<OcrLineItem> lines,
    final double subtotal,
    final double taxAmount,
    final double total,
    final double confidence,
  }) = _$ScanResultImpl;

  factory _ScanResult.fromJson(Map<String, dynamic> json) =
      _$ScanResultImpl.fromJson;

  @override
  String? get supplierName;
  @override
  String? get supplierCif;
  @override
  String? get supplierAddress;
  @override
  String? get supplierPhone;
  @override
  String? get invoiceNumber;
  @override
  String? get date;
  @override
  String? get dueDate;
  @override
  String get currency;
  @override
  List<OcrLineItem> get lines;
  @override
  double get subtotal;
  @override
  double get taxAmount;
  @override
  double get total;
  @override
  double get confidence;

  /// Create a copy of ScanResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanResultImplCopyWith<_$ScanResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
