// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExpenseConfirmPayload _$ExpenseConfirmPayloadFromJson(
  Map<String, dynamic> json,
) {
  return _ExpenseConfirmPayload.fromJson(json);
}

/// @nodoc
mixin _$ExpenseConfirmPayload {
  String get supplierName => throw _privateConstructorUsedError;
  String get supplierCif => throw _privateConstructorUsedError;
  String? get supplierAddress => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get baseAmount => throw _privateConstructorUsedError;
  String? get taxKind => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  double get vatAmount => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  String get imageBase64 => throw _privateConstructorUsedError;
  String get imageMimeType => throw _privateConstructorUsedError;

  /// Serializes this ExpenseConfirmPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseConfirmPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseConfirmPayloadCopyWith<ExpenseConfirmPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseConfirmPayloadCopyWith<$Res> {
  factory $ExpenseConfirmPayloadCopyWith(
    ExpenseConfirmPayload value,
    $Res Function(ExpenseConfirmPayload) then,
  ) = _$ExpenseConfirmPayloadCopyWithImpl<$Res, ExpenseConfirmPayload>;
  @useResult
  $Res call({
    String supplierName,
    String supplierCif,
    String? supplierAddress,
    String date,
    String category,
    String description,
    double baseAmount,
    String? taxKind,
    double taxRate,
    double vatAmount,
    double totalAmount,
    String imageBase64,
    String imageMimeType,
  });
}

/// @nodoc
class _$ExpenseConfirmPayloadCopyWithImpl<
  $Res,
  $Val extends ExpenseConfirmPayload
>
    implements $ExpenseConfirmPayloadCopyWith<$Res> {
  _$ExpenseConfirmPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseConfirmPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supplierName = null,
    Object? supplierCif = null,
    Object? supplierAddress = freezed,
    Object? date = null,
    Object? category = null,
    Object? description = null,
    Object? baseAmount = null,
    Object? taxKind = freezed,
    Object? taxRate = null,
    Object? vatAmount = null,
    Object? totalAmount = null,
    Object? imageBase64 = null,
    Object? imageMimeType = null,
  }) {
    return _then(
      _value.copyWith(
            supplierName: null == supplierName
                ? _value.supplierName
                : supplierName // ignore: cast_nullable_to_non_nullable
                      as String,
            supplierCif: null == supplierCif
                ? _value.supplierCif
                : supplierCif // ignore: cast_nullable_to_non_nullable
                      as String,
            supplierAddress: freezed == supplierAddress
                ? _value.supplierAddress
                : supplierAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            baseAmount: null == baseAmount
                ? _value.baseAmount
                : baseAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            taxKind: freezed == taxKind
                ? _value.taxKind
                : taxKind // ignore: cast_nullable_to_non_nullable
                      as String?,
            taxRate: null == taxRate
                ? _value.taxRate
                : taxRate // ignore: cast_nullable_to_non_nullable
                      as double,
            vatAmount: null == vatAmount
                ? _value.vatAmount
                : vatAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            imageBase64: null == imageBase64
                ? _value.imageBase64
                : imageBase64 // ignore: cast_nullable_to_non_nullable
                      as String,
            imageMimeType: null == imageMimeType
                ? _value.imageMimeType
                : imageMimeType // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpenseConfirmPayloadImplCopyWith<$Res>
    implements $ExpenseConfirmPayloadCopyWith<$Res> {
  factory _$$ExpenseConfirmPayloadImplCopyWith(
    _$ExpenseConfirmPayloadImpl value,
    $Res Function(_$ExpenseConfirmPayloadImpl) then,
  ) = __$$ExpenseConfirmPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String supplierName,
    String supplierCif,
    String? supplierAddress,
    String date,
    String category,
    String description,
    double baseAmount,
    String? taxKind,
    double taxRate,
    double vatAmount,
    double totalAmount,
    String imageBase64,
    String imageMimeType,
  });
}

/// @nodoc
class __$$ExpenseConfirmPayloadImplCopyWithImpl<$Res>
    extends
        _$ExpenseConfirmPayloadCopyWithImpl<$Res, _$ExpenseConfirmPayloadImpl>
    implements _$$ExpenseConfirmPayloadImplCopyWith<$Res> {
  __$$ExpenseConfirmPayloadImplCopyWithImpl(
    _$ExpenseConfirmPayloadImpl _value,
    $Res Function(_$ExpenseConfirmPayloadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseConfirmPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supplierName = null,
    Object? supplierCif = null,
    Object? supplierAddress = freezed,
    Object? date = null,
    Object? category = null,
    Object? description = null,
    Object? baseAmount = null,
    Object? taxKind = freezed,
    Object? taxRate = null,
    Object? vatAmount = null,
    Object? totalAmount = null,
    Object? imageBase64 = null,
    Object? imageMimeType = null,
  }) {
    return _then(
      _$ExpenseConfirmPayloadImpl(
        supplierName: null == supplierName
            ? _value.supplierName
            : supplierName // ignore: cast_nullable_to_non_nullable
                  as String,
        supplierCif: null == supplierCif
            ? _value.supplierCif
            : supplierCif // ignore: cast_nullable_to_non_nullable
                  as String,
        supplierAddress: freezed == supplierAddress
            ? _value.supplierAddress
            : supplierAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        baseAmount: null == baseAmount
            ? _value.baseAmount
            : baseAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        taxKind: freezed == taxKind
            ? _value.taxKind
            : taxKind // ignore: cast_nullable_to_non_nullable
                  as String?,
        taxRate: null == taxRate
            ? _value.taxRate
            : taxRate // ignore: cast_nullable_to_non_nullable
                  as double,
        vatAmount: null == vatAmount
            ? _value.vatAmount
            : vatAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        imageBase64: null == imageBase64
            ? _value.imageBase64
            : imageBase64 // ignore: cast_nullable_to_non_nullable
                  as String,
        imageMimeType: null == imageMimeType
            ? _value.imageMimeType
            : imageMimeType // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseConfirmPayloadImpl implements _ExpenseConfirmPayload {
  const _$ExpenseConfirmPayloadImpl({
    required this.supplierName,
    this.supplierCif = '',
    this.supplierAddress,
    required this.date,
    this.category = 'OTHER',
    required this.description,
    required this.baseAmount,
    this.taxKind,
    this.taxRate = 0,
    this.vatAmount = 0,
    required this.totalAmount,
    required this.imageBase64,
    required this.imageMimeType,
  });

  factory _$ExpenseConfirmPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseConfirmPayloadImplFromJson(json);

  @override
  final String supplierName;
  @override
  @JsonKey()
  final String supplierCif;
  @override
  final String? supplierAddress;
  @override
  final String date;
  @override
  @JsonKey()
  final String category;
  @override
  final String description;
  @override
  final double baseAmount;
  @override
  final String? taxKind;
  @override
  @JsonKey()
  final double taxRate;
  @override
  @JsonKey()
  final double vatAmount;
  @override
  final double totalAmount;
  @override
  final String imageBase64;
  @override
  final String imageMimeType;

  @override
  String toString() {
    return 'ExpenseConfirmPayload(supplierName: $supplierName, supplierCif: $supplierCif, supplierAddress: $supplierAddress, date: $date, category: $category, description: $description, baseAmount: $baseAmount, taxKind: $taxKind, taxRate: $taxRate, vatAmount: $vatAmount, totalAmount: $totalAmount, imageBase64: $imageBase64, imageMimeType: $imageMimeType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseConfirmPayloadImpl &&
            (identical(other.supplierName, supplierName) ||
                other.supplierName == supplierName) &&
            (identical(other.supplierCif, supplierCif) ||
                other.supplierCif == supplierCif) &&
            (identical(other.supplierAddress, supplierAddress) ||
                other.supplierAddress == supplierAddress) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.baseAmount, baseAmount) ||
                other.baseAmount == baseAmount) &&
            (identical(other.taxKind, taxKind) || other.taxKind == taxKind) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.vatAmount, vatAmount) ||
                other.vatAmount == vatAmount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.imageBase64, imageBase64) ||
                other.imageBase64 == imageBase64) &&
            (identical(other.imageMimeType, imageMimeType) ||
                other.imageMimeType == imageMimeType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    supplierName,
    supplierCif,
    supplierAddress,
    date,
    category,
    description,
    baseAmount,
    taxKind,
    taxRate,
    vatAmount,
    totalAmount,
    imageBase64,
    imageMimeType,
  );

  /// Create a copy of ExpenseConfirmPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseConfirmPayloadImplCopyWith<_$ExpenseConfirmPayloadImpl>
  get copyWith =>
      __$$ExpenseConfirmPayloadImplCopyWithImpl<_$ExpenseConfirmPayloadImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseConfirmPayloadImplToJson(this);
  }
}

abstract class _ExpenseConfirmPayload implements ExpenseConfirmPayload {
  const factory _ExpenseConfirmPayload({
    required final String supplierName,
    final String supplierCif,
    final String? supplierAddress,
    required final String date,
    final String category,
    required final String description,
    required final double baseAmount,
    final String? taxKind,
    final double taxRate,
    final double vatAmount,
    required final double totalAmount,
    required final String imageBase64,
    required final String imageMimeType,
  }) = _$ExpenseConfirmPayloadImpl;

  factory _ExpenseConfirmPayload.fromJson(Map<String, dynamic> json) =
      _$ExpenseConfirmPayloadImpl.fromJson;

  @override
  String get supplierName;
  @override
  String get supplierCif;
  @override
  String? get supplierAddress;
  @override
  String get date;
  @override
  String get category;
  @override
  String get description;
  @override
  double get baseAmount;
  @override
  String? get taxKind;
  @override
  double get taxRate;
  @override
  double get vatAmount;
  @override
  double get totalAmount;
  @override
  String get imageBase64;
  @override
  String get imageMimeType;

  /// Create a copy of ExpenseConfirmPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseConfirmPayloadImplCopyWith<_$ExpenseConfirmPayloadImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ExpenseCreatedResponse _$ExpenseCreatedResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ExpenseCreatedResponse.fromJson(json);
}

/// @nodoc
mixin _$ExpenseCreatedResponse {
  ExpenseInfo get expense => throw _privateConstructorUsedError;
  SupplierInfo get supplier => throw _privateConstructorUsedError;

  /// Serializes this ExpenseCreatedResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseCreatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseCreatedResponseCopyWith<ExpenseCreatedResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCreatedResponseCopyWith<$Res> {
  factory $ExpenseCreatedResponseCopyWith(
    ExpenseCreatedResponse value,
    $Res Function(ExpenseCreatedResponse) then,
  ) = _$ExpenseCreatedResponseCopyWithImpl<$Res, ExpenseCreatedResponse>;
  @useResult
  $Res call({ExpenseInfo expense, SupplierInfo supplier});

  $ExpenseInfoCopyWith<$Res> get expense;
  $SupplierInfoCopyWith<$Res> get supplier;
}

/// @nodoc
class _$ExpenseCreatedResponseCopyWithImpl<
  $Res,
  $Val extends ExpenseCreatedResponse
>
    implements $ExpenseCreatedResponseCopyWith<$Res> {
  _$ExpenseCreatedResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseCreatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? expense = null, Object? supplier = null}) {
    return _then(
      _value.copyWith(
            expense: null == expense
                ? _value.expense
                : expense // ignore: cast_nullable_to_non_nullable
                      as ExpenseInfo,
            supplier: null == supplier
                ? _value.supplier
                : supplier // ignore: cast_nullable_to_non_nullable
                      as SupplierInfo,
          )
          as $Val,
    );
  }

  /// Create a copy of ExpenseCreatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpenseInfoCopyWith<$Res> get expense {
    return $ExpenseInfoCopyWith<$Res>(_value.expense, (value) {
      return _then(_value.copyWith(expense: value) as $Val);
    });
  }

  /// Create a copy of ExpenseCreatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SupplierInfoCopyWith<$Res> get supplier {
    return $SupplierInfoCopyWith<$Res>(_value.supplier, (value) {
      return _then(_value.copyWith(supplier: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExpenseCreatedResponseImplCopyWith<$Res>
    implements $ExpenseCreatedResponseCopyWith<$Res> {
  factory _$$ExpenseCreatedResponseImplCopyWith(
    _$ExpenseCreatedResponseImpl value,
    $Res Function(_$ExpenseCreatedResponseImpl) then,
  ) = __$$ExpenseCreatedResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ExpenseInfo expense, SupplierInfo supplier});

  @override
  $ExpenseInfoCopyWith<$Res> get expense;
  @override
  $SupplierInfoCopyWith<$Res> get supplier;
}

/// @nodoc
class __$$ExpenseCreatedResponseImplCopyWithImpl<$Res>
    extends
        _$ExpenseCreatedResponseCopyWithImpl<$Res, _$ExpenseCreatedResponseImpl>
    implements _$$ExpenseCreatedResponseImplCopyWith<$Res> {
  __$$ExpenseCreatedResponseImplCopyWithImpl(
    _$ExpenseCreatedResponseImpl _value,
    $Res Function(_$ExpenseCreatedResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseCreatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? expense = null, Object? supplier = null}) {
    return _then(
      _$ExpenseCreatedResponseImpl(
        expense: null == expense
            ? _value.expense
            : expense // ignore: cast_nullable_to_non_nullable
                  as ExpenseInfo,
        supplier: null == supplier
            ? _value.supplier
            : supplier // ignore: cast_nullable_to_non_nullable
                  as SupplierInfo,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseCreatedResponseImpl implements _ExpenseCreatedResponse {
  const _$ExpenseCreatedResponseImpl({
    required this.expense,
    required this.supplier,
  });

  factory _$ExpenseCreatedResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseCreatedResponseImplFromJson(json);

  @override
  final ExpenseInfo expense;
  @override
  final SupplierInfo supplier;

  @override
  String toString() {
    return 'ExpenseCreatedResponse(expense: $expense, supplier: $supplier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseCreatedResponseImpl &&
            (identical(other.expense, expense) || other.expense == expense) &&
            (identical(other.supplier, supplier) ||
                other.supplier == supplier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, expense, supplier);

  /// Create a copy of ExpenseCreatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseCreatedResponseImplCopyWith<_$ExpenseCreatedResponseImpl>
  get copyWith =>
      __$$ExpenseCreatedResponseImplCopyWithImpl<_$ExpenseCreatedResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseCreatedResponseImplToJson(this);
  }
}

abstract class _ExpenseCreatedResponse implements ExpenseCreatedResponse {
  const factory _ExpenseCreatedResponse({
    required final ExpenseInfo expense,
    required final SupplierInfo supplier,
  }) = _$ExpenseCreatedResponseImpl;

  factory _ExpenseCreatedResponse.fromJson(Map<String, dynamic> json) =
      _$ExpenseCreatedResponseImpl.fromJson;

  @override
  ExpenseInfo get expense;
  @override
  SupplierInfo get supplier;

  /// Create a copy of ExpenseCreatedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseCreatedResponseImplCopyWith<_$ExpenseCreatedResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ExpenseInfo _$ExpenseInfoFromJson(Map<String, dynamic> json) {
  return _ExpenseInfo.fromJson(json);
}

/// @nodoc
mixin _$ExpenseInfo {
  int get id => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;

  /// Serializes this ExpenseInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseInfoCopyWith<ExpenseInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseInfoCopyWith<$Res> {
  factory $ExpenseInfoCopyWith(
    ExpenseInfo value,
    $Res Function(ExpenseInfo) then,
  ) = _$ExpenseInfoCopyWithImpl<$Res, ExpenseInfo>;
  @useResult
  $Res call({int id, String category, String description, double totalAmount});
}

/// @nodoc
class _$ExpenseInfoCopyWithImpl<$Res, $Val extends ExpenseInfo>
    implements $ExpenseInfoCopyWith<$Res> {
  _$ExpenseInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? description = null,
    Object? totalAmount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpenseInfoImplCopyWith<$Res>
    implements $ExpenseInfoCopyWith<$Res> {
  factory _$$ExpenseInfoImplCopyWith(
    _$ExpenseInfoImpl value,
    $Res Function(_$ExpenseInfoImpl) then,
  ) = __$$ExpenseInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String category, String description, double totalAmount});
}

/// @nodoc
class __$$ExpenseInfoImplCopyWithImpl<$Res>
    extends _$ExpenseInfoCopyWithImpl<$Res, _$ExpenseInfoImpl>
    implements _$$ExpenseInfoImplCopyWith<$Res> {
  __$$ExpenseInfoImplCopyWithImpl(
    _$ExpenseInfoImpl _value,
    $Res Function(_$ExpenseInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpenseInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? description = null,
    Object? totalAmount = null,
  }) {
    return _then(
      _$ExpenseInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseInfoImpl implements _ExpenseInfo {
  const _$ExpenseInfoImpl({
    required this.id,
    required this.category,
    required this.description,
    required this.totalAmount,
  });

  factory _$ExpenseInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseInfoImplFromJson(json);

  @override
  final int id;
  @override
  final String category;
  @override
  final String description;
  @override
  final double totalAmount;

  @override
  String toString() {
    return 'ExpenseInfo(id: $id, category: $category, description: $description, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, category, description, totalAmount);

  /// Create a copy of ExpenseInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseInfoImplCopyWith<_$ExpenseInfoImpl> get copyWith =>
      __$$ExpenseInfoImplCopyWithImpl<_$ExpenseInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseInfoImplToJson(this);
  }
}

abstract class _ExpenseInfo implements ExpenseInfo {
  const factory _ExpenseInfo({
    required final int id,
    required final String category,
    required final String description,
    required final double totalAmount,
  }) = _$ExpenseInfoImpl;

  factory _ExpenseInfo.fromJson(Map<String, dynamic> json) =
      _$ExpenseInfoImpl.fromJson;

  @override
  int get id;
  @override
  String get category;
  @override
  String get description;
  @override
  double get totalAmount;

  /// Create a copy of ExpenseInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseInfoImplCopyWith<_$ExpenseInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SupplierInfo _$SupplierInfoFromJson(Map<String, dynamic> json) {
  return _SupplierInfo.fromJson(json);
}

/// @nodoc
mixin _$SupplierInfo {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get taxId => throw _privateConstructorUsedError;
  bool get created => throw _privateConstructorUsedError;

  /// Serializes this SupplierInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SupplierInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupplierInfoCopyWith<SupplierInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierInfoCopyWith<$Res> {
  factory $SupplierInfoCopyWith(
    SupplierInfo value,
    $Res Function(SupplierInfo) then,
  ) = _$SupplierInfoCopyWithImpl<$Res, SupplierInfo>;
  @useResult
  $Res call({int id, String name, String taxId, bool created});
}

/// @nodoc
class _$SupplierInfoCopyWithImpl<$Res, $Val extends SupplierInfo>
    implements $SupplierInfoCopyWith<$Res> {
  _$SupplierInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupplierInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? taxId = null,
    Object? created = null,
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
            taxId: null == taxId
                ? _value.taxId
                : taxId // ignore: cast_nullable_to_non_nullable
                      as String,
            created: null == created
                ? _value.created
                : created // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SupplierInfoImplCopyWith<$Res>
    implements $SupplierInfoCopyWith<$Res> {
  factory _$$SupplierInfoImplCopyWith(
    _$SupplierInfoImpl value,
    $Res Function(_$SupplierInfoImpl) then,
  ) = __$$SupplierInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String taxId, bool created});
}

/// @nodoc
class __$$SupplierInfoImplCopyWithImpl<$Res>
    extends _$SupplierInfoCopyWithImpl<$Res, _$SupplierInfoImpl>
    implements _$$SupplierInfoImplCopyWith<$Res> {
  __$$SupplierInfoImplCopyWithImpl(
    _$SupplierInfoImpl _value,
    $Res Function(_$SupplierInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupplierInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? taxId = null,
    Object? created = null,
  }) {
    return _then(
      _$SupplierInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        taxId: null == taxId
            ? _value.taxId
            : taxId // ignore: cast_nullable_to_non_nullable
                  as String,
        created: null == created
            ? _value.created
            : created // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplierInfoImpl implements _SupplierInfo {
  const _$SupplierInfoImpl({
    required this.id,
    required this.name,
    this.taxId = '',
    this.created = false,
  });

  factory _$SupplierInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierInfoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey()
  final String taxId;
  @override
  @JsonKey()
  final bool created;

  @override
  String toString() {
    return 'SupplierInfo(id: $id, name: $name, taxId: $taxId, created: $created)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.taxId, taxId) || other.taxId == taxId) &&
            (identical(other.created, created) || other.created == created));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, taxId, created);

  /// Create a copy of SupplierInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierInfoImplCopyWith<_$SupplierInfoImpl> get copyWith =>
      __$$SupplierInfoImplCopyWithImpl<_$SupplierInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierInfoImplToJson(this);
  }
}

abstract class _SupplierInfo implements SupplierInfo {
  const factory _SupplierInfo({
    required final int id,
    required final String name,
    final String taxId,
    final bool created,
  }) = _$SupplierInfoImpl;

  factory _SupplierInfo.fromJson(Map<String, dynamic> json) =
      _$SupplierInfoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get taxId;
  @override
  bool get created;

  /// Create a copy of SupplierInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupplierInfoImplCopyWith<_$SupplierInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
