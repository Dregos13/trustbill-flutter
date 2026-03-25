// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DashboardSummary _$DashboardSummaryFromJson(Map<String, dynamic> json) {
  return _DashboardSummary.fromJson(json);
}

/// @nodoc
mixin _$DashboardSummary {
  int get invoicesThisMonth => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get totalBilled => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get totalCollected => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get totalPending => throw _privateConstructorUsedError;
  List<DashboardInvoice> get recentInvoices =>
      throw _privateConstructorUsedError;

  /// Serializes this DashboardSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardSummaryCopyWith<DashboardSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSummaryCopyWith<$Res> {
  factory $DashboardSummaryCopyWith(
    DashboardSummary value,
    $Res Function(DashboardSummary) then,
  ) = _$DashboardSummaryCopyWithImpl<$Res, DashboardSummary>;
  @useResult
  $Res call({
    int invoicesThisMonth,
    @JsonKey(fromJson: toDouble) double totalBilled,
    @JsonKey(fromJson: toDouble) double totalCollected,
    @JsonKey(fromJson: toDouble) double totalPending,
    List<DashboardInvoice> recentInvoices,
  });
}

/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res, $Val extends DashboardSummary>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoicesThisMonth = null,
    Object? totalBilled = null,
    Object? totalCollected = null,
    Object? totalPending = null,
    Object? recentInvoices = null,
  }) {
    return _then(
      _value.copyWith(
            invoicesThisMonth: null == invoicesThisMonth
                ? _value.invoicesThisMonth
                : invoicesThisMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            totalBilled: null == totalBilled
                ? _value.totalBilled
                : totalBilled // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCollected: null == totalCollected
                ? _value.totalCollected
                : totalCollected // ignore: cast_nullable_to_non_nullable
                      as double,
            totalPending: null == totalPending
                ? _value.totalPending
                : totalPending // ignore: cast_nullable_to_non_nullable
                      as double,
            recentInvoices: null == recentInvoices
                ? _value.recentInvoices
                : recentInvoices // ignore: cast_nullable_to_non_nullable
                      as List<DashboardInvoice>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardSummaryImplCopyWith<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  factory _$$DashboardSummaryImplCopyWith(
    _$DashboardSummaryImpl value,
    $Res Function(_$DashboardSummaryImpl) then,
  ) = __$$DashboardSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int invoicesThisMonth,
    @JsonKey(fromJson: toDouble) double totalBilled,
    @JsonKey(fromJson: toDouble) double totalCollected,
    @JsonKey(fromJson: toDouble) double totalPending,
    List<DashboardInvoice> recentInvoices,
  });
}

/// @nodoc
class __$$DashboardSummaryImplCopyWithImpl<$Res>
    extends _$DashboardSummaryCopyWithImpl<$Res, _$DashboardSummaryImpl>
    implements _$$DashboardSummaryImplCopyWith<$Res> {
  __$$DashboardSummaryImplCopyWithImpl(
    _$DashboardSummaryImpl _value,
    $Res Function(_$DashboardSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoicesThisMonth = null,
    Object? totalBilled = null,
    Object? totalCollected = null,
    Object? totalPending = null,
    Object? recentInvoices = null,
  }) {
    return _then(
      _$DashboardSummaryImpl(
        invoicesThisMonth: null == invoicesThisMonth
            ? _value.invoicesThisMonth
            : invoicesThisMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        totalBilled: null == totalBilled
            ? _value.totalBilled
            : totalBilled // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCollected: null == totalCollected
            ? _value.totalCollected
            : totalCollected // ignore: cast_nullable_to_non_nullable
                  as double,
        totalPending: null == totalPending
            ? _value.totalPending
            : totalPending // ignore: cast_nullable_to_non_nullable
                  as double,
        recentInvoices: null == recentInvoices
            ? _value._recentInvoices
            : recentInvoices // ignore: cast_nullable_to_non_nullable
                  as List<DashboardInvoice>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardSummaryImpl implements _DashboardSummary {
  const _$DashboardSummaryImpl({
    required this.invoicesThisMonth,
    @JsonKey(fromJson: toDouble) required this.totalBilled,
    @JsonKey(fromJson: toDouble) required this.totalCollected,
    @JsonKey(fromJson: toDouble) required this.totalPending,
    required final List<DashboardInvoice> recentInvoices,
  }) : _recentInvoices = recentInvoices;

  factory _$DashboardSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardSummaryImplFromJson(json);

  @override
  final int invoicesThisMonth;
  @override
  @JsonKey(fromJson: toDouble)
  final double totalBilled;
  @override
  @JsonKey(fromJson: toDouble)
  final double totalCollected;
  @override
  @JsonKey(fromJson: toDouble)
  final double totalPending;
  final List<DashboardInvoice> _recentInvoices;
  @override
  List<DashboardInvoice> get recentInvoices {
    if (_recentInvoices is EqualUnmodifiableListView) return _recentInvoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentInvoices);
  }

  @override
  String toString() {
    return 'DashboardSummary(invoicesThisMonth: $invoicesThisMonth, totalBilled: $totalBilled, totalCollected: $totalCollected, totalPending: $totalPending, recentInvoices: $recentInvoices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSummaryImpl &&
            (identical(other.invoicesThisMonth, invoicesThisMonth) ||
                other.invoicesThisMonth == invoicesThisMonth) &&
            (identical(other.totalBilled, totalBilled) ||
                other.totalBilled == totalBilled) &&
            (identical(other.totalCollected, totalCollected) ||
                other.totalCollected == totalCollected) &&
            (identical(other.totalPending, totalPending) ||
                other.totalPending == totalPending) &&
            const DeepCollectionEquality().equals(
              other._recentInvoices,
              _recentInvoices,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    invoicesThisMonth,
    totalBilled,
    totalCollected,
    totalPending,
    const DeepCollectionEquality().hash(_recentInvoices),
  );

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSummaryImplCopyWith<_$DashboardSummaryImpl> get copyWith =>
      __$$DashboardSummaryImplCopyWithImpl<_$DashboardSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardSummaryImplToJson(this);
  }
}

abstract class _DashboardSummary implements DashboardSummary {
  const factory _DashboardSummary({
    required final int invoicesThisMonth,
    @JsonKey(fromJson: toDouble) required final double totalBilled,
    @JsonKey(fromJson: toDouble) required final double totalCollected,
    @JsonKey(fromJson: toDouble) required final double totalPending,
    required final List<DashboardInvoice> recentInvoices,
  }) = _$DashboardSummaryImpl;

  factory _DashboardSummary.fromJson(Map<String, dynamic> json) =
      _$DashboardSummaryImpl.fromJson;

  @override
  int get invoicesThisMonth;
  @override
  @JsonKey(fromJson: toDouble)
  double get totalBilled;
  @override
  @JsonKey(fromJson: toDouble)
  double get totalCollected;
  @override
  @JsonKey(fromJson: toDouble)
  double get totalPending;
  @override
  List<DashboardInvoice> get recentInvoices;

  /// Create a copy of DashboardSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardSummaryImplCopyWith<_$DashboardSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardInvoice _$DashboardInvoiceFromJson(Map<String, dynamic> json) {
  return _DashboardInvoice.fromJson(json);
}

/// @nodoc
mixin _$DashboardInvoice {
  int get id => throw _privateConstructorUsedError;
  String get series => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(fromJson: toDouble)
  double get total => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  String? get issuedAt => throw _privateConstructorUsedError;

  /// Serializes this DashboardInvoice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DashboardInvoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardInvoiceCopyWith<DashboardInvoice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardInvoiceCopyWith<$Res> {
  factory $DashboardInvoiceCopyWith(
    DashboardInvoice value,
    $Res Function(DashboardInvoice) then,
  ) = _$DashboardInvoiceCopyWithImpl<$Res, DashboardInvoice>;
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String status,
    @JsonKey(fromJson: toDouble) double total,
    String? clientName,
    String? issuedAt,
  });
}

/// @nodoc
class _$DashboardInvoiceCopyWithImpl<$Res, $Val extends DashboardInvoice>
    implements $DashboardInvoiceCopyWith<$Res> {
  _$DashboardInvoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardInvoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? status = null,
    Object? total = null,
    Object? clientName = freezed,
    Object? issuedAt = freezed,
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
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            clientName: freezed == clientName
                ? _value.clientName
                : clientName // ignore: cast_nullable_to_non_nullable
                      as String?,
            issuedAt: freezed == issuedAt
                ? _value.issuedAt
                : issuedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DashboardInvoiceImplCopyWith<$Res>
    implements $DashboardInvoiceCopyWith<$Res> {
  factory _$$DashboardInvoiceImplCopyWith(
    _$DashboardInvoiceImpl value,
    $Res Function(_$DashboardInvoiceImpl) then,
  ) = __$$DashboardInvoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String series,
    int number,
    String status,
    @JsonKey(fromJson: toDouble) double total,
    String? clientName,
    String? issuedAt,
  });
}

/// @nodoc
class __$$DashboardInvoiceImplCopyWithImpl<$Res>
    extends _$DashboardInvoiceCopyWithImpl<$Res, _$DashboardInvoiceImpl>
    implements _$$DashboardInvoiceImplCopyWith<$Res> {
  __$$DashboardInvoiceImplCopyWithImpl(
    _$DashboardInvoiceImpl _value,
    $Res Function(_$DashboardInvoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardInvoice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? series = null,
    Object? number = null,
    Object? status = null,
    Object? total = null,
    Object? clientName = freezed,
    Object? issuedAt = freezed,
  }) {
    return _then(
      _$DashboardInvoiceImpl(
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
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        clientName: freezed == clientName
            ? _value.clientName
            : clientName // ignore: cast_nullable_to_non_nullable
                  as String?,
        issuedAt: freezed == issuedAt
            ? _value.issuedAt
            : issuedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardInvoiceImpl implements _DashboardInvoice {
  const _$DashboardInvoiceImpl({
    required this.id,
    required this.series,
    required this.number,
    required this.status,
    @JsonKey(fromJson: toDouble) required this.total,
    this.clientName,
    this.issuedAt,
  });

  factory _$DashboardInvoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardInvoiceImplFromJson(json);

  @override
  final int id;
  @override
  final String series;
  @override
  final int number;
  @override
  final String status;
  @override
  @JsonKey(fromJson: toDouble)
  final double total;
  @override
  final String? clientName;
  @override
  final String? issuedAt;

  @override
  String toString() {
    return 'DashboardInvoice(id: $id, series: $series, number: $number, status: $status, total: $total, clientName: $clientName, issuedAt: $issuedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardInvoiceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.clientName, clientName) ||
                other.clientName == clientName) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    series,
    number,
    status,
    total,
    clientName,
    issuedAt,
  );

  /// Create a copy of DashboardInvoice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardInvoiceImplCopyWith<_$DashboardInvoiceImpl> get copyWith =>
      __$$DashboardInvoiceImplCopyWithImpl<_$DashboardInvoiceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardInvoiceImplToJson(this);
  }
}

abstract class _DashboardInvoice implements DashboardInvoice {
  const factory _DashboardInvoice({
    required final int id,
    required final String series,
    required final int number,
    required final String status,
    @JsonKey(fromJson: toDouble) required final double total,
    final String? clientName,
    final String? issuedAt,
  }) = _$DashboardInvoiceImpl;

  factory _DashboardInvoice.fromJson(Map<String, dynamic> json) =
      _$DashboardInvoiceImpl.fromJson;

  @override
  int get id;
  @override
  String get series;
  @override
  int get number;
  @override
  String get status;
  @override
  @JsonKey(fromJson: toDouble)
  double get total;
  @override
  String? get clientName;
  @override
  String? get issuedAt;

  /// Create a copy of DashboardInvoice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardInvoiceImplCopyWith<_$DashboardInvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
