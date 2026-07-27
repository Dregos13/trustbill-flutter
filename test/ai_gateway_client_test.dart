import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/api/ai_gateway_client.dart';
import 'package:trustinfacts_mobile/core/api/api_client.dart';
import 'package:trustinfacts_mobile/core/api/api_error.dart';

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.onFetch);

  final Future<ResponseBody> Function(RequestOptions options) onFetch;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return onFetch(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(Map<String, dynamic> body, int status) =>
    ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const storageChannel = MethodChannel(
    'plugins.it_nomads.com/flutter_secure_storage',
  );
  late Map<String, String> store;

  setUp(() {
    // Mock en memoria (no un no-op): el escenario de refresh necesita que
    // saveRefreshToken/getRefreshToken hagan un round-trip real.
    store = <String, String>{};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(storageChannel, (call) async {
      final args = (call.arguments as Map?) ?? const {};
      final key = args['key'] as String?;
      switch (call.method) {
        case 'write':
          store[key!] = args['value'] as String;
          return null;
        case 'read':
          return store[key];
        case 'delete':
          store.remove(key);
          return null;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(storageChannel, null);
  });

  test(
    'attaches the shared JWT as Bearer and sends no AI API key of its own',
    () async {
      RequestOptions? captured;
      // El gateway usa un Dio PROPIO, separado del de ApiClient (así es en
      // producción: AiGatewayClient nunca comparte interceptores con la
      // Mobile API, solo lee el token vigente de ApiClient).
      final gatewayDio = Dio()
        ..httpClientAdapter = _FakeAdapter((options) async {
          captured = options;
          return _json({'answer': 'ok', 'status': 'completed'}, 200);
        });
      final apiClient = ApiClient();
      apiClient.setAccessToken('mobile-jwt-token');

      final gateway = AiGatewayClient(apiClient, dio: gatewayDio);
      await gateway.post('/api/v1/chat', data: {'message': 'hola'});

      expect(captured!.headers['Authorization'], 'Bearer mobile-jwt-token');
      // Ninguna cabecera de API key propia del gateway (Gemini/OpenAI/etc.).
      expect(captured!.headers.containsKey('x-api-key'), isFalse);
      expect(captured!.headers.containsKey('api-key'), isFalse);
    },
  );

  test('a 401 triggers a refresh on the shared ApiClient and retries once',
      () async {
    var gatewayCalls = 0;
    var refreshCalls = 0;

    final gatewayDio = Dio()
      ..httpClientAdapter = _FakeAdapter((options) async {
        gatewayCalls++;
        if (options.extra['__retried'] == true) {
          return _json({'answer': 'ok', 'status': 'completed'}, 200);
        }
        return _json(
          {
            'error': {'code': 'INVALID_TOKEN', 'message': 'JWT expired.'},
          },
          401,
        );
      });
    final refreshDio = Dio()
      ..httpClientAdapter = _FakeAdapter((options) async {
        refreshCalls++;
        return _json({'accessToken': 'new-jwt', 'refreshToken': 'new-rt'}, 200);
      });

    // ApiClient's propio `dio` (para SUS llamadas a la Mobile API) no
    // interviene en este escenario: solo importa `refreshDio`.
    final apiClient = ApiClient(refreshDio: refreshDio);
    apiClient.configure('test');
    apiClient.setAccessToken('old-jwt');
    await apiClient.saveRefreshToken('rt-1');

    final gateway = AiGatewayClient(apiClient, dio: gatewayDio);
    final res = await gateway.post('/api/v1/chat', data: {'message': 'hola'});

    expect(res.statusCode, 200);
    expect(refreshCalls, 1);
    expect(gatewayCalls, 2, reason: 'la request original + el reintento');
    expect(apiClient.accessToken, 'new-jwt');
  });

  test(
    'normalizes {"error": {"code","message"}} into an ApiError for friendlyError()',
    () async {
      final gatewayDio = Dio()
        ..httpClientAdapter = _FakeAdapter((options) async {
          return _json(
            {
              'error': {
                'code': 'CONFIRMATION_EXPIRED',
                'message': 'Confirmation has expired.',
              },
            },
            410,
          );
        });
      final apiClient = ApiClient();
      apiClient.setAccessToken('token');

      final gateway = AiGatewayClient(apiClient, dio: gatewayDio);

      try {
        await gateway.post('/api/v1/confirmations/x/confirm');
        fail('debia lanzar');
      } on DioException catch (e) {
        expect(e.error, isA<ApiError>());
        final apiError = e.error as ApiError;
        expect(apiError.status, 410);
        expect(apiError.code, 'CONFIRMATION_EXPIRED');
      }
    },
  );

  test('normalizes FastAPI pydantic validation errors (422 detail list)',
      () async {
    final gatewayDio = Dio()
      ..httpClientAdapter = _FakeAdapter((options) async {
        return _json(
          {
            'detail': [
              {
                'msg': 'String should have at least 1 character',
                'loc': ['body', 'message'],
              },
            ],
          },
          422,
        );
      });
    final apiClient = ApiClient();
    apiClient.setAccessToken('token');

    final gateway = AiGatewayClient(apiClient, dio: gatewayDio);

    try {
      await gateway.post('/api/v1/chat', data: {'message': ''});
      fail('debia lanzar');
    } on DioException catch (e) {
      final apiError = e.error as ApiError;
      expect(apiError.code, 'VALIDATION_ERROR');
      expect(apiError.message, contains('at least 1 character'));
    }
  });

  test('normalizes a plain 500 with string detail as INTERNAL_ERROR', () async {
    final gatewayDio = Dio()
      ..httpClientAdapter = _FakeAdapter((options) async {
        return _json({'detail': 'Internal Server Error'}, 500);
      });
    final apiClient = ApiClient();
    apiClient.setAccessToken('token');

    final gateway = AiGatewayClient(apiClient, dio: gatewayDio);

    try {
      await gateway.post('/api/v1/chat', data: {'message': 'hola'});
      fail('debia lanzar');
    } on DioException catch (e) {
      final apiError = e.error as ApiError;
      expect(apiError.code, 'INTERNAL_ERROR');
      expect(apiError.message, 'Internal Server Error');
    }
  });
}
