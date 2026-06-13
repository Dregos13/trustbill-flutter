// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SaleListItem _$SaleListItemFromJson(Map<String, dynamic> json) {
  return _SaleListItem.fromJson(json);
}

/// @nodoc
mixin _$SaleListItem {
  int get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get regime => throw _privateConstructorUsedError;
  int? get budgetId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get totalPlanned => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get totalInvoiced => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get totalPending => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  SaleParty? get client => throw _privateConstructorUsedError;
  SaleParty? get vendor => throw _privateConstructorUsedError;

  /// Serializes this SaleListItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleListItemCopyWith<SaleListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleListItemCopyWith<$Res> {
  factory $SaleListItemCopyWith(
    SaleListItem value,
    $Res Function(SaleListItem) then,
  ) = _$SaleListItemCopyWithImpl<$Res, SaleListItem>;
  @useResult
  $Res call({
    int id,
    String code,
    String status,
    String? regime,
    int? budgetId,
    @JsonKey(fromJson: toDouble) double totalPlanned,
    @JsonKey(fromJson: toDouble) double totalInvoiced,
    @JsonKey(fromJson: toDouble) double totalPending,
    String createdAt,
    SaleParty? client,
    SaleParty? vendor,
  });

  $SalePartyCopyWith<$Res>? get client;
  $SalePartyCopyWith<$Res>? get vendor;
}

/// @nodoc
class _$SaleListItemCopyWithImpl<$Res, $Val extends SaleListItem>
    implements $SaleListItemCopyWith<$Res> {
  _$SaleListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? status = null,
    Object? regime = freezed,
    Object? budgetId = freezed,
    Object? totalPlanned = null,
    Object? totalInvoiced = null,
    Object? totalPending = null,
    Object? createdAt = null,
    Object? client = freezed,
    Object? vendor = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            regime: freezed == regime
                ? _value.regime
                : regime // ignore: cast_nullable_to_non_nullable
                      as String?,
            budgetId: freezed == budgetId
                ? _value.budgetId
                : budgetId // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalPlanned: null == totalPlanned
                ? _value.totalPlanned
                : totalPlanned // ignore: cast_nullable_to_non_nullable
                      as double,
            totalInvoiced: null == totalInvoiced
                ? _value.totalInvoiced
                : totalInvoiced // ignore: cast_nullable_to_non_nullable
                      as double,
            totalPending: null == totalPending
                ? _value.totalPending
                : totalPending // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            client: freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                      as SaleParty?,
            vendor: freezed == vendor
                ? _value.vendor
                : vendor // ignore: cast_nullable_to_non_nullable
                      as SaleParty?,
          )
          as $Val,
    );
  }

  /// Create a copy of SaleListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SalePartyCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $SalePartyCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of SaleListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SalePartyCopyWith<$Res>? get vendor {
    if (_value.vendor == null) {
      return null;
    }

    return $SalePartyCopyWith<$Res>(_value.vendor!, (value) {
      return _then(_value.copyWith(vendor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SaleListItemImplCopyWith<$Res>
    implements $SaleListItemCopyWith<$Res> {
  factory _$$SaleListItemImplCopyWith(
    _$SaleListItemImpl value,
    $Res Function(_$SaleListItemImpl) then,
  ) = __$$SaleListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String code,
    String status,
    String? regime,
    int? budgetId,
    @JsonKey(fromJson: toDouble) double totalPlanned,
    @JsonKey(fromJson: toDouble) double totalInvoiced,
    @JsonKey(fromJson: toDouble) double totalPending,
    String createdAt,
    SaleParty? client,
    SaleParty? vendor,
  });

  @override
  $SalePartyCopyWith<$Res>? get client;
  @override
  $SalePartyCopyWith<$Res>? get vendor;
}

/// @nodoc
class __$$SaleListItemImplCopyWithImpl<$Res>
    extends _$SaleListItemCopyWithImpl<$Res, _$SaleListItemImpl>
    implements _$$SaleListItemImplCopyWith<$Res> {
  __$$SaleListItemImplCopyWithImpl(
    _$SaleListItemImpl _value,
    $Res Function(_$SaleListItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleListItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? status = null,
    Object? regime = freezed,
    Object? budgetId = freezed,
    Object? totalPlanned = null,
    Object? totalInvoiced = null,
    Object? totalPending = null,
    Object? createdAt = null,
    Object? client = freezed,
    Object? vendor = freezed,
  }) {
    return _then(
      _$SaleListItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        regime: freezed == regime
            ? _value.regime
            : regime // ignore: cast_nullable_to_non_nullable
                  as String?,
        budgetId: freezed == budgetId
            ? _value.budgetId
            : budgetId // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalPlanned: null == totalPlanned
            ? _value.totalPlanned
            : totalPlanned // ignore: cast_nullable_to_non_nullable
                  as double,
        totalInvoiced: null == totalInvoiced
            ? _value.totalInvoiced
            : totalInvoiced // ignore: cast_nullable_to_non_nullable
                  as double,
        totalPending: null == totalPending
            ? _value.totalPending
            : totalPending // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as SaleParty?,
        vendor: freezed == vendor
            ? _value.vendor
            : vendor // ignore: cast_nullable_to_non_nullable
                  as SaleParty?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleListItemImpl implements _SaleListItem {
  const _$SaleListItemImpl({
    required this.id,
    required this.code,
    required this.status,
    this.regime,
    this.budgetId,
    @JsonKey(fromJson: toDouble) required this.totalPlanned,
    @JsonKey(fromJson: toDouble) required this.totalInvoiced,
    @JsonKey(fromJson: toDouble) required this.totalPending,
    required this.createdAt,
    this.client,
    this.vendor,
  });

  factory _$SaleListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleListItemImplFromJson(json);

  @override
  final int id;
  @override
  final String code;
  @override
  final String status;
  @override
  final String? regime;
  @override
  final int? budgetId;
  @override
  @JsonKey(fromJson: toDouble)
  final double totalPlanned;
  @override
  @JsonKey(fromJson: toDouble)
  final double totalInvoiced;
  @override
  @JsonKey(fromJson: toDouble)
  final double totalPending;
  @override
  final String createdAt;
  @override
  final SaleParty? client;
  @override
  final SaleParty? vendor;

  @override
  String toString() {
    return 'SaleListItem(id: $id, code: $code, status: $status, regime: $regime, budgetId: $budgetId, totalPlanned: $totalPlanned, totalInvoiced: $totalInvoiced, totalPending: $totalPending, createdAt: $createdAt, client: $client, vendor: $vendor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.regime, regime) || other.regime == regime) &&
            (identical(other.budgetId, budgetId) ||
                other.budgetId == budgetId) &&
            (identical(other.totalPlanned, totalPlanned) ||
                other.totalPlanned == totalPlanned) &&
            (identical(other.totalInvoiced, totalInvoiced) ||
                other.totalInvoiced == totalInvoiced) &&
            (identical(other.totalPending, totalPending) ||
                other.totalPending == totalPending) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.vendor, vendor) || other.vendor == vendor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    code,
    status,
    regime,
    budgetId,
    totalPlanned,
    totalInvoiced,
    totalPending,
    createdAt,
    client,
    vendor,
  );

  /// Create a copy of SaleListItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleListItemImplCopyWith<_$SaleListItemImpl> get copyWith =>
      __$$SaleListItemImplCopyWithImpl<_$SaleListItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleListItemImplToJson(this);
  }
}

abstract class _SaleListItem implements SaleListItem {
  const factory _SaleListItem({
    required final int id,
    required final String code,
    required final String status,
    final String? regime,
    final int? budgetId,
    @JsonKey(fromJson: toDouble) required final double totalPlanned,
    @JsonKey(fromJson: toDouble) required final double totalInvoiced,
    @JsonKey(fromJson: toDouble) required final double totalPending,
    required final String createdAt,
    final SaleParty? client,
    final SaleParty? vendor,
  }) = _$SaleListItemImpl;

  factory _SaleListItem.fromJson(Map<String, dynamic> json) =
      _$SaleListItemImpl.fromJson;

  @override
  int get id;
  @override
  String get code;
  @override
  String get status;
  @override
  String? get regime;
  @override
  int? get budgetId;
  @override
  @JsonKey(fromJson: toDouble)
  double get totalPlanned;
  @override
  @JsonKey(fromJson: toDouble)
  double get totalInvoiced;
  @override
  @JsonKey(fromJson: toDouble)
  double get totalPending;
  @override
  String get createdAt;
  @override
  SaleParty? get client;
  @override
  SaleParty? get vendor;

  /// Create a copy of SaleListItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleListItemImplCopyWith<_$SaleListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleParty _$SalePartyFromJson(Map<String, dynamic> json) {
  return _SaleParty.fromJson(json);
}

/// @nodoc
mixin _$SaleParty {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get taxId => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Serializes this SaleParty to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleParty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalePartyCopyWith<SaleParty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalePartyCopyWith<$Res> {
  factory $SalePartyCopyWith(SaleParty value, $Res Function(SaleParty) then) =
      _$SalePartyCopyWithImpl<$Res, SaleParty>;
  @useResult
  $Res call({int id, String? name, String? taxId, String? email});
}

/// @nodoc
class _$SalePartyCopyWithImpl<$Res, $Val extends SaleParty>
    implements $SalePartyCopyWith<$Res> {
  _$SalePartyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleParty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? taxId = freezed,
    Object? email = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            taxId: freezed == taxId
                ? _value.taxId
                : taxId // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SalePartyImplCopyWith<$Res>
    implements $SalePartyCopyWith<$Res> {
  factory _$$SalePartyImplCopyWith(
    _$SalePartyImpl value,
    $Res Function(_$SalePartyImpl) then,
  ) = __$$SalePartyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? name, String? taxId, String? email});
}

/// @nodoc
class __$$SalePartyImplCopyWithImpl<$Res>
    extends _$SalePartyCopyWithImpl<$Res, _$SalePartyImpl>
    implements _$$SalePartyImplCopyWith<$Res> {
  __$$SalePartyImplCopyWithImpl(
    _$SalePartyImpl _value,
    $Res Function(_$SalePartyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleParty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? taxId = freezed,
    Object? email = freezed,
  }) {
    return _then(
      _$SalePartyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        taxId: freezed == taxId
            ? _value.taxId
            : taxId // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SalePartyImpl implements _SaleParty {
  const _$SalePartyImpl({required this.id, this.name, this.taxId, this.email});

  factory _$SalePartyImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalePartyImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  final String? taxId;
  @override
  final String? email;

  @override
  String toString() {
    return 'SaleParty(id: $id, name: $name, taxId: $taxId, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalePartyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.taxId, taxId) || other.taxId == taxId) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, taxId, email);

  /// Create a copy of SaleParty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalePartyImplCopyWith<_$SalePartyImpl> get copyWith =>
      __$$SalePartyImplCopyWithImpl<_$SalePartyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalePartyImplToJson(this);
  }
}

abstract class _SaleParty implements SaleParty {
  const factory _SaleParty({
    required final int id,
    final String? name,
    final String? taxId,
    final String? email,
  }) = _$SalePartyImpl;

  factory _SaleParty.fromJson(Map<String, dynamic> json) =
      _$SalePartyImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  String? get taxId;
  @override
  String? get email;

  /// Create a copy of SaleParty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalePartyImplCopyWith<_$SalePartyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AvailableBudget _$AvailableBudgetFromJson(Map<String, dynamic> json) {
  return _AvailableBudget.fromJson(json);
}

/// @nodoc
mixin _$AvailableBudget {
  int get id => throw _privateConstructorUsedError;
  String get series => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get total => throw _privateConstructorUsedError;
  String? get taxKind => throw _privateConstructorUsedError;
  String? get quoteStatus => throw _privateConstructorUsedError;
  SaleParty? get client => throw _privateConstructorUsedError;

  /// Serializes this AvailableBudget to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AvailableBudget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailableBudgetCopyWith<AvailableBudget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableBudgetCopyWith<$Res> {
  factory $AvailableBudgetCopyWith(
    AvailableBudget value,
    $Res Function(AvailableBudget) then,
  ) = _$AvailableBudgetCopyWithImpl<$Res, AvailableBudget>;
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String? taxKind,
    String? quoteStatus,
    SaleParty? client,
  });

  $SalePartyCopyWith<$Res>? get client;
}

/// @nodoc
class _$AvailableBudgetCopyWithImpl<$Res, $Val extends AvailableBudget>
    implements $AvailableBudgetCopyWith<$Res> {
  _$AvailableBudgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailableBudget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? issuedAt = null,
    Object? total = null,
    Object? taxKind = freezed,
    Object? quoteStatus = freezed,
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
            quoteStatus: freezed == quoteStatus
                ? _value.quoteStatus
                : quoteStatus // ignore: cast_nullable_to_non_nullable
                      as String?,
            client: freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                      as SaleParty?,
          )
          as $Val,
    );
  }

  /// Create a copy of AvailableBudget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SalePartyCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $SalePartyCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AvailableBudgetImplCopyWith<$Res>
    implements $AvailableBudgetCopyWith<$Res> {
  factory _$$AvailableBudgetImplCopyWith(
    _$AvailableBudgetImpl value,
    $Res Function(_$AvailableBudgetImpl) then,
  ) = __$$AvailableBudgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String? taxKind,
    String? quoteStatus,
    SaleParty? client,
  });

  @override
  $SalePartyCopyWith<$Res>? get client;
}

/// @nodoc
class __$$AvailableBudgetImplCopyWithImpl<$Res>
    extends _$AvailableBudgetCopyWithImpl<$Res, _$AvailableBudgetImpl>
    implements _$$AvailableBudgetImplCopyWith<$Res> {
  __$$AvailableBudgetImplCopyWithImpl(
    _$AvailableBudgetImpl _value,
    $Res Function(_$AvailableBudgetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AvailableBudget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? issuedAt = null,
    Object? total = null,
    Object? taxKind = freezed,
    Object? quoteStatus = freezed,
    Object? client = freezed,
  }) {
    return _then(
      _$AvailableBudgetImpl(
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
        quoteStatus: freezed == quoteStatus
            ? _value.quoteStatus
            : quoteStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as SaleParty?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailableBudgetImpl implements _AvailableBudget {
  const _$AvailableBudgetImpl({
    required this.id,
    required this.series,
    required this.number,
    required this.issuedAt,
    @JsonKey(fromJson: toDouble) required this.total,
    this.taxKind,
    this.quoteStatus,
    this.client,
  });

  factory _$AvailableBudgetImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailableBudgetImplFromJson(json);

  @override
  final int id;
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
  final String? taxKind;
  @override
  final String? quoteStatus;
  @override
  final SaleParty? client;

  @override
  String toString() {
    return 'AvailableBudget(id: $id, series: $series, number: $number, issuedAt: $issuedAt, total: $total, taxKind: $taxKind, quoteStatus: $quoteStatus, client: $client)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableBudgetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.taxKind, taxKind) || other.taxKind == taxKind) &&
            (identical(other.quoteStatus, quoteStatus) ||
                other.quoteStatus == quoteStatus) &&
            (identical(other.client, client) || other.client == client));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    series,
    number,
    issuedAt,
    total,
    taxKind,
    quoteStatus,
    client,
  );

  /// Create a copy of AvailableBudget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableBudgetImplCopyWith<_$AvailableBudgetImpl> get copyWith =>
      __$$AvailableBudgetImplCopyWithImpl<_$AvailableBudgetImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailableBudgetImplToJson(this);
  }
}

abstract class _AvailableBudget implements AvailableBudget {
  const factory _AvailableBudget({
    required final int id,
    required final String series,
    required final int number,
    required final String issuedAt,
    @JsonKey(fromJson: toDouble) required final double total,
    final String? taxKind,
    final String? quoteStatus,
    final SaleParty? client,
  }) = _$AvailableBudgetImpl;

  factory _AvailableBudget.fromJson(Map<String, dynamic> json) =
      _$AvailableBudgetImpl.fromJson;

  @override
  int get id;
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
  String? get taxKind;
  @override
  String? get quoteStatus;
  @override
  SaleParty? get client;

  /// Create a copy of AvailableBudget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailableBudgetImplCopyWith<_$AvailableBudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleDetail _$SaleDetailFromJson(Map<String, dynamic> json) {
  return _SaleDetail.fromJson(json);
}

/// @nodoc
mixin _$SaleDetail {
  int get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get regime => throw _privateConstructorUsedError;
  int? get budgetId => throw _privateConstructorUsedError;
  String? get internalNotes => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get totalPlanned => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get totalInvoiced => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get totalPending => throw _privateConstructorUsedError;
  SaleParty? get client => throw _privateConstructorUsedError;
  SaleParty? get vendor => throw _privateConstructorUsedError;
  SaleBudgetRef? get budget => throw _privateConstructorUsedError;
  List<SaleDetailLine> get lines => throw _privateConstructorUsedError;
  List<SaleInstallment> get installments => throw _privateConstructorUsedError;
  List<SaleInvoiceRef> get invoices => throw _privateConstructorUsedError;

  /// Serializes this SaleDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleDetailCopyWith<SaleDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleDetailCopyWith<$Res> {
  factory $SaleDetailCopyWith(
    SaleDetail value,
    $Res Function(SaleDetail) then,
  ) = _$SaleDetailCopyWithImpl<$Res, SaleDetail>;
  @useResult
  $Res call({
    int id,
    String code,
    String status,
    String? regime,
    int? budgetId,
    String? internalNotes,
    @JsonKey(fromJson: toDouble) double totalPlanned,
    @JsonKey(fromJson: toDouble) double totalInvoiced,
    @JsonKey(fromJson: toDouble) double totalPending,
    SaleParty? client,
    SaleParty? vendor,
    SaleBudgetRef? budget,
    List<SaleDetailLine> lines,
    List<SaleInstallment> installments,
    List<SaleInvoiceRef> invoices,
  });

  $SalePartyCopyWith<$Res>? get client;
  $SalePartyCopyWith<$Res>? get vendor;
  $SaleBudgetRefCopyWith<$Res>? get budget;
}

/// @nodoc
class _$SaleDetailCopyWithImpl<$Res, $Val extends SaleDetail>
    implements $SaleDetailCopyWith<$Res> {
  _$SaleDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? status = null,
    Object? regime = freezed,
    Object? budgetId = freezed,
    Object? internalNotes = freezed,
    Object? totalPlanned = null,
    Object? totalInvoiced = null,
    Object? totalPending = null,
    Object? client = freezed,
    Object? vendor = freezed,
    Object? budget = freezed,
    Object? lines = null,
    Object? installments = null,
    Object? invoices = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            regime: freezed == regime
                ? _value.regime
                : regime // ignore: cast_nullable_to_non_nullable
                      as String?,
            budgetId: freezed == budgetId
                ? _value.budgetId
                : budgetId // ignore: cast_nullable_to_non_nullable
                      as int?,
            internalNotes: freezed == internalNotes
                ? _value.internalNotes
                : internalNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalPlanned: null == totalPlanned
                ? _value.totalPlanned
                : totalPlanned // ignore: cast_nullable_to_non_nullable
                      as double,
            totalInvoiced: null == totalInvoiced
                ? _value.totalInvoiced
                : totalInvoiced // ignore: cast_nullable_to_non_nullable
                      as double,
            totalPending: null == totalPending
                ? _value.totalPending
                : totalPending // ignore: cast_nullable_to_non_nullable
                      as double,
            client: freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                      as SaleParty?,
            vendor: freezed == vendor
                ? _value.vendor
                : vendor // ignore: cast_nullable_to_non_nullable
                      as SaleParty?,
            budget: freezed == budget
                ? _value.budget
                : budget // ignore: cast_nullable_to_non_nullable
                      as SaleBudgetRef?,
            lines: null == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<SaleDetailLine>,
            installments: null == installments
                ? _value.installments
                : installments // ignore: cast_nullable_to_non_nullable
                      as List<SaleInstallment>,
            invoices: null == invoices
                ? _value.invoices
                : invoices // ignore: cast_nullable_to_non_nullable
                      as List<SaleInvoiceRef>,
          )
          as $Val,
    );
  }

  /// Create a copy of SaleDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SalePartyCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $SalePartyCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of SaleDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SalePartyCopyWith<$Res>? get vendor {
    if (_value.vendor == null) {
      return null;
    }

    return $SalePartyCopyWith<$Res>(_value.vendor!, (value) {
      return _then(_value.copyWith(vendor: value) as $Val);
    });
  }

  /// Create a copy of SaleDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SaleBudgetRefCopyWith<$Res>? get budget {
    if (_value.budget == null) {
      return null;
    }

    return $SaleBudgetRefCopyWith<$Res>(_value.budget!, (value) {
      return _then(_value.copyWith(budget: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SaleDetailImplCopyWith<$Res>
    implements $SaleDetailCopyWith<$Res> {
  factory _$$SaleDetailImplCopyWith(
    _$SaleDetailImpl value,
    $Res Function(_$SaleDetailImpl) then,
  ) = __$$SaleDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String code,
    String status,
    String? regime,
    int? budgetId,
    String? internalNotes,
    @JsonKey(fromJson: toDouble) double totalPlanned,
    @JsonKey(fromJson: toDouble) double totalInvoiced,
    @JsonKey(fromJson: toDouble) double totalPending,
    SaleParty? client,
    SaleParty? vendor,
    SaleBudgetRef? budget,
    List<SaleDetailLine> lines,
    List<SaleInstallment> installments,
    List<SaleInvoiceRef> invoices,
  });

  @override
  $SalePartyCopyWith<$Res>? get client;
  @override
  $SalePartyCopyWith<$Res>? get vendor;
  @override
  $SaleBudgetRefCopyWith<$Res>? get budget;
}

/// @nodoc
class __$$SaleDetailImplCopyWithImpl<$Res>
    extends _$SaleDetailCopyWithImpl<$Res, _$SaleDetailImpl>
    implements _$$SaleDetailImplCopyWith<$Res> {
  __$$SaleDetailImplCopyWithImpl(
    _$SaleDetailImpl _value,
    $Res Function(_$SaleDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? status = null,
    Object? regime = freezed,
    Object? budgetId = freezed,
    Object? internalNotes = freezed,
    Object? totalPlanned = null,
    Object? totalInvoiced = null,
    Object? totalPending = null,
    Object? client = freezed,
    Object? vendor = freezed,
    Object? budget = freezed,
    Object? lines = null,
    Object? installments = null,
    Object? invoices = null,
  }) {
    return _then(
      _$SaleDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        regime: freezed == regime
            ? _value.regime
            : regime // ignore: cast_nullable_to_non_nullable
                  as String?,
        budgetId: freezed == budgetId
            ? _value.budgetId
            : budgetId // ignore: cast_nullable_to_non_nullable
                  as int?,
        internalNotes: freezed == internalNotes
            ? _value.internalNotes
            : internalNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalPlanned: null == totalPlanned
            ? _value.totalPlanned
            : totalPlanned // ignore: cast_nullable_to_non_nullable
                  as double,
        totalInvoiced: null == totalInvoiced
            ? _value.totalInvoiced
            : totalInvoiced // ignore: cast_nullable_to_non_nullable
                  as double,
        totalPending: null == totalPending
            ? _value.totalPending
            : totalPending // ignore: cast_nullable_to_non_nullable
                  as double,
        client: freezed == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as SaleParty?,
        vendor: freezed == vendor
            ? _value.vendor
            : vendor // ignore: cast_nullable_to_non_nullable
                  as SaleParty?,
        budget: freezed == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as SaleBudgetRef?,
        lines: null == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<SaleDetailLine>,
        installments: null == installments
            ? _value._installments
            : installments // ignore: cast_nullable_to_non_nullable
                  as List<SaleInstallment>,
        invoices: null == invoices
            ? _value._invoices
            : invoices // ignore: cast_nullable_to_non_nullable
                  as List<SaleInvoiceRef>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleDetailImpl implements _SaleDetail {
  const _$SaleDetailImpl({
    required this.id,
    required this.code,
    required this.status,
    this.regime,
    this.budgetId,
    this.internalNotes,
    @JsonKey(fromJson: toDouble) required this.totalPlanned,
    @JsonKey(fromJson: toDouble) required this.totalInvoiced,
    @JsonKey(fromJson: toDouble) required this.totalPending,
    this.client,
    this.vendor,
    this.budget,
    final List<SaleDetailLine> lines = const [],
    final List<SaleInstallment> installments = const [],
    final List<SaleInvoiceRef> invoices = const [],
  }) : _lines = lines,
       _installments = installments,
       _invoices = invoices;

  factory _$SaleDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String code;
  @override
  final String status;
  @override
  final String? regime;
  @override
  final int? budgetId;
  @override
  final String? internalNotes;
  @override
  @JsonKey(fromJson: toDouble)
  final double totalPlanned;
  @override
  @JsonKey(fromJson: toDouble)
  final double totalInvoiced;
  @override
  @JsonKey(fromJson: toDouble)
  final double totalPending;
  @override
  final SaleParty? client;
  @override
  final SaleParty? vendor;
  @override
  final SaleBudgetRef? budget;
  final List<SaleDetailLine> _lines;
  @override
  @JsonKey()
  List<SaleDetailLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  final List<SaleInstallment> _installments;
  @override
  @JsonKey()
  List<SaleInstallment> get installments {
    if (_installments is EqualUnmodifiableListView) return _installments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_installments);
  }

  final List<SaleInvoiceRef> _invoices;
  @override
  @JsonKey()
  List<SaleInvoiceRef> get invoices {
    if (_invoices is EqualUnmodifiableListView) return _invoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invoices);
  }

  @override
  String toString() {
    return 'SaleDetail(id: $id, code: $code, status: $status, regime: $regime, budgetId: $budgetId, internalNotes: $internalNotes, totalPlanned: $totalPlanned, totalInvoiced: $totalInvoiced, totalPending: $totalPending, client: $client, vendor: $vendor, budget: $budget, lines: $lines, installments: $installments, invoices: $invoices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.regime, regime) || other.regime == regime) &&
            (identical(other.budgetId, budgetId) ||
                other.budgetId == budgetId) &&
            (identical(other.internalNotes, internalNotes) ||
                other.internalNotes == internalNotes) &&
            (identical(other.totalPlanned, totalPlanned) ||
                other.totalPlanned == totalPlanned) &&
            (identical(other.totalInvoiced, totalInvoiced) ||
                other.totalInvoiced == totalInvoiced) &&
            (identical(other.totalPending, totalPending) ||
                other.totalPending == totalPending) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.vendor, vendor) || other.vendor == vendor) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            const DeepCollectionEquality().equals(
              other._installments,
              _installments,
            ) &&
            const DeepCollectionEquality().equals(other._invoices, _invoices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    code,
    status,
    regime,
    budgetId,
    internalNotes,
    totalPlanned,
    totalInvoiced,
    totalPending,
    client,
    vendor,
    budget,
    const DeepCollectionEquality().hash(_lines),
    const DeepCollectionEquality().hash(_installments),
    const DeepCollectionEquality().hash(_invoices),
  );

  /// Create a copy of SaleDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleDetailImplCopyWith<_$SaleDetailImpl> get copyWith =>
      __$$SaleDetailImplCopyWithImpl<_$SaleDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleDetailImplToJson(this);
  }
}

abstract class _SaleDetail implements SaleDetail {
  const factory _SaleDetail({
    required final int id,
    required final String code,
    required final String status,
    final String? regime,
    final int? budgetId,
    final String? internalNotes,
    @JsonKey(fromJson: toDouble) required final double totalPlanned,
    @JsonKey(fromJson: toDouble) required final double totalInvoiced,
    @JsonKey(fromJson: toDouble) required final double totalPending,
    final SaleParty? client,
    final SaleParty? vendor,
    final SaleBudgetRef? budget,
    final List<SaleDetailLine> lines,
    final List<SaleInstallment> installments,
    final List<SaleInvoiceRef> invoices,
  }) = _$SaleDetailImpl;

  factory _SaleDetail.fromJson(Map<String, dynamic> json) =
      _$SaleDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get code;
  @override
  String get status;
  @override
  String? get regime;
  @override
  int? get budgetId;
  @override
  String? get internalNotes;
  @override
  @JsonKey(fromJson: toDouble)
  double get totalPlanned;
  @override
  @JsonKey(fromJson: toDouble)
  double get totalInvoiced;
  @override
  @JsonKey(fromJson: toDouble)
  double get totalPending;
  @override
  SaleParty? get client;
  @override
  SaleParty? get vendor;
  @override
  SaleBudgetRef? get budget;
  @override
  List<SaleDetailLine> get lines;
  @override
  List<SaleInstallment> get installments;
  @override
  List<SaleInvoiceRef> get invoices;

  /// Create a copy of SaleDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleDetailImplCopyWith<_$SaleDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleBudgetRef _$SaleBudgetRefFromJson(Map<String, dynamic> json) {
  return _SaleBudgetRef.fromJson(json);
}

/// @nodoc
mixin _$SaleBudgetRef {
  int get id => throw _privateConstructorUsedError;
  String get series => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get total => throw _privateConstructorUsedError;
  String? get taxKind => throw _privateConstructorUsedError;

  /// Serializes this SaleBudgetRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleBudgetRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleBudgetRefCopyWith<SaleBudgetRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleBudgetRefCopyWith<$Res> {
  factory $SaleBudgetRefCopyWith(
    SaleBudgetRef value,
    $Res Function(SaleBudgetRef) then,
  ) = _$SaleBudgetRefCopyWithImpl<$Res, SaleBudgetRef>;
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String status,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String? taxKind,
  });
}

/// @nodoc
class _$SaleBudgetRefCopyWithImpl<$Res, $Val extends SaleBudgetRef>
    implements $SaleBudgetRefCopyWith<$Res> {
  _$SaleBudgetRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleBudgetRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? status = null,
    Object? issuedAt = null,
    Object? total = null,
    Object? taxKind = freezed,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleBudgetRefImplCopyWith<$Res>
    implements $SaleBudgetRefCopyWith<$Res> {
  factory _$$SaleBudgetRefImplCopyWith(
    _$SaleBudgetRefImpl value,
    $Res Function(_$SaleBudgetRefImpl) then,
  ) = __$$SaleBudgetRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String status,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    String? taxKind,
  });
}

/// @nodoc
class __$$SaleBudgetRefImplCopyWithImpl<$Res>
    extends _$SaleBudgetRefCopyWithImpl<$Res, _$SaleBudgetRefImpl>
    implements _$$SaleBudgetRefImplCopyWith<$Res> {
  __$$SaleBudgetRefImplCopyWithImpl(
    _$SaleBudgetRefImpl _value,
    $Res Function(_$SaleBudgetRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleBudgetRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? status = null,
    Object? issuedAt = null,
    Object? total = null,
    Object? taxKind = freezed,
  }) {
    return _then(
      _$SaleBudgetRefImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleBudgetRefImpl implements _SaleBudgetRef {
  const _$SaleBudgetRefImpl({
    required this.id,
    required this.series,
    required this.number,
    required this.status,
    required this.issuedAt,
    @JsonKey(fromJson: toDouble) required this.total,
    this.taxKind,
  });

  factory _$SaleBudgetRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleBudgetRefImplFromJson(json);

  @override
  final int id;
  @override
  final String series;
  @override
  final int number;
  @override
  final String status;
  @override
  final String issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  final double total;
  @override
  final String? taxKind;

  @override
  String toString() {
    return 'SaleBudgetRef(id: $id, series: $series, number: $number, status: $status, issuedAt: $issuedAt, total: $total, taxKind: $taxKind)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleBudgetRefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.taxKind, taxKind) || other.taxKind == taxKind));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    series,
    number,
    status,
    issuedAt,
    total,
    taxKind,
  );

  /// Create a copy of SaleBudgetRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleBudgetRefImplCopyWith<_$SaleBudgetRefImpl> get copyWith =>
      __$$SaleBudgetRefImplCopyWithImpl<_$SaleBudgetRefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleBudgetRefImplToJson(this);
  }
}

abstract class _SaleBudgetRef implements SaleBudgetRef {
  const factory _SaleBudgetRef({
    required final int id,
    required final String series,
    required final int number,
    required final String status,
    required final String issuedAt,
    @JsonKey(fromJson: toDouble) required final double total,
    final String? taxKind,
  }) = _$SaleBudgetRefImpl;

  factory _SaleBudgetRef.fromJson(Map<String, dynamic> json) =
      _$SaleBudgetRefImpl.fromJson;

  @override
  int get id;
  @override
  String get series;
  @override
  int get number;
  @override
  String get status;
  @override
  String get issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  double get total;
  @override
  String? get taxKind;

  /// Create a copy of SaleBudgetRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleBudgetRefImplCopyWith<_$SaleBudgetRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleDetailLine _$SaleDetailLineFromJson(Map<String, dynamic> json) {
  return _SaleDetailLine.fromJson(json);
}

/// @nodoc
mixin _$SaleDetailLine {
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
  @JsonKey(fromJson: toDouble)
  double get invoicedQuantity => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get invoicedTotal => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get pendingQuantity => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get pendingTotal => throw _privateConstructorUsedError;

  /// Serializes this SaleDetailLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleDetailLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleDetailLineCopyWith<SaleDetailLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleDetailLineCopyWith<$Res> {
  factory $SaleDetailLineCopyWith(
    SaleDetailLine value,
    $Res Function(SaleDetailLine) then,
  ) = _$SaleDetailLineCopyWithImpl<$Res, SaleDetailLine>;
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
    @JsonKey(fromJson: toDouble) double invoicedQuantity,
    @JsonKey(fromJson: toDouble) double invoicedTotal,
    @JsonKey(fromJson: toDouble) double pendingQuantity,
    @JsonKey(fromJson: toDouble) double pendingTotal,
  });
}

/// @nodoc
class _$SaleDetailLineCopyWithImpl<$Res, $Val extends SaleDetailLine>
    implements $SaleDetailLineCopyWith<$Res> {
  _$SaleDetailLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleDetailLine
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
    Object? invoicedQuantity = null,
    Object? invoicedTotal = null,
    Object? pendingQuantity = null,
    Object? pendingTotal = null,
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
            invoicedQuantity: null == invoicedQuantity
                ? _value.invoicedQuantity
                : invoicedQuantity // ignore: cast_nullable_to_non_nullable
                      as double,
            invoicedTotal: null == invoicedTotal
                ? _value.invoicedTotal
                : invoicedTotal // ignore: cast_nullable_to_non_nullable
                      as double,
            pendingQuantity: null == pendingQuantity
                ? _value.pendingQuantity
                : pendingQuantity // ignore: cast_nullable_to_non_nullable
                      as double,
            pendingTotal: null == pendingTotal
                ? _value.pendingTotal
                : pendingTotal // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleDetailLineImplCopyWith<$Res>
    implements $SaleDetailLineCopyWith<$Res> {
  factory _$$SaleDetailLineImplCopyWith(
    _$SaleDetailLineImpl value,
    $Res Function(_$SaleDetailLineImpl) then,
  ) = __$$SaleDetailLineImplCopyWithImpl<$Res>;
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
    @JsonKey(fromJson: toDouble) double invoicedQuantity,
    @JsonKey(fromJson: toDouble) double invoicedTotal,
    @JsonKey(fromJson: toDouble) double pendingQuantity,
    @JsonKey(fromJson: toDouble) double pendingTotal,
  });
}

/// @nodoc
class __$$SaleDetailLineImplCopyWithImpl<$Res>
    extends _$SaleDetailLineCopyWithImpl<$Res, _$SaleDetailLineImpl>
    implements _$$SaleDetailLineImplCopyWith<$Res> {
  __$$SaleDetailLineImplCopyWithImpl(
    _$SaleDetailLineImpl _value,
    $Res Function(_$SaleDetailLineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleDetailLine
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
    Object? invoicedQuantity = null,
    Object? invoicedTotal = null,
    Object? pendingQuantity = null,
    Object? pendingTotal = null,
  }) {
    return _then(
      _$SaleDetailLineImpl(
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
        invoicedQuantity: null == invoicedQuantity
            ? _value.invoicedQuantity
            : invoicedQuantity // ignore: cast_nullable_to_non_nullable
                  as double,
        invoicedTotal: null == invoicedTotal
            ? _value.invoicedTotal
            : invoicedTotal // ignore: cast_nullable_to_non_nullable
                  as double,
        pendingQuantity: null == pendingQuantity
            ? _value.pendingQuantity
            : pendingQuantity // ignore: cast_nullable_to_non_nullable
                  as double,
        pendingTotal: null == pendingTotal
            ? _value.pendingTotal
            : pendingTotal // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleDetailLineImpl implements _SaleDetailLine {
  const _$SaleDetailLineImpl({
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
    @JsonKey(fromJson: toDouble) this.invoicedQuantity = 0,
    @JsonKey(fromJson: toDouble) this.invoicedTotal = 0,
    @JsonKey(fromJson: toDouble) this.pendingQuantity = 0,
    @JsonKey(fromJson: toDouble) this.pendingTotal = 0,
  });

  factory _$SaleDetailLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleDetailLineImplFromJson(json);

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
  @JsonKey(fromJson: toDouble)
  final double invoicedQuantity;
  @override
  @JsonKey(fromJson: toDouble)
  final double invoicedTotal;
  @override
  @JsonKey(fromJson: toDouble)
  final double pendingQuantity;
  @override
  @JsonKey(fromJson: toDouble)
  final double pendingTotal;

  @override
  String toString() {
    return 'SaleDetailLine(id: $id, productId: $productId, serviceId: $serviceId, description: $description, quantity: $quantity, unitPrice: $unitPrice, discountRate: $discountRate, taxRate: $taxRate, taxAmount: $taxAmount, total: $total, invoicedQuantity: $invoicedQuantity, invoicedTotal: $invoicedTotal, pendingQuantity: $pendingQuantity, pendingTotal: $pendingTotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleDetailLineImpl &&
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
            (identical(other.total, total) || other.total == total) &&
            (identical(other.invoicedQuantity, invoicedQuantity) ||
                other.invoicedQuantity == invoicedQuantity) &&
            (identical(other.invoicedTotal, invoicedTotal) ||
                other.invoicedTotal == invoicedTotal) &&
            (identical(other.pendingQuantity, pendingQuantity) ||
                other.pendingQuantity == pendingQuantity) &&
            (identical(other.pendingTotal, pendingTotal) ||
                other.pendingTotal == pendingTotal));
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
    invoicedQuantity,
    invoicedTotal,
    pendingQuantity,
    pendingTotal,
  );

  /// Create a copy of SaleDetailLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleDetailLineImplCopyWith<_$SaleDetailLineImpl> get copyWith =>
      __$$SaleDetailLineImplCopyWithImpl<_$SaleDetailLineImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleDetailLineImplToJson(this);
  }
}

abstract class _SaleDetailLine implements SaleDetailLine {
  const factory _SaleDetailLine({
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
    @JsonKey(fromJson: toDouble) final double invoicedQuantity,
    @JsonKey(fromJson: toDouble) final double invoicedTotal,
    @JsonKey(fromJson: toDouble) final double pendingQuantity,
    @JsonKey(fromJson: toDouble) final double pendingTotal,
  }) = _$SaleDetailLineImpl;

  factory _SaleDetailLine.fromJson(Map<String, dynamic> json) =
      _$SaleDetailLineImpl.fromJson;

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
  @override
  @JsonKey(fromJson: toDouble)
  double get invoicedQuantity;
  @override
  @JsonKey(fromJson: toDouble)
  double get invoicedTotal;
  @override
  @JsonKey(fromJson: toDouble)
  double get pendingQuantity;
  @override
  @JsonKey(fromJson: toDouble)
  double get pendingTotal;

  /// Create a copy of SaleDetailLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleDetailLineImplCopyWith<_$SaleDetailLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleInstallment _$SaleInstallmentFromJson(Map<String, dynamic> json) {
  return _SaleInstallment.fromJson(json);
}

/// @nodoc
mixin _$SaleInstallment {
  int get id => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  String? get dueDate => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDoubleN)
  double? get percentage => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDoubleN)
  double? get plannedAmount => throw _privateConstructorUsedError;

  /// Serializes this SaleInstallment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleInstallment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleInstallmentCopyWith<SaleInstallment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleInstallmentCopyWith<$Res> {
  factory $SaleInstallmentCopyWith(
    SaleInstallment value,
    $Res Function(SaleInstallment) then,
  ) = _$SaleInstallmentCopyWithImpl<$Res, SaleInstallment>;
  @useResult
  $Res call({
    int id,
    int index,
    String? dueDate,
    @JsonKey(fromJson: toDoubleN) double? percentage,
    @JsonKey(fromJson: toDoubleN) double? plannedAmount,
  });
}

/// @nodoc
class _$SaleInstallmentCopyWithImpl<$Res, $Val extends SaleInstallment>
    implements $SaleInstallmentCopyWith<$Res> {
  _$SaleInstallmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleInstallment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = null,
    Object? dueDate = freezed,
    Object? percentage = freezed,
    Object? plannedAmount = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            index: null == index
                ? _value.index
                : index // ignore: cast_nullable_to_non_nullable
                      as int,
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            percentage: freezed == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double?,
            plannedAmount: freezed == plannedAmount
                ? _value.plannedAmount
                : plannedAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleInstallmentImplCopyWith<$Res>
    implements $SaleInstallmentCopyWith<$Res> {
  factory _$$SaleInstallmentImplCopyWith(
    _$SaleInstallmentImpl value,
    $Res Function(_$SaleInstallmentImpl) then,
  ) = __$$SaleInstallmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int index,
    String? dueDate,
    @JsonKey(fromJson: toDoubleN) double? percentage,
    @JsonKey(fromJson: toDoubleN) double? plannedAmount,
  });
}

/// @nodoc
class __$$SaleInstallmentImplCopyWithImpl<$Res>
    extends _$SaleInstallmentCopyWithImpl<$Res, _$SaleInstallmentImpl>
    implements _$$SaleInstallmentImplCopyWith<$Res> {
  __$$SaleInstallmentImplCopyWithImpl(
    _$SaleInstallmentImpl _value,
    $Res Function(_$SaleInstallmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleInstallment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = null,
    Object? dueDate = freezed,
    Object? percentage = freezed,
    Object? plannedAmount = freezed,
  }) {
    return _then(
      _$SaleInstallmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        index: null == index
            ? _value.index
            : index // ignore: cast_nullable_to_non_nullable
                  as int,
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        percentage: freezed == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double?,
        plannedAmount: freezed == plannedAmount
            ? _value.plannedAmount
            : plannedAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleInstallmentImpl implements _SaleInstallment {
  const _$SaleInstallmentImpl({
    required this.id,
    required this.index,
    this.dueDate,
    @JsonKey(fromJson: toDoubleN) this.percentage,
    @JsonKey(fromJson: toDoubleN) this.plannedAmount,
  });

  factory _$SaleInstallmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleInstallmentImplFromJson(json);

  @override
  final int id;
  @override
  final int index;
  @override
  final String? dueDate;
  @override
  @JsonKey(fromJson: toDoubleN)
  final double? percentage;
  @override
  @JsonKey(fromJson: toDoubleN)
  final double? plannedAmount;

  @override
  String toString() {
    return 'SaleInstallment(id: $id, index: $index, dueDate: $dueDate, percentage: $percentage, plannedAmount: $plannedAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleInstallmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.plannedAmount, plannedAmount) ||
                other.plannedAmount == plannedAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, index, dueDate, percentage, plannedAmount);

  /// Create a copy of SaleInstallment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleInstallmentImplCopyWith<_$SaleInstallmentImpl> get copyWith =>
      __$$SaleInstallmentImplCopyWithImpl<_$SaleInstallmentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleInstallmentImplToJson(this);
  }
}

abstract class _SaleInstallment implements SaleInstallment {
  const factory _SaleInstallment({
    required final int id,
    required final int index,
    final String? dueDate,
    @JsonKey(fromJson: toDoubleN) final double? percentage,
    @JsonKey(fromJson: toDoubleN) final double? plannedAmount,
  }) = _$SaleInstallmentImpl;

  factory _SaleInstallment.fromJson(Map<String, dynamic> json) =
      _$SaleInstallmentImpl.fromJson;

  @override
  int get id;
  @override
  int get index;
  @override
  String? get dueDate;
  @override
  @JsonKey(fromJson: toDoubleN)
  double? get percentage;
  @override
  @JsonKey(fromJson: toDoubleN)
  double? get plannedAmount;

  /// Create a copy of SaleInstallment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleInstallmentImplCopyWith<_$SaleInstallmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleInvoiceRef _$SaleInvoiceRefFromJson(Map<String, dynamic> json) {
  return _SaleInvoiceRef.fromJson(json);
}

/// @nodoc
mixin _$SaleInvoiceRef {
  int get id => throw _privateConstructorUsedError;
  String get series => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get total => throw _privateConstructorUsedError;
  bool get isFinal => throw _privateConstructorUsedError;

  /// Serializes this SaleInvoiceRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleInvoiceRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleInvoiceRefCopyWith<SaleInvoiceRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleInvoiceRefCopyWith<$Res> {
  factory $SaleInvoiceRefCopyWith(
    SaleInvoiceRef value,
    $Res Function(SaleInvoiceRef) then,
  ) = _$SaleInvoiceRefCopyWithImpl<$Res, SaleInvoiceRef>;
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String status,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    bool isFinal,
  });
}

/// @nodoc
class _$SaleInvoiceRefCopyWithImpl<$Res, $Val extends SaleInvoiceRef>
    implements $SaleInvoiceRefCopyWith<$Res> {
  _$SaleInvoiceRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleInvoiceRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? status = null,
    Object? issuedAt = null,
    Object? total = null,
    Object? isFinal = null,
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
            issuedAt: null == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            isFinal: null == isFinal
                ? _value.isFinal
                : isFinal // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleInvoiceRefImplCopyWith<$Res>
    implements $SaleInvoiceRefCopyWith<$Res> {
  factory _$$SaleInvoiceRefImplCopyWith(
    _$SaleInvoiceRefImpl value,
    $Res Function(_$SaleInvoiceRefImpl) then,
  ) = __$$SaleInvoiceRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String status,
    String issuedAt,
    @JsonKey(fromJson: toDouble) double total,
    bool isFinal,
  });
}

/// @nodoc
class __$$SaleInvoiceRefImplCopyWithImpl<$Res>
    extends _$SaleInvoiceRefCopyWithImpl<$Res, _$SaleInvoiceRefImpl>
    implements _$$SaleInvoiceRefImplCopyWith<$Res> {
  __$$SaleInvoiceRefImplCopyWithImpl(
    _$SaleInvoiceRefImpl _value,
    $Res Function(_$SaleInvoiceRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleInvoiceRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? status = null,
    Object? issuedAt = null,
    Object? total = null,
    Object? isFinal = null,
  }) {
    return _then(
      _$SaleInvoiceRefImpl(
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
        issuedAt: null == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        isFinal: null == isFinal
            ? _value.isFinal
            : isFinal // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleInvoiceRefImpl implements _SaleInvoiceRef {
  const _$SaleInvoiceRefImpl({
    required this.id,
    required this.series,
    required this.number,
    required this.status,
    required this.issuedAt,
    @JsonKey(fromJson: toDouble) required this.total,
    this.isFinal = false,
  });

  factory _$SaleInvoiceRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleInvoiceRefImplFromJson(json);

  @override
  final int id;
  @override
  final String series;
  @override
  final int number;
  @override
  final String status;
  @override
  final String issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  final double total;
  @override
  @JsonKey()
  final bool isFinal;

  @override
  String toString() {
    return 'SaleInvoiceRef(id: $id, series: $series, number: $number, status: $status, issuedAt: $issuedAt, total: $total, isFinal: $isFinal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleInvoiceRefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.isFinal, isFinal) || other.isFinal == isFinal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    series,
    number,
    status,
    issuedAt,
    total,
    isFinal,
  );

  /// Create a copy of SaleInvoiceRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleInvoiceRefImplCopyWith<_$SaleInvoiceRefImpl> get copyWith =>
      __$$SaleInvoiceRefImplCopyWithImpl<_$SaleInvoiceRefImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleInvoiceRefImplToJson(this);
  }
}

abstract class _SaleInvoiceRef implements SaleInvoiceRef {
  const factory _SaleInvoiceRef({
    required final int id,
    required final String series,
    required final int number,
    required final String status,
    required final String issuedAt,
    @JsonKey(fromJson: toDouble) required final double total,
    final bool isFinal,
  }) = _$SaleInvoiceRefImpl;

  factory _SaleInvoiceRef.fromJson(Map<String, dynamic> json) =
      _$SaleInvoiceRefImpl.fromJson;

  @override
  int get id;
  @override
  String get series;
  @override
  int get number;
  @override
  String get status;
  @override
  String get issuedAt;
  @override
  @JsonKey(fromJson: toDouble)
  double get total;
  @override
  bool get isFinal;

  /// Create a copy of SaleInvoiceRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleInvoiceRefImplCopyWith<_$SaleInvoiceRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
