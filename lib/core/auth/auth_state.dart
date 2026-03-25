import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.needsSetup() = AuthNeedsSetup;
  const factory AuthState.authenticated({
    required UserInfo user,
    required List<CompanyInfo> companies,
    required int activeCompanyId,
    required String clientId,
  }) = AuthAuthenticated;
  const factory AuthState.unauthenticated({
    required String clientId,
    String? error,
  }) = AuthUnauthenticated;
}
