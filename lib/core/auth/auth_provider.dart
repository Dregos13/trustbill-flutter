import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_client.dart';
import '../api/api_error.dart';
import '../api/endpoints.dart';
import '../models/user.dart';
import 'auth_state.dart';

const _sessionDuration = Duration(hours: 8);
const _keyLoginTimestamp = 'login_timestamp';
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

    // Check session expiry
    final loginTs = await _apiClient.storage.read(key: _keyLoginTimestamp);
    if (loginTs != null) {
      final loginTime = DateTime.tryParse(loginTs);
      if (loginTime != null &&
          DateTime.now().difference(loginTime) > _sessionDuration) {
        await _apiClient.clearTokens();
        await _apiClient.storage.delete(key: _keyLoginTimestamp);
        state = AuthState.unauthenticated(
          clientId: clientId,
          error: 'Tu sesion ha expirado. Vuelve a iniciar sesion.',
        );
        return;
      }
    }

    final refreshToken = await _apiClient.getRefreshToken();
    if (refreshToken == null) {
      state = AuthState.unauthenticated(clientId: clientId);
      return;
    }

    try {
      final res = await _endpoints.refresh(refreshToken);
      _apiClient.setAccessToken(res.accessToken);
      await _apiClient.saveRefreshToken(res.refreshToken);
      // Update login timestamp on successful refresh
      await _apiClient.storage.write(
        key: _keyLoginTimestamp,
        value: DateTime.now().toIso8601String(),
      );

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

  Future<void> setClientId(String clientId) async {
    _apiClient.configure(clientId);
    await _apiClient.saveClientId(clientId);
    state = AuthState.unauthenticated(clientId: clientId);
  }

  Future<void> login(String email, String password,
      {bool rememberCredentials = false}) async {
    final clientId = _currentClientId;
    state = const AuthState.loading();
    try {
      final res = await _endpoints.login(email, password);
      _apiClient.setAccessToken(res.accessToken);
      await _apiClient.saveRefreshToken(res.refreshToken);
      // Save login timestamp for session expiry
      await _apiClient.storage.write(
        key: _keyLoginTimestamp,
        value: DateTime.now().toIso8601String(),
      );
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
    await _apiClient.storage.delete(key: _keyLoginTimestamp);
    state = AuthState.unauthenticated(clientId: clientId);
  }

  void forceLogout() {
    final clientId = _currentClientId;
    _apiClient.clearTokens();
    state = AuthState.unauthenticated(clientId: clientId);
  }

  Future<void> resetSetup() async {
    await _apiClient.clearAll();
    await _apiClient.storage.delete(key: _keyLoginTimestamp);
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
