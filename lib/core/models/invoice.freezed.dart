// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InvoiceListItem _$InvoiceListItemFromJson(Map<String, dynamic> json) {
  return _InvoiceListItem.fromJson(json);
}

/// @nodoc
mixin _$InvoiceListItem {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get series => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get total => throw _privateConstructorUsedError;
  String get invoiceType => throw _privateConstructorUsedError;
  String? get taxKind => throw _privateConstructorUsedError;
  InvoiceClient? get client => throw _privateConstructorUsedError;

  /// Serializes this InvoiceListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceListItemCopyWith<InvoiceListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceListItemCopyWith<$Res> {
  factory $InvoiceListItemCopyWith(
    InvoiceListItem value,
    $Res Function(InvoiceListItem) then,
  ) = _$InvoiceListItemCopyWithImpl<$Res, InvoiceListItem>;
  @useResult
  $Res call({
    int id,
    String type,
    String status,
    String series,
    int number,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String invoiceType,
    String? taxKind,
    InvoiceClient? client,
  });

  $InvoiceClientCopyWith<$Res>? get client;
}

/// @nodoc
class _$InvoiceListItemCopyWithImpl<$Res, $Val extends InvoiceListItem>
    implements $InvoiceListItemCopyWith<$Res> {
  _$InvoiceListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? series = null,
    Object? number = null,
    Object? issuedAt = null,
    Object? total = null,
    Object? invoiceType = null,
    Object? taxKind = freezed,
    Object? client = freezed,
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
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            series: null == series
                ? _value.series
                : series // ignore: cast_nullable_to_non_nullable
                      as String,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            issuedAt: null == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            invoiceType: null == invoiceType
                ? _value.invoiceType
                : invoiceType // ignore: cast_nullable_to_non_nullable
                      as String,
            taxKind: freezed == taxKind
                ? _value.taxKind
                : taxKind // ignore: cast_nullable_to_non_nullable
                      as String?,
            client: freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                      as InvoiceClient?,
          )
          as $Val,
    );
  }

  /// Create a copy of InvoiceListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvoiceClientCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $InvoiceClientCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InvoiceListItemImplCopyWith<$Res>
    implements $InvoiceListItemCopyWith<$Res> {
  factory _$$InvoiceListItemImplCopyWith(
    _$InvoiceListItemImpl value,
    $Res Function(_$InvoiceListItemImpl) then,
  ) = __$$InvoiceListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String type,
    String status,
    String series,
    int number,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String invoiceType,
    String? taxKind,
    InvoiceClient? client,
  });

  @override
  $InvoiceClientCopyWith<$Res>? get client;
}

/// @nodoc
class __$$InvoiceListItemImplCopyWithImpl<$Res>
    extends _$InvoiceListItemCopyWithImpl<$Res, _$InvoiceListItemImpl>
    implements _$$InvoiceListItemImplCopyWith<$Res> {
  __$$InvoiceListItemImplCopyWithImpl(
    _$InvoiceListItemImpl _value,
    $Res Function(_$InvoiceListItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? series = null,
    Object? number = null,
    Object? issuedAt = null,
    Object? total = null,
    Object? invoiceType = null,
    Object? taxKind = freezed,
    Object? client = freezed,
  }) {
    return _then(
      _$InvoiceListItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        series: null == series
            ? _value.series
            : series // ignore: cast_nullable_to_non_nullable
                  as String,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        issuedAt: null == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        invoiceType: null == invoiceType
            ? _value.invoiceType
            : invoiceType // ignore: cast_nullable_to_non_nullable
                  as String,
        taxKind: freezed == taxKind
            ? _value.taxKind
            : taxKind // ignore: cast_nullable_to_non_nullable
                  as String?,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as InvoiceClient?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceListItemImpl implements _InvoiceListItem {
  const _$InvoiceListItemImpl({
    required this.id,
    required this.type,
    required this.status,
    required this.series,
    required this.number,
    required this.issuedAt,
    @JsonKey(fromJson: toDouble) required this.total,
    required this.invoiceType,
    this.taxKind,
    this.client,
  });

  factory _$InvoiceListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceListItemImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final String status;
  @override
  final String series;
  @override
  final int number;
  @override
  final String issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  final double total;
  @override
  final String invoiceType;
  @override
  final String? taxKind;
  @override
  final InvoiceClient? client;

  @override
  String toString() {
    return 'InvoiceListItem(id: $id, type: $type, status: $status, series: $series, number: $number, issuedAt: $issuedAt, total: $total, invoiceType: $invoiceType, taxKind: $taxKind, client: $client)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.invoiceType, invoiceType) ||
                other.invoiceType == invoiceType) &&
            (identical(other.taxKind, taxKind) || other.taxKind == taxKind) &&
            (identical(other.client, client) || other.client == client));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    status,
    series,
    number,
    issuedAt,
    total,
    invoiceType,
    taxKind,
    client,
  );

  /// Create a copy of InvoiceListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceListItemImplCopyWith<_$InvoiceListItemImpl> get copyWith =>
      __$$InvoiceListItemImplCopyWithImpl<_$InvoiceListItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceListItemImplToJson(this);
  }
}

abstract class _InvoiceListItem implements InvoiceListItem {
  const factory _InvoiceListItem({
    required final int id,
    required final String type,
    required final String status,
    required final String series,
    required final int number,
    required final String issuedAt,
    @JsonKey(fromJson: toDouble) required final double total,
    required final String invoiceType,
    final String? taxKind,
    final InvoiceClient? client,
  }) = _$InvoiceListItemImpl;

  factory _InvoiceListItem.fromJson(Map<String, dynamic> json) =
      _$InvoiceListItemImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  String get status;
  @override
  String get series;
  @override
  int get number;
  @override
  String get issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  double get total;
  @override
  String get invoiceType;
  @override
  String? get taxKind;
  @override
  InvoiceClient? get client;

  /// Create a copy of InvoiceListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceListItemImplCopyWith<_$InvoiceListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvoiceClient _$InvoiceClientFromJson(Map<String, dynamic> json) {
  return _InvoiceClient.fromJson(json);
}

/// @nodoc
mixin _$InvoiceClient {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get taxId => throw _privateConstructorUsedError;

  /// Serializes this InvoiceClient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceClientCopyWith<InvoiceClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceClientCopyWith<$Res> {
  factory $InvoiceClientCopyWith(
    InvoiceClient value,
    $Res Function(InvoiceClient) then,
  ) = _$InvoiceClientCopyWithImpl<$Res, InvoiceClient>;
  @useResult
  $Res call({int id, String name, String taxId});
}

/// @nodoc
class _$InvoiceClientCopyWithImpl<$Res, $Val extends InvoiceClient>
    implements $InvoiceClientCopyWith<$Res> {
  _$InvoiceClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? taxId = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InvoiceClientImplCopyWith<$Res>
    implements $InvoiceClientCopyWith<$Res> {
  factory _$$InvoiceClientImplCopyWith(
    _$InvoiceClientImpl value,
    $Res Function(_$InvoiceClientImpl) then,
  ) = __$$InvoiceClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String taxId});
}

/// @nodoc
class __$$InvoiceClientImplCopyWithImpl<$Res>
    extends _$InvoiceClientCopyWithImpl<$Res, _$InvoiceClientImpl>
    implements _$$InvoiceClientImplCopyWith<$Res> {
  __$$InvoiceClientImplCopyWithImpl(
    _$InvoiceClientImpl _value,
    $Res Function(_$InvoiceClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? taxId = null}) {
    return _then(
      _$InvoiceClientImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceClientImpl implements _InvoiceClient {
  const _$InvoiceClientImpl({
    required this.id,
    required this.name,
    required this.taxId,
  });

  factory _$InvoiceClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceClientImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String taxId;

  @override
  String toString() {
    return 'InvoiceClient(id: $id, name: $name, taxId: $taxId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceClientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.taxId, taxId) || other.taxId == taxId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, taxId);

  /// Create a copy of InvoiceClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceClientImplCopyWith<_$InvoiceClientImpl> get copyWith =>
      __$$InvoiceClientImplCopyWithImpl<_$InvoiceClientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceClientImplToJson(this);
  }
}

abstract class _InvoiceClient implements InvoiceClient {
  const factory _InvoiceClient({
    required final int id,
    required final String name,
    required final String taxId,
  }) = _$InvoiceClientImpl;

  factory _InvoiceClient.fromJson(Map<String, dynamic> json) =
      _$InvoiceClientImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get taxId;

  /// Create a copy of InvoiceClient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceClientImplCopyWith<_$InvoiceClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvoiceDetail _$InvoiceDetailFromJson(Map<String, dynamic> json) {
  return _InvoiceDetail.fromJson(json);
}

/// @nodoc
mixin _$InvoiceDetail {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get series => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get total => throw _privateConstructorUsedError;
  String get invoiceType => throw _privateConstructorUsedError;
  String? get taxKind => throw _privateConstructorUsedError;
  String? get publicNotes => throw _privateConstructorUsedError;
  String? get invoiceNote => throw _privateConstructorUsedError;
  InvoiceDetailClient? get client => throw _privateConstructorUsedError;
  CreatedBy? get createdBy => throw _privateConstructorUsedError;
  List<InvoiceLine> get lines => throw _privateConstructorUsedError;
  List<Payment> get payments => throw _privateConstructorUsedError;

  /// Serializes this InvoiceDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceDetailCopyWith<InvoiceDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceDetailCopyWith<$Res> {
  factory $InvoiceDetailCopyWith(
    InvoiceDetail value,
    $Res Function(InvoiceDetail) then,
  ) = _$InvoiceDetailCopyWithImpl<$Res, InvoiceDetail>;
  @useResult
  $Res call({
    int id,
    String type,
    String status,
    String series,
    int number,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String invoiceType,
    String? taxKind,
    String? publicNotes,
    String? invoiceNote,
    InvoiceDetailClient? client,
    CreatedBy? createdBy,
    List<InvoiceLine> lines,
    List<Payment> payments,
  });

  $InvoiceDetailClientCopyWith<$Res>? get client;
  $CreatedByCopyWith<$Res>? get createdBy;
}

/// @nodoc
class _$InvoiceDetailCopyWithImpl<$Res, $Val extends InvoiceDetail>
    implements $InvoiceDetailCopyWith<$Res> {
  _$InvoiceDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? series = null,
    Object? number = null,
    Object? issuedAt = null,
    Object? total = null,
    Object? invoiceType = null,
    Object? taxKind = freezed,
    Object? publicNotes = freezed,
    Object? invoiceNote = freezed,
    Object? client = freezed,
    Object? createdBy = freezed,
    Object? lines = null,
    Object? payments = null,
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
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            series: null == series
                ? _value.series
                : series // ignore: cast_nullable_to_non_nullable
                      as String,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            issuedAt: null == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            invoiceType: null == invoiceType
                ? _value.invoiceType
                : invoiceType // ignore: cast_nullable_to_non_nullable
                      as String,
            taxKind: freezed == taxKind
                ? _value.taxKind
                : taxKind // ignore: cast_nullable_to_non_nullable
                      as String?,
            publicNotes: freezed == publicNotes
                ? _value.publicNotes
                : publicNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            invoiceNote: freezed == invoiceNote
                ? _value.invoiceNote
                : invoiceNote // ignore: cast_nullable_to_non_nullable
                      as String?,
            client: freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                      as InvoiceDetailClient?,
            createdBy: freezed == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as CreatedBy?,
            lines: null == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<InvoiceLine>,
            payments: null == payments
                ? _value.payments
                : payments // ignore: cast_nullable_to_non_nullable
                      as List<Payment>,
          )
          as $Val,
    );
  }

  /// Create a copy of InvoiceDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvoiceDetailClientCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $InvoiceDetailClientCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of InvoiceDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreatedByCopyWith<$Res>? get createdBy {
    if (_value.createdBy == null) {
      return null;
    }

    return $CreatedByCopyWith<$Res>(_value.createdBy!, (value) {
      return _then(_value.copyWith(createdBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InvoiceDetailImplCopyWith<$Res>
    implements $InvoiceDetailCopyWith<$Res> {
  factory _$$InvoiceDetailImplCopyWith(
    _$InvoiceDetailImpl value,
    $Res Function(_$InvoiceDetailImpl) then,
  ) = __$$InvoiceDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String type,
    String status,
    String series,
    int number,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String invoiceType,
    String? taxKind,
    String? publicNotes,
    String? invoiceNote,
    InvoiceDetailClient? client,
    CreatedBy? createdBy,
    List<InvoiceLine> lines,
    List<Payment> payments,
  });

  @override
  $InvoiceDetailClientCopyWith<$Res>? get client;
  @override
  $CreatedByCopyWith<$Res>? get createdBy;
}

/// @nodoc
class __$$InvoiceDetailImplCopyWithImpl<$Res>
    extends _$InvoiceDetailCopyWithImpl<$Res, _$InvoiceDetailImpl>
    implements _$$InvoiceDetailImplCopyWith<$Res> {
  __$$InvoiceDetailImplCopyWithImpl(
    _$InvoiceDetailImpl _value,
    $Res Function(_$InvoiceDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? series = null,
    Object? number = null,
    Object? issuedAt = null,
    Object? total = null,
    Object? invoiceType = null,
    Object? taxKind = freezed,
    Object? publicNotes = freezed,
    Object? invoiceNote = freezed,
    Object? client = freezed,
    Object? createdBy = freezed,
    Object? lines = null,
    Object? payments = null,
  }) {
    return _then(
      _$InvoiceDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        series: null == series
            ? _value.series
            : series // ignore: cast_nullable_to_non_nullable
                  as String,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        issuedAt: null == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        invoiceType: null == invoiceType
            ? _value.invoiceType
            : invoiceType // ignore: cast_nullable_to_non_nullable
                  as String,
        taxKind: freezed == taxKind
            ? _value.taxKind
            : taxKind // ignore: cast_nullable_to_non_nullable
                  as String?,
        publicNotes: freezed == publicNotes
            ? _value.publicNotes
            : publicNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        invoiceNote: freezed == invoiceNote
            ? _value.invoiceNote
            : invoiceNote // ignore: cast_nullable_to_non_nullable
                  as String?,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as InvoiceDetailClient?,
        createdBy: freezed == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as CreatedBy?,
        lines: null == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<InvoiceLine>,
        payments: null == payments
            ? _value._payments
            : payments // ignore: cast_nullable_to_non_nullable
                  as List<Payment>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceDetailImpl implements _InvoiceDetail {
  const _$InvoiceDetailImpl({
    required this.id,
    required this.type,
    required this.status,
    required this.series,
    required this.number,
    required this.issuedAt,
    @JsonKey(fromJson: toDouble) required this.total,
    required this.invoiceType,
    this.taxKind,
    this.publicNotes,
    this.invoiceNote,
    this.client,
    this.createdBy,
    required final List<InvoiceLine> lines,
    required final List<Payment> payments,
  }) : _lines = lines,
       _payments = payments;

  factory _$InvoiceDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final String status;
  @override
  final String series;
  @override
  final int number;
  @override
  final String issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  final double total;
  @override
  final String invoiceType;
  @override
  final String? taxKind;
  @override
  final String? publicNotes;
  @override
  final String? invoiceNote;
  @override
  final InvoiceDetailClient? client;
  @override
  final CreatedBy? createdBy;
  final List<InvoiceLine> _lines;
  @override
  List<InvoiceLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  final List<Payment> _payments;
  @override
  List<Payment> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  String toString() {
    return 'InvoiceDetail(id: $id, type: $type, status: $status, series: $series, number: $number, issuedAt: $issuedAt, total: $total, invoiceType: $invoiceType, taxKind: $taxKind, publicNotes: $publicNotes, invoiceNote: $invoiceNote, client: $client, createdBy: $createdBy, lines: $lines, payments: $payments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.invoiceType, invoiceType) ||
                other.invoiceType == invoiceType) &&
            (identical(other.taxKind, taxKind) || other.taxKind == taxKind) &&
            (identical(other.publicNotes, publicNotes) ||
                other.publicNotes == publicNotes) &&
            (identical(other.invoiceNote, invoiceNote) ||
                other.invoiceNote == invoiceNote) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            const DeepCollectionEquality().equals(other._payments, _payments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    status,
    series,
    number,
    issuedAt,
    total,
    invoiceType,
    taxKind,
    publicNotes,
    invoiceNote,
    client,
    createdBy,
    const DeepCollectionEquality().hash(_lines),
    const DeepCollectionEquality().hash(_payments),
  );

  /// Create a copy of InvoiceDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceDetailImplCopyWith<_$InvoiceDetailImpl> get copyWith =>
      __$$InvoiceDetailImplCopyWithImpl<_$InvoiceDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceDetailImplToJson(this);
  }
}

abstract class _InvoiceDetail implements InvoiceDetail {
  const factory _InvoiceDetail({
    required final int id,
    required final String type,
    required final String status,
    required final String series,
    required final int number,
    required final String issuedAt,
    @JsonKey(fromJson: toDouble) required final double total,
    required final String invoiceType,
    final String? taxKind,
    final String? publicNotes,
    final String? invoiceNote,
    final InvoiceDetailClient? client,
    final CreatedBy? createdBy,
    required final List<InvoiceLine> lines,
    required final List<Payment> payments,
  }) = _$InvoiceDetailImpl;

  factory _InvoiceDetail.fromJson(Map<String, dynamic> json) =
      _$InvoiceDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  String get status;
  @override
  String get series;
  @override
  int get number;
  @override
  String get issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  double get total;
  @override
  String get invoiceType;
  @override
  String? get taxKind;
  @override
  String? get publicNotes;
  @override
  String? get invoiceNote;
  @override
  InvoiceDetailClient? get client;
  @override
  CreatedBy? get createdBy;
  @override
  List<InvoiceLine> get lines;
  @override
  List<Payment> get payments;

  /// Create a copy of InvoiceDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceDetailImplCopyWith<_$InvoiceDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvoiceDetailClient _$InvoiceDetailClientFromJson(Map<String, dynamic> json) {
  return _InvoiceDetailClient.fromJson(json);
}

/// @nodoc
mixin _$InvoiceDetailClient {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get taxId => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;

  /// Serializes this InvoiceDetailClient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceDetailClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceDetailClientCopyWith<InvoiceDetailClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceDetailClientCopyWith<$Res> {
  factory $InvoiceDetailClientCopyWith(
    InvoiceDetailClient value,
    $Res Function(InvoiceDetailClient) then,
  ) = _$InvoiceDetailClientCopyWithImpl<$Res, InvoiceDetailClient>;
  @useResult
  $Res call({
    int id,
    String name,
    String taxId,
    String? email,
    String? phone,
    String? address,
    String? city,
  });
}

/// @nodoc
class _$InvoiceDetailClientCopyWithImpl<$Res, $Val extends InvoiceDetailClient>
    implements $InvoiceDetailClientCopyWith<$Res> {
  _$InvoiceDetailClientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceDetailClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? taxId = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? city = freezed,
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
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InvoiceDetailClientImplCopyWith<$Res>
    implements $InvoiceDetailClientCopyWith<$Res> {
  factory _$$InvoiceDetailClientImplCopyWith(
    _$InvoiceDetailClientImpl value,
    $Res Function(_$InvoiceDetailClientImpl) then,
  ) = __$$InvoiceDetailClientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String taxId,
    String? email,
    String? phone,
    String? address,
    String? city,
  });
}

/// @nodoc
class __$$InvoiceDetailClientImplCopyWithImpl<$Res>
    extends _$InvoiceDetailClientCopyWithImpl<$Res, _$InvoiceDetailClientImpl>
    implements _$$InvoiceDetailClientImplCopyWith<$Res> {
  __$$InvoiceDetailClientImplCopyWithImpl(
    _$InvoiceDetailClientImpl _value,
    $Res Function(_$InvoiceDetailClientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceDetailClient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? taxId = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? city = freezed,
  }) {
    return _then(
      _$InvoiceDetailClientImpl(
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
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InvoiceDetailClientImpl implements _InvoiceDetailClient {
  const _$InvoiceDetailClientImpl({
    required this.id,
    required this.name,
    required this.taxId,
    this.email,
    this.phone,
    this.address,
    this.city,
  });

  factory _$InvoiceDetailClientImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceDetailClientImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String taxId;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? address;
  @override
  final String? city;

  @override
  String toString() {
    return 'InvoiceDetailClient(id: $id, name: $name, taxId: $taxId, email: $email, phone: $phone, address: $address, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceDetailClientImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.taxId, taxId) || other.taxId == taxId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, taxId, email, phone, address, city);

  /// Create a copy of InvoiceDetailClient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceDetailClientImplCopyWith<_$InvoiceDetailClientImpl> get copyWith =>
      __$$InvoiceDetailClientImplCopyWithImpl<_$InvoiceDetailClientImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceDetailClientImplToJson(this);
  }
}

abstract class _InvoiceDetailClient implements InvoiceDetailClient {
  const factory _InvoiceDetailClient({
    required final int id,
    required final String name,
    required final String taxId,
    final String? email,
    final String? phone,
    final String? address,
    final String? city,
  }) = _$InvoiceDetailClientImpl;

  factory _InvoiceDetailClient.fromJson(Map<String, dynamic> json) =
      _$InvoiceDetailClientImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get taxId;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get address;
  @override
  String? get city;

  /// Create a copy of InvoiceDetailClient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceDetailClientImplCopyWith<_$InvoiceDetailClientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) {
  return _CreatedBy.fromJson(json);
}

/// @nodoc
mixin _$CreatedBy {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this CreatedBy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatedByCopyWith<CreatedBy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatedByCopyWith<$Res> {
  factory $CreatedByCopyWith(CreatedBy value, $Res Function(CreatedBy) then) =
      _$CreatedByCopyWithImpl<$Res, CreatedBy>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$CreatedByCopyWithImpl<$Res, $Val extends CreatedBy>
    implements $CreatedByCopyWith<$Res> {
  _$CreatedByCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreatedByImplCopyWith<$Res>
    implements $CreatedByCopyWith<$Res> {
  factory _$$CreatedByImplCopyWith(
    _$CreatedByImpl value,
    $Res Function(_$CreatedByImpl) then,
  ) = __$$CreatedByImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$CreatedByImplCopyWithImpl<$Res>
    extends _$CreatedByCopyWithImpl<$Res, _$CreatedByImpl>
    implements _$$CreatedByImplCopyWith<$Res> {
  __$$CreatedByImplCopyWithImpl(
    _$CreatedByImpl _value,
    $Res Function(_$CreatedByImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$CreatedByImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatedByImpl implements _CreatedBy {
  const _$CreatedByImpl({required this.id, required this.name});

  factory _$CreatedByImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatedByImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'CreatedBy(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatedByImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of CreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatedByImplCopyWith<_$CreatedByImpl> get copyWith =>
      __$$CreatedByImplCopyWithImpl<_$CreatedByImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatedByImplToJson(this);
  }
}

abstract class _CreatedBy implements CreatedBy {
  const factory _CreatedBy({
    required final int id,
    required final String name,
  }) = _$CreatedByImpl;

  factory _CreatedBy.fromJson(Map<String, dynamic> json) =
      _$CreatedByImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of CreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatedByImplCopyWith<_$CreatedByImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvoiceLine _$InvoiceLineFromJson(Map<String, dynamic> json) {
  return _InvoiceLine.fromJson(json);
}

/// @nodoc
mixin _$InvoiceLine {
  int get id => throw _privateConstructorUsedError;
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

  /// Serializes this InvoiceLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvoiceLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvoiceLineCopyWith<InvoiceLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceLineCopyWith<$Res> {
  factory $InvoiceLineCopyWith(
    InvoiceLine value,
    $Res Function(InvoiceLine) then,
  ) = _$InvoiceLineCopyWithImpl<$Res, InvoiceLine>;
  @useResult
  $Res call({
    int id,
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
class _$InvoiceLineCopyWithImpl<$Res, $Val extends InvoiceLine>
    implements $InvoiceLineCopyWith<$Res> {
  _$InvoiceLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
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
abstract class _$$InvoiceLineImplCopyWith<$Res>
    implements $InvoiceLineCopyWith<$Res> {
  factory _$$InvoiceLineImplCopyWith(
    _$InvoiceLineImpl value,
    $Res Function(_$InvoiceLineImpl) then,
  ) = __$$InvoiceLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
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
class __$$InvoiceLineImplCopyWithImpl<$Res>
    extends _$InvoiceLineCopyWithImpl<$Res, _$InvoiceLineImpl>
    implements _$$InvoiceLineImplCopyWith<$Res> {
  __$$InvoiceLineImplCopyWithImpl(
    _$InvoiceLineImpl _value,
    $Res Function(_$InvoiceLineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? discountRate = null,
    Object? taxRate = null,
    Object? taxAmount = null,
    Object? total = null,
  }) {
    return _then(
      _$InvoiceLineImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$InvoiceLineImpl implements _InvoiceLine {
  const _$InvoiceLineImpl({
    required this.id,
    required this.description,
    @JsonKey(fromJson: toDouble) required this.quantity,
    @JsonKey(fromJson: toDouble) required this.unitPrice,
    @JsonKey(fromJson: toDouble) required this.discountRate,
    @JsonKey(fromJson: toDouble) required this.taxRate,
    @JsonKey(fromJson: toDouble) required this.taxAmount,
    @JsonKey(fromJson: toDouble) required this.total,
  });

  factory _$InvoiceLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvoiceLineImplFromJson(json);

  @override
  final int id;
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
    return 'InvoiceLine(id: $id, description: $description, quantity: $quantity, unitPrice: $unitPrice, discountRate: $discountRate, taxRate: $taxRate, taxAmount: $taxAmount, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceLineImpl &&
            (identical(other.id, id) || other.id == id) &&
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
    description,
    quantity,
    unitPrice,
    discountRate,
    taxRate,
    taxAmount,
    total,
  );

  /// Create a copy of InvoiceLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceLineImplCopyWith<_$InvoiceLineImpl> get copyWith =>
      __$$InvoiceLineImplCopyWithImpl<_$InvoiceLineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvoiceLineImplToJson(this);
  }
}

abstract class _InvoiceLine implements InvoiceLine {
  const factory _InvoiceLine({
    required final int id,
    required final String description,
    @JsonKey(fromJson: toDouble) required final double quantity,
    @JsonKey(fromJson: toDouble) required final double unitPrice,
    @JsonKey(fromJson: toDouble) required final double discountRate,
    @JsonKey(fromJson: toDouble) required final double taxRate,
    @JsonKey(fromJson: toDouble) required final double taxAmount,
    @JsonKey(fromJson: toDouble) required final double total,
  }) = _$InvoiceLineImpl;

  factory _InvoiceLine.fromJson(Map<String, dynamic> json) =
      _$InvoiceLineImpl.fromJson;

  @override
  int get id;
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

  /// Create a copy of InvoiceLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceLineImplCopyWith<_$InvoiceLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
