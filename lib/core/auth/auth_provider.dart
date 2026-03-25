import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_client.dart';
import '../api/api_error.dart';
import '../api/endpoints.dart';
import '../models/user.dart';
import 'auth_state.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final endpointsProvider = Provider<Endpoints>((ref) {
  return Endpoints(ref.watch(apiClientProvider));
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final endpoints = ref.watch(endpointsProvider);
  final notifier = AuthNotifier(apiClient, endpoints);
  apiClient.onAuthError = () {
    notifier.forceLogout();
  };
  return notifier;
});

class AuthNotifier extends StateNotifier<AuthState> {
  final ApiClient _apiClient;
  final Endpoints _endpoints;

  AuthNotifier(this._apiClient, this._endpoints)
      : super(const AuthState.initial());

  /// Check if there's a saved clientId, configure API, and try auto-login
  Future<void> initialize() async {
    state = const AuthState.loading();

    final clientId = await _apiClient.getClientId();
    if (clientId == null || clientId.isEmpty) {
      state = const AuthState.needsSetup();
      return;
    }

    _apiClient.configure(clientId);

    final refreshToken = await _apiClient.getRefreshToken();
    if (refreshToken == null) {
      state = AuthState.unauthenticated(clientId: clientId);
      return;
    }

    try {
      final res = await _endpoints.refresh(refreshToken);
      _apiClient.setAccessToken(res.accessToken);
      await _apiClient.saveRefreshToken(res.refreshToken);

      final meRes = await _apiClient.get('/auth/me');
      final data = meRes.data as Map<String, dynamic>;
      final user = UserInfo.fromJson(data['user']);
      final companies = (data['companies'] as List)
          .map((c) => CompanyInfo.fromJson(c))
          .toList();
      final activeCompanyId = data['activeCompanyId'] as int;

      state = AuthState.authenticated(
        user: user,
        companies: companies,
        activeCompanyId: activeCompanyId,
        clientId: clientId,
      );
    } catch (_) {
      await _apiClient.clearTokens();
      state = AuthState.unauthenticated(clientId: clientId);
    }
  }

  /// Save clientId and configure API, then go to login
  Future<void> setClientId(String clientId) async {
    _apiClient.configure(clientId);
    await _apiClient.saveClientId(clientId);
    state = AuthState.unauthenticated(clientId: clientId);
  }

  Future<void> login(String email, String password) async {
    final clientId = _currentClientId;
    state = const AuthState.loading();
    try {
      final res = await _endpoints.login(email, password);
      _apiClient.setAccessToken(res.accessToken);
      await _apiClient.saveRefreshToken(res.refreshToken);
      state = AuthState.authenticated(
        user: res.user,
        companies: res.companies,
        activeCompanyId: res.activeCompanyId,
        clientId: clientId,
      );
    } on ApiError catch (e) {
      state = AuthState.unauthenticated(clientId: clientId, error: e.message);
    } catch (e) {
      state = AuthState.unauthenticated(
        clientId: clientId,
        error: 'Error de conexion. Comprueba tu red.',
      );
    }
  }

  Future<void> switchCompany(int companyId) async {
    try {
      final res = await _endpoints.switchCompany(companyId);
      _apiClient.setAccessToken(res.accessToken);
      await _apiClient.saveRefreshToken(res.refreshToken);

      final currentState = state;
      if (currentState is AuthAuthenticated) {
        state = AuthState.authenticated(
          user: currentState.user,
          companies: currentState.companies,
          activeCompanyId: res.activeCompanyId,
          clientId: currentState.clientId,
        );
      }
    } on ApiError catch (e) {
      if (e.isUnauthorized) {
        forceLogout();
      }
    }
  }

  Future<void> logout() async {
    final clientId = _currentClientId;
    try {
      final refreshToken = await _apiClient.getRefreshToken();
      if (refreshToken != null) {
        await _endpoints.logout(refreshToken);
      }
    } catch (_) {
      // best-effort
    }
    await _apiClient.clearTokens();
    state = AuthState.unauthenticated(clientId: clientId);
  }

  void forceLogout() {
    final clientId = _currentClientId;
    _apiClient.clearTokens();
    state = AuthState.unauthenticated(clientId: clientId);
  }

  /// Reset to setup screen (change server)
  Future<void> resetSetup() async {
    await _apiClient.clearAll();
    state = const AuthState.needsSetup();
  }

  String get _currentClientId {
    final s = state;
    if (s is AuthAuthenticated) return s.clientId;
    if (s is AuthUnauthenticated) return s.clientId;
    return '';
  }
}
