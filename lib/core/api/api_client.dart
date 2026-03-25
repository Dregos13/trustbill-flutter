import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_error.dart';

const String baseUrl = 'https://app.demo.trustinfacts.com/api';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  String? _accessToken;
  Future<bool>? _refreshFuture;

  void Function()? onAuthError;

  ApiClient({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(),
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
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
          _refreshFuture ??= _attemptRefresh().whenComplete(() {
            _refreshFuture = null;
          });

          final success = await _refreshFuture!;
          if (success) {
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
          } else {
            onAuthError?.call();
          }
        }

        final data = error.response?.data;
        if (data is Map<String, dynamic>) {
          throw ApiError(
            status: error.response?.statusCode ?? 0,
            code: data['error'] as String? ?? 'UNKNOWN',
            message: data['message'] as String? ?? 'Error desconocido',
            retryAfter: data['retryAfter'] as int?,
          );
        }

        handler.next(error);
      },
    ));
  }

  String? get accessToken => _accessToken;

  void setAccessToken(String token) => _accessToken = token;

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: 'refresh_token');
  }

  Future<void> clearTokens() async {
    _accessToken = null;
    await _storage.delete(key: 'refresh_token');
  }

  Future<bool> _attemptRefresh() async {
    final rt = await getRefreshToken();
    if (rt == null) return false;
    try {
      final res = await Dio(BaseOptions(baseUrl: baseUrl)).post(
        '/auth/refresh',
        data: {'refreshToken': rt},
      );
      if (res.statusCode == 200) {
        _accessToken = res.data['accessToken'];
        await saveRefreshToken(res.data['refreshToken']);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) =>
      _dio.get(path, queryParameters: queryParams);

  Future<Response> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);

  Future<Response> download(String path, String savePath) =>
      _dio.download(path, savePath,
          options: Options(headers: {
            'Authorization': 'Bearer $_accessToken',
          }));
}
