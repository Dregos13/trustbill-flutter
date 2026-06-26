import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_client.dart';
import '../api/api_error.dart';
import '../api/endpoints.dart';
import '../models/user.dart';
import '../utils/error_messages.dart';
import 'auth_state.dart';

const _keySavedEmail = 'saved_email';
const _keySavedPassword = 'saved_password';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final endpointsProvider = Provider<Endpoints>((ref) {
  return Endpoints(ref.read(apiClientProvider));
});

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  late final ApiClient _apiClient;
  late final Endpoints _endpoints;

  @override
  AuthState build() {
    _apiClient = ref.read(apiClientProvider);
    _endpoints = ref.read(endpointsProvider);
    _apiClient.onAuthError = () { forceLogout(); };
    return const AuthState.initial();
  }

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
      await _applyModules();
      return true;
    } on DioException catch (e) {
      // Solo limpiamos si el SERVER rechazó el token (respondió 401). Un error
      // de red (sin respuesta) deja el token intacto: sigue siendo válido y no
      // queremos perder la sesión por un fallo de conectividad transitorio.
      if (_isAuthRejection(e)) {
        await _apiClient.clearTokens();
      }
      return false;
    } on ApiError catch (e) {
      if (e.isUnauthorized) {
        await _apiClient.clearTokens();
      }
      return false;
    } catch (_) {
      // Desconocido/transitorio: preservar el token.
      return false;
    }
  }

  /// True solo si el server respondió rechazando el token (401), no si fue un
  /// fallo de red. El interceptor envuelve el ApiError dentro de DioException.error.
  bool _isAuthRejection(DioException e) {
    if (e.response?.statusCode == 401) return true;
    final inner = e.error;
    return inner is ApiError && inner.isUnauthorized;
  }

  /// Extrae el ApiError de lo que se haya lanzado: puede venir directo o
  /// envuelto por el interceptor dentro de DioException.error.
  ApiError? _asApiError(Object e) {
    if (e is ApiError) return e;
    if (e is DioException && e.error is ApiError) return e.error as ApiError;
    return null;
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
      await _applyModules();
    } catch (e) {
      // El interceptor envuelve el ApiError dentro de DioException.error, así
      // que desempaquetamos para mostrar el mensaje real del server (p.ej.
      // "Credenciales invalidas") en vez de un genérico de conexión.
      final apiErr = _asApiError(e);
      state = AuthState.unauthenticated(
        clientId: clientId,
        error: apiErr != null ? apiErr.message : friendlyError(e),
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
        await _applyModules();
      }
    } catch (e) {
      // El 401 normalmente lo resuelve el interceptor (refresh + reintento); si
      // la sesión ya está muerta, cerramos. Capturamos cualquier error para no
      // propagar excepciones sin manejar a la UI.
      final apiErr = _asApiError(e);
      if (apiErr?.isUnauthorized ?? false) {
        await forceLogout();
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

  Future<void> forceLogout() async {
    final clientId = _currentClientId;
    await _apiClient.clearTokens();
    state = AuthState.unauthenticated(clientId: clientId);
  }

  Future<void> resetSetup() async {
    await _apiClient.clearAll();
    await _apiClient.storage.delete(key: _keySavedEmail);
    await _apiClient.storage.delete(key: _keySavedPassword);
    state = const AuthState.needsSetup();
  }

  /// Fetches /me/capabilities and merges modules into the current authenticated state.
  /// Non-fatal: if the call fails, modules stay empty and the tab stays hidden.
  Future<void> _applyModules() async {
    try {
      final modules = await _endpoints.getEnabledModules();
      final s = state;
      if (s is AuthAuthenticated) {
        state = s.copyWith(user: s.user.copyWith(modules: modules));
      }
    } catch (_) {
      // best-effort — tab stays hidden on failure
    }
  }

  String get _currentClientId {
    final s = state;
    if (s is AuthAuthenticated) return s.clientId;
    if (s is AuthUnauthenticated) return s.clientId;
    return '';
  }
}
