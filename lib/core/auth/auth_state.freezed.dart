// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() needsSetup,
    required TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )
    authenticated,
    required TResult Function(String clientId, String? error) unauthenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? needsSetup,
    TResult? Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult? Function(String clientId, String? error)? unauthenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? needsSetup,
    TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult Function(String clientId, String? error)? unauthenticated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthNeedsSetup value) needsSetup,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthNeedsSetup value)? needsSetup,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthNeedsSetup value)? needsSetup,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthInitialImplCopyWith<$Res> {
  factory _$$AuthInitialImplCopyWith(
    _$AuthInitialImpl value,
    $Res Function(_$AuthInitialImpl) then,
  ) = __$$AuthInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthInitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthInitialImpl>
    implements _$$AuthInitialImplCopyWith<$Res> {
  __$$AuthInitialImplCopyWithImpl(
    _$AuthInitialImpl _value,
    $Res Function(_$AuthInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthInitialImpl implements AuthInitial {
  const _$AuthInitialImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() needsSetup,
    required TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )
    authenticated,
    required TResult Function(String clientId, String? error) unauthenticated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? needsSetup,
    TResult? Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult? Function(String clientId, String? error)? unauthenticated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? needsSetup,
    TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult Function(String clientId, String? error)? unauthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthNeedsSetup value) needsSetup,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthNeedsSetup value)? needsSetup,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthNeedsSetup value)? needsSetup,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthInitial implements AuthState {
  const factory AuthInitial() = _$AuthInitialImpl;
}

/// @nodoc
abstract class _$$AuthLoadingImplCopyWith<$Res> {
  factory _$$AuthLoadingImplCopyWith(
    _$AuthLoadingImpl value,
    $Res Function(_$AuthLoadingImpl) then,
  ) = __$$AuthLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthLoadingImpl>
    implements _$$AuthLoadingImplCopyWith<$Res> {
  __$$AuthLoadingImplCopyWithImpl(
    _$AuthLoadingImpl _value,
    $Res Function(_$AuthLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthLoadingImpl implements AuthLoading {
  const _$AuthLoadingImpl();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() needsSetup,
    required TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )
    authenticated,
    required TResult Function(String clientId, String? error) unauthenticated,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? needsSetup,
    TResult? Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult? Function(String clientId, String? error)? unauthenticated,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? needsSetup,
    TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult Function(String clientId, String? error)? unauthenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthNeedsSetup value) needsSetup,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthNeedsSetup value)? needsSetup,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthNeedsSetup value)? needsSetup,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthLoading implements AuthState {
  const factory AuthLoading() = _$AuthLoadingImpl;
}

/// @nodoc
abstract class _$$AuthNeedsSetupImplCopyWith<$Res> {
  factory _$$AuthNeedsSetupImplCopyWith(
    _$AuthNeedsSetupImpl value,
    $Res Function(_$AuthNeedsSetupImpl) then,
  ) = __$$AuthNeedsSetupImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthNeedsSetupImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthNeedsSetupImpl>
    implements _$$AuthNeedsSetupImplCopyWith<$Res> {
  __$$AuthNeedsSetupImplCopyWithImpl(
    _$AuthNeedsSetupImpl _value,
    $Res Function(_$AuthNeedsSetupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthNeedsSetupImpl implements AuthNeedsSetup {
  const _$AuthNeedsSetupImpl();

  @override
  String toString() {
    return 'AuthState.needsSetup()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthNeedsSetupImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() needsSetup,
    required TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )
    authenticated,
    required TResult Function(String clientId, String? error) unauthenticated,
  }) {
    return needsSetup();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? needsSetup,
    TResult? Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult? Function(String clientId, String? error)? unauthenticated,
  }) {
    return needsSetup?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? needsSetup,
    TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult Function(String clientId, String? error)? unauthenticated,
    required TResult orElse(),
  }) {
    if (needsSetup != null) {
      return needsSetup();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthNeedsSetup value) needsSetup,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return needsSetup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthNeedsSetup value)? needsSetup,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return needsSetup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthNeedsSetup value)? needsSetup,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (needsSetup != null) {
      return needsSetup(this);
    }
    return orElse();
  }
}

abstract class AuthNeedsSetup implements AuthState {
  const factory AuthNeedsSetup() = _$AuthNeedsSetupImpl;
}

/// @nodoc
abstract class _$$AuthAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthAuthenticatedImplCopyWith(
    _$AuthAuthenticatedImpl value,
    $Res Function(_$AuthAuthenticatedImpl) then,
  ) = __$$AuthAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    UserInfo user,
    List<CompanyInfo> companies,
    int activeCompanyId,
    String clientId,
  });

  $UserInfoCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthAuthenticatedImpl>
    implements _$$AuthAuthenticatedImplCopyWith<$Res> {
  __$$AuthAuthenticatedImplCopyWithImpl(
    _$AuthAuthenticatedImpl _value,
    $Res Function(_$AuthAuthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? companies = null,
    Object? activeCompanyId = null,
    Object? clientId = null,
  }) {
    return _then(
      _$AuthAuthenticatedImpl(
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserInfo,
        companies: null == companies
            ? _value._companies
            : companies // ignore: cast_nullable_to_non_nullable
                  as List<CompanyInfo>,
        activeCompanyId: null == activeCompanyId
            ? _value.activeCompanyId
            : activeCompanyId // ignore: cast_nullable_to_non_nullable
                  as int,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoCopyWith<$Res> get user {
    return $UserInfoCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$AuthAuthenticatedImpl implements AuthAuthenticated {
  const _$AuthAuthenticatedImpl({
    required this.user,
    required final List<CompanyInfo> companies,
    required this.activeCompanyId,
    required this.clientId,
  }) : _companies = companies;

  @override
  final UserInfo user;
  final List<CompanyInfo> _companies;
  @override
  List<CompanyInfo> get companies {
    if (_companies is EqualUnmodifiableListView) return _companies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_companies);
  }

  @override
  final int activeCompanyId;
  @override
  final String clientId;

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user, companies: $companies, activeCompanyId: $activeCompanyId, clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthAuthenticatedImpl &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(
              other._companies,
              _companies,
            ) &&
            (identical(other.activeCompanyId, activeCompanyId) ||
                other.activeCompanyId == activeCompanyId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    user,
    const DeepCollectionEquality().hash(_companies),
    activeCompanyId,
    clientId,
  );

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      __$$AuthAuthenticatedImplCopyWithImpl<_$AuthAuthenticatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() needsSetup,
    required TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )
    authenticated,
    required TResult Function(String clientId, String? error) unauthenticated,
  }) {
    return authenticated(user, companies, activeCompanyId, clientId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? needsSetup,
    TResult? Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult? Function(String clientId, String? error)? unauthenticated,
  }) {
    return authenticated?.call(user, companies, activeCompanyId, clientId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? needsSetup,
    TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult Function(String clientId, String? error)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user, companies, activeCompanyId, clientId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthNeedsSetup value) needsSetup,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthNeedsSetup value)? needsSetup,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthNeedsSetup value)? needsSetup,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthAuthenticated implements AuthState {
  const factory AuthAuthenticated({
    required final UserInfo user,
    required final List<CompanyInfo> companies,
    required final int activeCompanyId,
    required final String clientId,
  }) = _$AuthAuthenticatedImpl;

  UserInfo get user;
  List<CompanyInfo> get companies;
  int get activeCompanyId;
  String get clientId;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthUnauthenticatedImplCopyWith<$Res> {
  factory _$$AuthUnauthenticatedImplCopyWith(
    _$AuthUnauthenticatedImpl value,
    $Res Function(_$AuthUnauthenticatedImpl) then,
  ) = __$$AuthUnauthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clientId, String? error});
}

/// @nodoc
class __$$AuthUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthUnauthenticatedImpl>
    implements _$$AuthUnauthenticatedImplCopyWith<$Res> {
  __$$AuthUnauthenticatedImplCopyWithImpl(
    _$AuthUnauthenticatedImpl _value,
    $Res Function(_$AuthUnauthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clientId = null, Object? error = freezed}) {
    return _then(
      _$AuthUnauthenticatedImpl(
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthUnauthenticatedImpl implements AuthUnauthenticated {
  const _$AuthUnauthenticatedImpl({required this.clientId, this.error});

  @override
  final String clientId;
  @override
  final String? error;

  @override
  String toString() {
    return 'AuthState.unauthenticated(clientId: $clientId, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUnauthenticatedImpl &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientId, error);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUnauthenticatedImplCopyWith<_$AuthUnauthenticatedImpl> get copyWith =>
      __$$AuthUnauthenticatedImplCopyWithImpl<_$AuthUnauthenticatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() needsSetup,
    required TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )
    authenticated,
    required TResult Function(String clientId, String? error) unauthenticated,
  }) {
    return unauthenticated(clientId, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? needsSetup,
    TResult? Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult? Function(String clientId, String? error)? unauthenticated,
  }) {
    return unauthenticated?.call(clientId, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? needsSetup,
    TResult Function(
      UserInfo user,
      List<CompanyInfo> companies,
      int activeCompanyId,
      String clientId,
    )?
    authenticated,
    TResult Function(String clientId, String? error)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(clientId, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthNeedsSetup value) needsSetup,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthNeedsSetup value)? needsSetup,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthNeedsSetup value)? needsSetup,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthUnauthenticated implements AuthState {
  const factory AuthUnauthenticated({
    required final String clientId,
    final String? error,
  }) = _$AuthUnauthenticatedImpl;

  String get clientId;
  String? get error;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUnauthenticatedImplCopyWith<_$AuthUnauthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
