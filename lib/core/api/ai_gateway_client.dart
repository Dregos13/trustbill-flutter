import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_error.dart';

/// URL del gateway de IA (`trustcore-ai`). Vive en un HOST DISTINTO al de la
/// Mobile API (`ApiClient.baseUrl`, por tenant).
///
/// Desde el 2026-07-27 apunta a AWS por HTTPS. Antes era `http://192.168.1.104:8080`,
/// el servidor de casa: el asistente solo funcionaba dentro de esa LAN y el JWT
/// viajaba en claro. Ese servidor sigue en pie como vuelta atrás durante dos
/// semanas; para volver, basta con cambiar esta constante.
const String kAiGatewayBaseUrl = 'https://ai.trustcore.trustinfacts.com';

/// Cliente HTTP dedicado al gateway de IA. Reutiliza el JWT ya emitido por
/// TrustBill-Mobile (mismo secreto, mismos claims: sub/tenant/companyId/
/// role/permissions) a través del [ApiClient] compartido — no hay login ni
/// almacenamiento de token propio, y ninguna API key de IA llega al cliente.
class AiGatewayClient {
  final Dio _dio;
  final ApiClient _apiClient;

  AiGatewayClient(this._apiClient, {Dio? dio, String? baseUrl})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl ?? kAiGatewayBaseUrl,
              connectTimeout: const Duration(seconds: 10),
              // Un turno de chat pasa por el LLM (varios segundos) y puede
              // incluir tool calls contra la Mobile API antes de responder.
              // 180 s para igualar el timeout de Caddy delante del gateway: el
              // peor caso medido son ~135 s cuando Bedrock reintenta, y con los
              // 60 s de antes la app cortaba la conexión mientras el servidor
              // seguía trabajando — el usuario veía un error y el turno se
              // cobraba igual.
              receiveTimeout: const Duration(seconds: 180),
            ),
          ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _apiClient.accessToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 &&
              error.requestOptions.extra['__retried'] != true) {
            final refreshed = await _apiClient.refreshAccessToken();
            if (refreshed) {
              error.requestOptions.extra['__retried'] = true;
              final token = _apiClient.accessToken;
              if (token != null) {
                error.requestOptions.headers['Authorization'] = 'Bearer $token';
              }
              try {
                final retry = await _dio.fetch(error.requestOptions);
                return handler.resolve(retry);
              } catch (retryError) {
                if (retryError is DioException) {
                  return handler.next(_normalizeError(retryError));
                }
              }
            }
          }
          return handler.next(_normalizeError(error));
        },
      ),
    );
  }

  /// Envuelve la respuesta de error en un [ApiError], igual que hace
  /// [ApiClient] para la Mobile API — así `friendlyError()` funciona sin
  /// cambios para errores de este cliente también. El gateway (FastAPI)
  /// tiene TRES formas de error posibles:
  /// - `{"error": {"code", "message"}}` — errores de negocio (`TrustCoreError`).
  /// - `{"detail": [...]}}` — validación de Pydantic (422).
  /// - `{"detail": "..."}}` — error interno sin manejar (500 por defecto de FastAPI).
  DioException _normalizeError(DioException error) {
    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final err = data['error'];
      if (err is Map<String, dynamic>) {
        return _wrap(
          error,
          code: err['code'] as String? ?? 'UNKNOWN',
          message: err['message'] as String? ?? 'Error desconocido',
        );
      }

      final detail = data['detail'];
      if (detail is List && detail.isNotEmpty) {
        final first = detail.first;
        final msg = first is Map ? first['msg']?.toString() : null;
        return _wrap(
          error,
          code: 'VALIDATION_ERROR',
          message: msg ?? 'Datos inválidos.',
        );
      }
      if (detail is String && detail.isNotEmpty) {
        return _wrap(error, code: 'INTERNAL_ERROR', message: detail);
      }
    }
    return error;
  }

  DioException _wrap(
    DioException error, {
    required String code,
    required String message,
  }) {
    return DioException(
      requestOptions: error.requestOptions,
      response: error.response,
      type: DioExceptionType.badResponse,
      error: ApiError(
        status: error.response?.statusCode ?? 0,
        code: code,
        message: message,
      ),
    );
  }

  Future<Response> post(String path, {dynamic data}) => _dio.post(
    path,
    data: data,
    options: Options(
      headers: data == null ? null : {'Content-Type': 'application/json'},
    ),
  );

  Future<Response> get(String path) => _dio.get(path);
}
