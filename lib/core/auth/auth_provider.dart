import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_client.dart';
import '../api/api_error.dart';
import '../api/endpoints.dart';
import '../models/user.dart';
import 'auth_state.dart';

const _keySavedEmail = 'saved_email';
const _keySavedPassword = 'saved_password';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final endpointsProvider = Provider<Endpoints>((ref) {
  return Endpoints(ref.read(apiClientProvider));
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final endpoints = ref.read(endpointsProvider);
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

  Future<void> initialize() async {
    state = const AuthState.loading();

    final clientId = await _apiClient.getClientId();
    if (clientId == null || clientId.isEmpty) {
      state = const AuthState.needsSetup();
      return;
    }

    _apiClient.configure(clientId);
    await _apiClient.loadTenant();

    final refreshToken = await _apiClient.getRefreshToken();
    if (refreshToken != null) {
      final authenticated = await _tryRefresh(clientId, refreshToken);
      if (authenticated) return;
    }

    // Refresh token missing or expired — try silent re-login with saved credentials
    final saved = await getSavedCredentials();
    if (saved != null) {
      try {
        await login(saved['email']!, saved['password']!);
        return;
      } catch (_) {
        // saved credentials no longer valid — fall through to login screen
      }
    }

    state = AuthState.unauthenticated(clientId: clientId);
  }

  Future<bool> _tryRefresh(String clientId, String refreshToken) async {
    try {
      final res = await _endpoints.refresh(refreshToken);
      _apiClient.setAccessToken(res.accessToken);
      await _apiClient.saveRefreshToken(res.refreshToken);

      UserInfo user;
      List<CompanyInfo> companies;
      int activeCompanyId;

      if (res.user != null && res.activeCompanyId != null) {
        user = res.user!;
        companies = res.companies;
        activeCompanyId = res.activeCompanyId!;
      } else {
        // fallback: backend antiguo sin datos de usuario en refresh
        final meRes = await _apiClient.get('/auth/me');
        final data = meRes.data as Map<String, dynamic>;
        user = UserInfo.fromJson(data['user']);
        companies = (data['companies'] as List)
            .map((c) => CompanyInfo.fromJson(c))
            .toList();
        activeCompanyId = data['activeCompanyId'] as int;
      }

      state = AuthState.authenticated(
        user: user,
        companies: companies,
        activeCompanyId: activeCompanyId,
        clientId: clientId,
      );
      return true;
    } catch (_) {
      await _apiClient.clearTokens();
      return false;
    }
  }

  Future<void> setClientId(String clientId) async {
    _apiClient.configure(clientId);
    await _apiClient.saveClientId(clientId);
    state = AuthState.unauthenticated(clientId: clientId);
  }

  Future<void> login(String email, String password,
      {bool rememberCredentials = false, String? tenant}) async {
    final clientId = _currentClientId;
    state = const AuthState.loading();
    _apiClient.clearAccessToken();
    try {
      // tenant elegido (DB destino); por defecto el clientId
      await _apiClient.setTenant(
        (tenant != null && tenant.trim().isNotEmpty) ? tenant.trim() : clientId,
      );
      final res = await _endpoints.login(email, password);
      _apiClient.setAccessToken(res.accessToken);
      await _apiClient.saveRefreshToken(res.refreshToken);
      // Save or clear credentials
      if (rememberCredentials) {
        await _apiClient.storage.write(key: _keySavedEmail, value: email);
        await _apiClient.storage.write(key: _keySavedPassword, value: password);
      } else {
        await _apiClient.storage.delete(key: _keySavedEmail);
        await _apiClient.storage.delete(key: _keySavedPassword);
      }

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
        error: 'Error de conexion: $e',
      );
    }
  }

  /// Returns saved credentials if they exist: {email, password}
  Future<Map<String, String>?> getSavedCredentials() async {
    final email = await _apiClient.storage.read(key: _keySavedEmail);
    final password = await _apiClient.storage.read(key: _keySavedPassword);
    if (email != null && password != null) {
      return {'email': email, 'password': password};
    }
    return null;
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

  Future<void> resetSetup() async {
    await _apiClient.clearAll();
    await _apiClient.storage.delete(key: _keySavedEmail);
    await _apiClient.storage.delete(key: _keySavedPassword);
    state = const AuthState.needsSetup();
  }

  String get _currentClientId {
    final s = state;
    if (s is AuthAuthenticated) return s.clientId;
    if (s is AuthUnauthenticated) return s.clientId;
    return '';
  }
}
