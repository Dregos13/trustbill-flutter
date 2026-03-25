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

  Future<void> tryAutoLogin() async {
    state = const AuthState.loading();
    final refreshToken = await _apiClient.getRefreshToken();
    if (refreshToken == null) {
      state = const AuthState.unauthenticated();
      return;
    }

    try {
      final res = await _endpoints.refresh(refreshToken);
      _apiClient.setAccessToken(res.accessToken);
      await _apiClient.saveRefreshToken(res.refreshToken);

      // Fetch user info after refresh
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
      );
    } catch (_) {
      await _apiClient.clearTokens();
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final res = await _endpoints.login(email, password);
      _apiClient.setAccessToken(res.accessToken);
      await _apiClient.saveRefreshToken(res.refreshToken);
      state = AuthState.authenticated(
        user: res.user,
        companies: res.companies,
        activeCompanyId: res.activeCompanyId,
      );
    } on ApiError catch (e) {
      state = AuthState.unauthenticated(error: e.message);
    } catch (e) {
      state = const AuthState.unauthenticated(
          error: 'Error de conexion. Comprueba tu red.');
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
        );
      }
    } on ApiError catch (e) {
      // If forbidden, just ignore
      if (e.isUnauthorized) {
        forceLogout();
      }
    }
  }

  Future<void> logout() async {
    try {
      final refreshToken = await _apiClient.getRefreshToken();
      if (refreshToken != null) {
        await _endpoints.logout(refreshToken);
      }
    } catch (_) {
      // Logout best-effort
    }
    await _apiClient.clearTokens();
    state = const AuthState.unauthenticated();
  }

  void forceLogout() {
    _apiClient.clearTokens();
    state = const AuthState.unauthenticated();
  }
}
