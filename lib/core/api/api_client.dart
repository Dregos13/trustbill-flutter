import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_error.dart';

String buildBaseUrl(String clientId) =>
    'https://app.$clientId.trustinfacts.com/api';

enum _RefreshOutcome { success, authFailure, networkFailure }

class ApiClient {
  final Dio _dio;
  // Cliente Dio dedicado al refresh: SIN el interceptor de auth, para no
  // entrar en recursión (un 401 del refresh no debe disparar otro refresh).
  final Dio _refreshDio;
  final FlutterSecureStorage _storage;
  // Base del backoff entre reintentos de refresh (inyectable para tests).
  final Duration _retryBaseDelay;
  String? _accessToken;
  String _baseUrl = '';
  // Slug de tenant (multi-DB) = clientId. Se envía en login/refresh para que
  // la API apunte a la base de datos de este cliente.
  String _tenant = '';
  Future<_RefreshOutcome>? _refreshFuture;

  void Function()? onAuthError;

  ApiClient({
    FlutterSecureStorage? storage,
    Dio? dio,
    Dio? refreshDio,
    Duration retryBaseDelay = const Duration(milliseconds: 500),
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _retryBaseDelay = retryBaseDelay,
        _dio = dio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 15),
            )),
        _refreshDio = refreshDio ??
            Dio(BaseOptions(
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_accessToken != null) {
          options.headers['Authorization'] = 'Bearer $_accessToken';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401 && _accessToken != null) {
          // Guarda anti-bucle: una request solo puede disparar UN ciclo de
          // refresh+retry. Si tras refrescar vuelve a dar 401, es un 401 real
          // (no de token caducado) → no refrescamos en bucle.
          if (error.requestOptions.extra['__retried'] == true) {
            onAuthError?.call();
            return handler.next(error);
          }

          _refreshFuture ??= _attemptRefresh().whenComplete(() {
            _refreshFuture = null;
          });

          final outcome = await _refreshFuture!;
          if (outcome == _RefreshOutcome.success) {
            error.requestOptions.extra['__retried'] = true;
            error.requestOptions.headers['Authorization'] =
                'Bearer $_accessToken';
            try {
              final retry = await _dio.fetch(error.requestOptions);
              return handler.resolve(retry);
            } catch (retryError) {
              if (retryError is DioException) {
                return handler.next(retryError);
              }
            }
          } else if (outcome == _RefreshOutcome.authFailure) {
            onAuthError?.call();
            return handler.next(error);
          }
          // networkFailure: pass error through without logging out — transient issue
          return handler.next(error);
        }

        final data = error.response?.data;
        if (data is Map<String, dynamic>) {
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              response: error.response,
              error: ApiError(
                status: error.response?.statusCode ?? 0,
                code: data['error'] as String? ?? 'UNKNOWN',
                message: data['message'] as String? ?? 'Error desconocido',
                retryAfter: data['retryAfter'] as int?,
              ),
              type: DioExceptionType.badResponse,
            ),
          );
        }

        handler.next(error);
      },
    ));
  }

  FlutterSecureStorage get storage => _storage;
  String get baseUrl => _baseUrl;
  String get tenant => _tenant;

  void configure(String clientId) {
    _baseUrl = buildBaseUrl(clientId);
    _dio.options.baseUrl = _baseUrl;
    _refreshDio.options.baseUrl = _baseUrl;
    _tenant = clientId; // por defecto el tenant = clientId (se puede override)
  }

  /// Fija el tenant (DB destino) elegido en login y lo persiste para el refresh.
  Future<void> setTenant(String t) async {
    _tenant = t;
    await _storage.write(key: 'tenant', value: t);
  }

  /// Restaura el tenant persistido (si lo hay) tras reiniciar la app.
  Future<void> loadTenant() async {
    final t = await _storage.read(key: 'tenant');
    if (t != null && t.isNotEmpty) _tenant = t;
  }

  String? get accessToken => _accessToken;

  void setAccessToken(String token) => _accessToken = token;
  void clearAccessToken() => _accessToken = null;

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: 'refresh_token');
  }

  Future<void> saveClientId(String clientId) async {
    await _storage.write(key: 'client_id', value: clientId);
  }

  Future<String?> getClientId() async {
    return _storage.read(key: 'client_id');
  }

  Future<void> clearAll() async {
    _accessToken = null;
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: 'client_id');
    await _storage.delete(key: 'tenant');
    _baseUrl = '';
    _tenant = '';
    _dio.options.baseUrl = '';
    _refreshDio.options.baseUrl = '';
  }

  Future<void> clearTokens() async {
    _accessToken = null;
    await _storage.delete(key: 'refresh_token');
  }

  Future<_RefreshOutcome> _attemptRefresh() async {
    final rt = await getRefreshToken();
    if (rt == null) return _RefreshOutcome.authFailure;

    // Solo reintentamos en errores donde la petición NO llegó a tocar el server
    // (no se estableció conexión). Si el server pudo haber procesado el refresh
    // (receiveTimeout/sendTimeout) NO reintentamos con el mismo token: el server
    // ya pudo haberlo rotado y un reintento dispararía la deteccion de robo.
    const maxAttempts = 3;
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        final res = await _refreshDio.post(
          '/auth/refresh',
          data: {'refreshToken': rt, 'tenant': _tenant},
        );
        if (res.statusCode == 200) {
          _accessToken = res.data['accessToken'] as String;
          await saveRefreshToken(res.data['refreshToken'] as String);
          return _RefreshOutcome.success;
        }
        // Server respondió pero no 200 (4xx/5xx) — no reintentar
        return _RefreshOutcome.authFailure;
      } on DioException catch (e) {
        // El server respondió con un status de error (p.ej. 401 token invalido)
        if (e.response != null) {
          return _RefreshOutcome.authFailure;
        }

        // Solo seguro reintentar si NO se estableció conexión con el server.
        final safeToRetry = e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.connectionError;
        if (safeToRetry && attempt < maxAttempts - 1) {
          await Future.delayed(_retryBaseDelay * (attempt + 1));
          continue;
        }

        // Cualquier fallo de red (incluido receiveTimeout, donde el server pudo
        // haber rotado el token): tratar como transitorio, NO cerrar sesion.
        final isNetworkError = e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.connectionError;
        return isNetworkError
            ? _RefreshOutcome.networkFailure
            : _RefreshOutcome.authFailure;
      } catch (_) {
        return _RefreshOutcome.networkFailure;
      }
    }
    return _RefreshOutcome.networkFailure;
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) =>
      _dio.get(path, queryParameters: queryParams);

  Future<Response> post(String path, {dynamic data}) => _dio.post(path,
      data: data,
      options: Options(headers: {'Content-Type': 'application/json'}));

  Future<Response> put(String path, {dynamic data}) => _dio.put(path,
      data: data,
      options: Options(headers: {'Content-Type': 'application/json'}));

  Future<Response> patch(String path, {dynamic data}) => _dio.patch(path,
      data: data,
      options: Options(headers: {'Content-Type': 'application/json'}));

  Future<Response> delete(String path) => _dio.delete(path);

  Future<Response> postMultipart(
    String path, {
    required Uint8List fileBytes,
    required String fileName,
    required String mimeType,
  }) {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
        contentType: DioMediaType.parse(mimeType),
      ),
    });
    return _dio.post(
      path,
      data: formData,
      options: Options(
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
  }

  /// Download a binary resource (e.g. logo) and return its raw bytes.
  Future<Uint8List> getBytes(String path) async {
    final res = await _dio.get<List<int>>(
      path,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(res.data ?? []);
  }

  Future<Response> download(String path, String savePath) =>
      _dio.download(path, savePath,
          options: Options(headers: {
            'Authorization': 'Bearer $_accessToken',
          }));
}
