// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BudgetListItem _$BudgetListItemFromJson(Map<String, dynamic> json) {
  return _BudgetListItem.fromJson(json);
}

/// @nodoc
mixin _$BudgetListItem {
  int get id => throw _privateConstructorUsedError;
  String get series => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get quoteStatus => throw _privateConstructorUsedError;
  String get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get total => throw _privateConstructorUsedError;
  String? get taxKind => throw _privateConstructorUsedError;
  int? get saleId => throw _privateConstructorUsedError;
  BudgetClient? get client => throw _privateConstructorUsedError;

  /// Serializes this BudgetListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BudgetListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetListItemCopyWith<BudgetListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetListItemCopyWith<$Res> {
  factory $BudgetListItemCopyWith(
    BudgetListItem value,
    $Res Function(BudgetListItem) then,
  ) = _$BudgetListItemCopyWithImpl<$Res, BudgetListItem>;
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String status,
    String? quoteStatus,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String? taxKind,
    int? saleId,
    BudgetClient? client,
  });

  $BudgetClientCopyWith<$Res>? get client;
}

/// @nodoc
class _$BudgetListItemCopyWithImpl<$Res, $Val extends BudgetListItem>
    implements $BudgetListItemCopyWith<$Res> {
  _$BudgetListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? status = null,
    Object? quoteStatus = freezed,
    Object? issuedAt = null,
    Object? total = null,
    Object? taxKind = freezed,
    Object? saleId = freezed,
    Object? client = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            series: null == series
                ? _value.series
                : series // ignore: cast_nullable_to_non_nullable
                      as String,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            quoteStatus: freezed == quoteStatus
                ? _value.quoteStatus
                : quoteStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            issuedAt: null == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            taxKind: freezed == taxKind
                ? _value.taxKind
                : taxKind // ignore: cast_nullable_to_non_nullable
                      as String?,
            saleId: freezed == saleId
                ? _value.saleId
                : saleId // ignore: cast_nullable_to_non_nullable
                      as int?,
            client: freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                      as BudgetClient?,
          )
          as $Val,
    );
  }

  /// Create a copy of BudgetListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BudgetClientCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $BudgetClientCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BudgetListItemImplCopyWith<$Res>
    implements $BudgetListItemCopyWith<$Res> {
  factory _$$BudgetListItemImplCopyWith(
    _$BudgetListItemImpl value,
    $Res Function(_$BudgetListItemImpl) then,
  ) = __$$BudgetListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String status,
    String? quoteStatus,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String? taxKind,
    int? saleId,
    BudgetClient? client,
  });

  @override
  $BudgetClientCopyWith<$Res>? get client;
}

/// @nodoc
class __$$BudgetListItemImplCopyWithImpl<$Res>
    extends _$BudgetListItemCopyWithImpl<$Res, _$BudgetListItemImpl>
    implements _$$BudgetListItemImplCopyWith<$Res> {
  __$$BudgetListItemImplCopyWithImpl(
    _$BudgetListItemImpl _value,
    $Res Function(_$BudgetListItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BudgetListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? status = null,
    Object? quoteStatus = freezed,
    Object? issuedAt = null,
    Object? total = null,
    Object? taxKind = freezed,
    Object? saleId = freezed,
    Object? client = freezed,
  }) {
    return _then(
      _$BudgetListItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        series: null == series
            ? _value.series
            : series // ignore: cast_nullable_to_non_nullable
                  as String,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        quoteStatus: freezed == quoteStatus
            ? _value.quoteStatus
            : quoteStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        issuedAt: null == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        taxKind: freezed == taxKind
            ? _value.taxKind
            : taxKind // ignore: cast_nullable_to_non_nullable
                  as String?,
        saleId: freezed == saleId
            ? _value.saleId
            : saleId // ignore: cast_nullable_to_non_nullable
                  as int?,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as BudgetClient?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetListItemImpl implements _BudgetListItem {
  const _$BudgetListItemImpl({
    required this.id,
    required this.series,
    required this.number,
    required this.status,
    this.quoteStatus,
    required this.issuedAt,
    @JsonKey(fromJson: toDouble) required this.total,
    this.taxKind,
    this.saleId,
    this.client,
  });

  factory _$BudgetListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetListItemImplFromJson(json);

  @override
  final int id;
  @override
  final String series;
  @override
  final int number;
  @override
  final String status;
  @override
  final String? quoteStatus;
  @override
  final String issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  final double total;
  @override
  final String? taxKind;
  @override
  final int? saleId;
  @override
  final BudgetClient? client;

  @override
  String toString() {
    return 'BudgetListItem(id: $id, series: $series, number: $number, status: $status, quoteStatus: $quoteStatus, issuedAt: $issuedAt, total: $total, taxKind: $taxKind, saleId: $saleId, client: $client)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.quoteStatus, quoteStatus) ||
                other.quoteStatus == quoteStatus) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.taxKind, taxKind) || other.taxKind == taxKind) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.client, client) || other.client == client));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    series,
    number,
    status,
    quoteStatus,
    issuedAt,
    total,
    taxKind,
    saleId,
    client,
  );

  /// Create a copy of BudgetListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetListItemImplCopyWith<_$BudgetListItemImpl> get copyWith =>
      __$$BudgetListItemImplCopyWithImpl<_$BudgetListItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetListItemImplToJson(this);
  }
}

abstract class _BudgetListItem implements BudgetListItem {
  const factory _BudgetListItem({
    required final int id,
    required final String series,
    required final int number,
    required final String status,
    final String? quoteStatus,
    required final String issuedAt,
    @JsonKey(fromJson: toDouble) required final double total,
    final String? taxKind,
    final int? saleId,
    final BudgetClient? client,
  }) = _$BudgetListItemImpl;

  factory _BudgetListItem.fromJson(Map<String, dynamic> json) =
      _$BudgetListItemImpl.fromJson;

  @override
  int get id;
  @override
  String get series;
  @override
  int get number;
  @override
  String get status;
  @override
  String? get quoteStatus;
  @override
  String get issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  double get total;
  @override
  String? get taxKind;
  @override
  int? get saleId;
  @override
  BudgetClient? get client;

  /// Create a copy of BudgetListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetListItemImplCopyWith<_$BudgetListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BudgetClient _$BudgetClientFromJson(Map<String, dynamic> json) {
  return _BudgetClient.fromJson(json);
}

/// @nodoc
mixin _$BudgetClient {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get taxId => throw _privateConstructorUsedError;

  /// Serializes this BudgetClient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BudgetClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetClientCopyWith<BudgetClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetClientCopyWith<$Res> {
  factory $BudgetClientCopyWith(
    BudgetClient value,
    $Res Function(BudgetClient) then,
  ) = _$BudgetClientCopyWithImpl<$Res, BudgetClient>;
  @useResult
  $Res call({int id, String name, String? taxId});
}

/// @nodoc
class _$BudgetClientCopyWithImpl<$Res, $Val extends BudgetClient>
    implements $BudgetClientCopyWith<$Res> {
  _$BudgetClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? taxId = freezed}) {
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
            taxId: freezed == taxId
                ? _value.taxId
                : taxId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BudgetClientImplCopyWith<$Res>
    implements $BudgetClientCopyWith<$Res> {
  factory _$$BudgetClientImplCopyWith(
    _$BudgetClientImpl value,
    $Res Function(_$BudgetClientImpl) then,
  ) = __$$BudgetClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? taxId});
}

/// @nodoc
class __$$BudgetClientImplCopyWithImpl<$Res>
    extends _$BudgetClientCopyWithImpl<$Res, _$BudgetClientImpl>
    implements _$$BudgetClientImplCopyWith<$Res> {
  __$$BudgetClientImplCopyWithImpl(
    _$BudgetClientImpl _value,
    $Res Function(_$BudgetClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BudgetClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? taxId = freezed}) {
    return _then(
      _$BudgetClientImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        taxId: freezed == taxId
            ? _value.taxId
            : taxId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetClientImpl implements _BudgetClient {
  const _$BudgetClientImpl({required this.id, required this.name, this.taxId});

  factory _$BudgetClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetClientImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? taxId;

  @override
  String toString() {
    return 'BudgetClient(id: $id, name: $name, taxId: $taxId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetClientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.taxId, taxId) || other.taxId == taxId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, taxId);

  /// Create a copy of BudgetClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetClientImplCopyWith<_$BudgetClientImpl> get copyWith =>
      __$$BudgetClientImplCopyWithImpl<_$BudgetClientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetClientImplToJson(this);
  }
}

abstract class _BudgetClient implements BudgetClient {
  const factory _BudgetClient({
    required final int id,
    required final String name,
    final String? taxId,
  }) = _$BudgetClientImpl;

  factory _BudgetClient.fromJson(Map<String, dynamic> json) =
      _$BudgetClientImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get taxId;

  /// Create a copy of BudgetClient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetClientImplCopyWith<_$BudgetClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BudgetDetail _$BudgetDetailFromJson(Map<String, dynamic> json) {
  return _BudgetDetail.fromJson(json);
}

/// @nodoc
mixin _$BudgetDetail {
  int get id => throw _privateConstructorUsedError;
  String get series => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get quoteStatus => throw _privateConstructorUsedError;
  String get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get total => throw _privateConstructorUsedError;
  String? get taxKind => throw _privateConstructorUsedError;
  int? get paymentPlanCount => throw _privateConstructorUsedError;
  int? get saleId => throw _privateConstructorUsedError;
  String? get internalNotes => throw _privateConstructorUsedError;
  String? get publicNotes => throw _privateConstructorUsedError;
  BudgetClient? get client => throw _privateConstructorUsedError;
  List<BudgetLine> get lines => throw _privateConstructorUsedError;

  /// Serializes this BudgetDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BudgetDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetDetailCopyWith<BudgetDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetDetailCopyWith<$Res> {
  factory $BudgetDetailCopyWith(
    BudgetDetail value,
    $Res Function(BudgetDetail) then,
  ) = _$BudgetDetailCopyWithImpl<$Res, BudgetDetail>;
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String status,
    String? quoteStatus,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String? taxKind,
    int? paymentPlanCount,
    int? saleId,
    String? internalNotes,
    String? publicNotes,
    BudgetClient? client,
    List<BudgetLine> lines,
  });

  $BudgetClientCopyWith<$Res>? get client;
}

/// @nodoc
class _$BudgetDetailCopyWithImpl<$Res, $Val extends BudgetDetail>
    implements $BudgetDetailCopyWith<$Res> {
  _$BudgetDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? status = null,
    Object? quoteStatus = freezed,
    Object? issuedAt = null,
    Object? total = null,
    Object? taxKind = freezed,
    Object? paymentPlanCount = freezed,
    Object? saleId = freezed,
    Object? internalNotes = freezed,
    Object? publicNotes = freezed,
    Object? client = freezed,
    Object? lines = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            series: null == series
                ? _value.series
                : series // ignore: cast_nullable_to_non_nullable
                      as String,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            quoteStatus: freezed == quoteStatus
                ? _value.quoteStatus
                : quoteStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            issuedAt: null == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            taxKind: freezed == taxKind
                ? _value.taxKind
                : taxKind // ignore: cast_nullable_to_non_nullable
                      as String?,
            paymentPlanCount: freezed == paymentPlanCount
                ? _value.paymentPlanCount
                : paymentPlanCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            saleId: freezed == saleId
                ? _value.saleId
                : saleId // ignore: cast_nullable_to_non_nullable
                      as int?,
            internalNotes: freezed == internalNotes
                ? _value.internalNotes
                : internalNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            publicNotes: freezed == publicNotes
                ? _value.publicNotes
                : publicNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            client: freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                      as BudgetClient?,
            lines: null == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<BudgetLine>,
          )
          as $Val,
    );
  }

  /// Create a copy of BudgetDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BudgetClientCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $BudgetClientCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BudgetDetailImplCopyWith<$Res>
    implements $BudgetDetailCopyWith<$Res> {
  factory _$$BudgetDetailImplCopyWith(
    _$BudgetDetailImpl value,
    $Res Function(_$BudgetDetailImpl) then,
  ) = __$$BudgetDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String status,
    String? quoteStatus,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String? taxKind,
    int? paymentPlanCount,
    int? saleId,
    String? internalNotes,
    String? publicNotes,
    BudgetClient? client,
    List<BudgetLine> lines,
  });

  @override
  $BudgetClientCopyWith<$Res>? get client;
}

/// @nodoc
class __$$BudgetDetailImplCopyWithImpl<$Res>
    extends _$BudgetDetailCopyWithImpl<$Res, _$BudgetDetailImpl>
    implements _$$BudgetDetailImplCopyWith<$Res> {
  __$$BudgetDetailImplCopyWithImpl(
    _$BudgetDetailImpl _value,
    $Res Function(_$BudgetDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BudgetDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? status = null,
    Object? quoteStatus = freezed,
    Object? issuedAt = null,
    Object? total = null,
    Object? taxKind = freezed,
    Object? paymentPlanCount = freezed,
    Object? saleId = freezed,
    Object? internalNotes = freezed,
    Object? publicNotes = freezed,
    Object? client = freezed,
    Object? lines = null,
  }) {
    return _then(
      _$BudgetDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        series: null == series
            ? _value.series
            : series // ignore: cast_nullable_to_non_nullable
                  as String,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        quoteStatus: freezed == quoteStatus
            ? _value.quoteStatus
            : quoteStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        issuedAt: null == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        taxKind: freezed == taxKind
            ? _value.taxKind
            : taxKind // ignore: cast_nullable_to_non_nullable
                  as String?,
        paymentPlanCount: freezed == paymentPlanCount
            ? _value.paymentPlanCount
            : paymentPlanCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        saleId: freezed == saleId
            ? _value.saleId
            : saleId // ignore: cast_nullable_to_non_nullable
                  as int?,
        internalNotes: freezed == internalNotes
            ? _value.internalNotes
            : internalNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        publicNotes: freezed == publicNotes
            ? _value.publicNotes
            : publicNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as BudgetClient?,
        lines: null == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<BudgetLine>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetDetailImpl implements _BudgetDetail {
  const _$BudgetDetailImpl({
    required this.id,
    required this.series,
    required this.number,
    required this.status,
    this.quoteStatus,
    required this.issuedAt,
    @JsonKey(fromJson: toDouble) required this.total,
    this.taxKind,
    this.paymentPlanCount,
    this.saleId,
    this.internalNotes,
    this.publicNotes,
    this.client,
    final List<BudgetLine> lines = const [],
  }) : _lines = lines;

  factory _$BudgetDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String series;
  @override
  final int number;
  @override
  final String status;
  @override
  final String? quoteStatus;
  @override
  final String issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  final double total;
  @override
  final String? taxKind;
  @override
  final int? paymentPlanCount;
  @override
  final int? saleId;
  @override
  final String? internalNotes;
  @override
  final String? publicNotes;
  @override
  final BudgetClient? client;
  final List<BudgetLine> _lines;
  @override
  @JsonKey()
  List<BudgetLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  String toString() {
    return 'BudgetDetail(id: $id, series: $series, number: $number, status: $status, quoteStatus: $quoteStatus, issuedAt: $issuedAt, total: $total, taxKind: $taxKind, paymentPlanCount: $paymentPlanCount, saleId: $saleId, internalNotes: $internalNotes, publicNotes: $publicNotes, client: $client, lines: $lines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.quoteStatus, quoteStatus) ||
                other.quoteStatus == quoteStatus) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.taxKind, taxKind) || other.taxKind == taxKind) &&
            (identical(other.paymentPlanCount, paymentPlanCount) ||
                other.paymentPlanCount == paymentPlanCount) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.internalNotes, internalNotes) ||
                other.internalNotes == internalNotes) &&
            (identical(other.publicNotes, publicNotes) ||
                other.publicNotes == publicNotes) &&
            (identical(other.client, client) || other.client == client) &&
            const DeepCollectionEquality().equals(other._lines, _lines));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    series,
    number,
    status,
    quoteStatus,
    issuedAt,
    total,
    taxKind,
    paymentPlanCount,
    saleId,
    internalNotes,
    publicNotes,
    client,
    const DeepCollectionEquality().hash(_lines),
  );

  /// Create a copy of BudgetDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetDetailImplCopyWith<_$BudgetDetailImpl> get copyWith =>
      __$$BudgetDetailImplCopyWithImpl<_$BudgetDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetDetailImplToJson(this);
  }
}

abstract class _BudgetDetail implements BudgetDetail {
  const factory _BudgetDetail({
    required final int id,
    required final String series,
    required final int number,
    required final String status,
    final String? quoteStatus,
    required final String issuedAt,
    @JsonKey(fromJson: toDouble) required final double total,
    final String? taxKind,
    final int? paymentPlanCount,
    final int? saleId,
    final String? internalNotes,
    final String? publicNotes,
    final BudgetClient? client,
    final List<BudgetLine> lines,
  }) = _$BudgetDetailImpl;

  factory _BudgetDetail.fromJson(Map<String, dynamic> json) =
      _$BudgetDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get series;
  @override
  int get number;
  @override
  String get status;
  @override
  String? get quoteStatus;
  @override
  String get issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  double get total;
  @override
  String? get taxKind;
  @override
  int? get paymentPlanCount;
  @override
  int? get saleId;
  @override
  String? get internalNotes;
  @override
  String? get publicNotes;
  @override
  BudgetClient? get client;
  @override
  List<BudgetLine> get lines;

  /// Create a copy of BudgetDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetDetailImplCopyWith<_$BudgetDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BudgetLine _$BudgetLineFromJson(Map<String, dynamic> json) {
  return _BudgetLine.fromJson(json);
}

/// @nodoc
mixin _$BudgetLine {
  int get id => throw _privateConstructorUsedError;
  int? get productId => throw _privateConstructorUsedError;
  int? get serviceId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get unitPrice => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get discountRate => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get taxRate => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get taxAmount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get total => throw _privateConstructorUsedError;

  /// Serializes this BudgetLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BudgetLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetLineCopyWith<BudgetLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetLineCopyWith<$Res> {
  factory $BudgetLineCopyWith(
    BudgetLine value,
    $Res Function(BudgetLine) then,
  ) = _$BudgetLineCopyWithImpl<$Res, BudgetLine>;
  @useResult
  $Res call({
    int id,
    int? productId,
    int? serviceId,
    String description,
    @JsonKey(fromJson: toDouble) double quantity,
    @JsonKey(fromJson: toDouble) double unitPrice,
    @JsonKey(fromJson: toDouble) double discountRate,
    @JsonKey(fromJson: toDouble) double taxRate,
    @JsonKey(fromJson: toDouble) double taxAmount,
    @JsonKey(fromJson: toDouble) double total,
  });
}

/// @nodoc
class _$BudgetLineCopyWithImpl<$Res, $Val extends BudgetLine>
    implements $BudgetLineCopyWith<$Res> {
  _$BudgetLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = freezed,
    Object? serviceId = freezed,
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? discountRate = null,
    Object? taxRate = null,
    Object? taxAmount = null,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            productId: freezed == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as int?,
            serviceId: freezed == serviceId
                ? _value.serviceId
                : serviceId // ignore: cast_nullable_to_non_nullable
                      as int?,
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
            discountRate: null == discountRate
                ? _value.discountRate
                : discountRate // ignore: cast_nullable_to_non_nullable
                      as double,
            taxRate: null == taxRate
                ? _value.taxRate
                : taxRate // ignore: cast_nullable_to_non_nullable
                      as double,
            taxAmount: null == taxAmount
                ? _value.taxAmount
                : taxAmount // ignore: cast_nullable_to_non_nullable
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
abstract class _$$BudgetLineImplCopyWith<$Res>
    implements $BudgetLineCopyWith<$Res> {
  factory _$$BudgetLineImplCopyWith(
    _$BudgetLineImpl value,
    $Res Function(_$BudgetLineImpl) then,
  ) = __$$BudgetLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int? productId,
    int? serviceId,
    String description,
    @JsonKey(fromJson: toDouble) double quantity,
    @JsonKey(fromJson: toDouble) double unitPrice,
    @JsonKey(fromJson: toDouble) double discountRate,
    @JsonKey(fromJson: toDouble) double taxRate,
    @JsonKey(fromJson: toDouble) double taxAmount,
    @JsonKey(fromJson: toDouble) double total,
  });
}

/// @nodoc
class __$$BudgetLineImplCopyWithImpl<$Res>
    extends _$BudgetLineCopyWithImpl<$Res, _$BudgetLineImpl>
    implements _$$BudgetLineImplCopyWith<$Res> {
  __$$BudgetLineImplCopyWithImpl(
    _$BudgetLineImpl _value,
    $Res Function(_$BudgetLineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BudgetLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = freezed,
    Object? serviceId = freezed,
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? discountRate = null,
    Object? taxRate = null,
    Object? taxAmount = null,
    Object? total = null,
  }) {
    return _then(
      _$BudgetLineImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        productId: freezed == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as int?,
        serviceId: freezed == serviceId
            ? _value.serviceId
            : serviceId // ignore: cast_nullable_to_non_nullable
                  as int?,
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
        discountRate: null == discountRate
            ? _value.discountRate
            : discountRate // ignore: cast_nullable_to_non_nullable
                  as double,
        taxRate: null == taxRate
            ? _value.taxRate
            : taxRate // ignore: cast_nullable_to_non_nullable
                  as double,
        taxAmount: null == taxAmount
            ? _value.taxAmount
            : taxAmount // ignore: cast_nullable_to_non_nullable
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
class _$BudgetLineImpl implements _BudgetLine {
  const _$BudgetLineImpl({
    required this.id,
    this.productId,
    this.serviceId,
    required this.description,
    @JsonKey(fromJson: toDouble) required this.quantity,
    @JsonKey(fromJson: toDouble) required this.unitPrice,
    @JsonKey(fromJson: toDouble) required this.discountRate,
    @JsonKey(fromJson: toDouble) required this.taxRate,
    @JsonKey(fromJson: toDouble) required this.taxAmount,
    @JsonKey(fromJson: toDouble) required this.total,
  });

  factory _$BudgetLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetLineImplFromJson(json);

  @override
  final int id;
  @override
  final int? productId;
  @override
  final int? serviceId;
  @override
  final String description;
  @override
  @JsonKey(fromJson: toDouble)
  final double quantity;
  @override
  @JsonKey(fromJson: toDouble)
  final double unitPrice;
  @override
  @JsonKey(fromJson: toDouble)
  final double discountRate;
  @override
  @JsonKey(fromJson: toDouble)
  final double taxRate;
  @override
  @JsonKey(fromJson: toDouble)
  final double taxAmount;
  @override
  @JsonKey(fromJson: toDouble)
  final double total;

  @override
  String toString() {
    return 'BudgetLine(id: $id, productId: $productId, serviceId: $serviceId, description: $description, quantity: $quantity, unitPrice: $unitPrice, discountRate: $discountRate, taxRate: $taxRate, taxAmount: $taxAmount, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetLineImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.discountRate, discountRate) ||
                other.discountRate == discountRate) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    productId,
    serviceId,
    description,
    quantity,
    unitPrice,
    discountRate,
    taxRate,
    taxAmount,
    total,
  );

  /// Create a copy of BudgetLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetLineImplCopyWith<_$BudgetLineImpl> get copyWith =>
      __$$BudgetLineImplCopyWithImpl<_$BudgetLineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetLineImplToJson(this);
  }
}

abstract class _BudgetLine implements BudgetLine {
  const factory _BudgetLine({
    required final int id,
    final int? productId,
    final int? serviceId,
    required final String description,
    @JsonKey(fromJson: toDouble) required final double quantity,
    @JsonKey(fromJson: toDouble) required final double unitPrice,
    @JsonKey(fromJson: toDouble) required final double discountRate,
    @JsonKey(fromJson: toDouble) required final double taxRate,
    @JsonKey(fromJson: toDouble) required final double taxAmount,
    @JsonKey(fromJson: toDouble) required final double total,
  }) = _$BudgetLineImpl;

  factory _BudgetLine.fromJson(Map<String, dynamic> json) =
      _$BudgetLineImpl.fromJson;

  @override
  int get id;
  @override
  int? get productId;
  @override
  int? get serviceId;
  @override
  String get description;
  @override
  @JsonKey(fromJson: toDouble)
  double get quantity;
  @override
  @JsonKey(fromJson: toDouble)
  double get unitPrice;
  @override
  @JsonKey(fromJson: toDouble)
  double get discountRate;
  @override
  @JsonKey(fromJson: toDouble)
  double get taxRate;
  @override
  @JsonKey(fromJson: toDouble)
  double get taxAmount;
  @override
  @JsonKey(fromJson: toDouble)
  double get total;

  /// Create a copy of BudgetLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetLineImplCopyWith<_$BudgetLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
