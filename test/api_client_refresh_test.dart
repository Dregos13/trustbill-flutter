import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/api/api_client.dart';

/// Adaptador Dio falso: responde según una función inyectada, sin red real.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.onFetch);
  final Future<ResponseBody> Function(RequestOptions options) onFetch;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) =>
      onFetch(options);

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

DioException _networkError(RequestOptions options, DioExceptionType type) =>
    DioException(requestOptions: options, type: type);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // ---- Mock de flutter_secure_storage (in-memory) ----
  const storageChannel =
      MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  late Map<String, String> store;

  setUp(() {
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
        case 'readAll':
          return Map<String, String>.from(store);
        case 'deleteAll':
          store.clear();
          return null;
        case 'containsKey':
          return store.containsKey(key);
        default:
          return null;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(storageChannel, null);
  });

  /// Construye un ApiClient con adaptadores falsos y backoff casi-cero.
  ApiClient buildClient({
    required Future<ResponseBody> Function(RequestOptions) onApi,
    required Future<ResponseBody> Function(RequestOptions) onRefresh,
  }) {
    final dio = Dio()..httpClientAdapter = _FakeAdapter(onApi);
    final refreshDio = Dio()..httpClientAdapter = _FakeAdapter(onRefresh);
    final client = ApiClient(
      dio: dio,
      refreshDio: refreshDio,
      retryBaseDelay: const Duration(milliseconds: 1),
    );
    client.configure('test');
    return client;
  }

  test('refresh OK → reintenta la request original y la resuelve 200', () async {
    var authErrorCalled = false;
    var refreshCalls = 0;

    final client = buildClient(
      onApi: (o) async {
        // El token viejo es rechazado; tras el refresh la request lleva la
        // marca __retried y el server la acepta.
        if (o.extra['__retried'] == true) {
          return _json({'data': 'ok'}, 200);
        }
        return _json({'error': 'UNAUTHORIZED'}, 401);
      },
      onRefresh: (o) async {
        refreshCalls++;
        return _json({'accessToken': 'new-at', 'refreshToken': 'new-rt'}, 200);
      },
    );
    client.onAuthError = () => authErrorCalled = true;
    client.setAccessToken('old-at');
    await client.saveRefreshToken('rt-1');

    final res = await client.get('/clients');

    expect(res.statusCode, 200);
    expect(res.data['data'], 'ok');
    expect(authErrorCalled, isFalse, reason: 'no debe cerrar sesión');
    expect(refreshCalls, 1);
    expect(client.accessToken, 'new-at');
    expect(await client.getRefreshToken(), 'new-rt',
        reason: 'debe persistir el refresh token rotado');
  });

  test('refresh rechazado (401) → onAuthError (logout) y propaga error',
      () async {
    var authErrorCalled = false;

    final client = buildClient(
      onApi: (o) async => _json({'error': 'UNAUTHORIZED'}, 401),
      onRefresh: (o) async => _json({'error': 'UNAUTHORIZED'}, 401),
    );
    client.onAuthError = () => authErrorCalled = true;
    client.setAccessToken('old-at');
    await client.saveRefreshToken('rt-1');

    await expectLater(client.get('/clients'), throwsA(isA<DioException>()));
    expect(authErrorCalled, isTrue, reason: '401 real → cerrar sesión');
  });

  test('fallo de red en refresh (receiveTimeout) → NO logout, token preservado',
      () async {
    var authErrorCalled = false;
    var refreshCalls = 0;

    final client = buildClient(
      onApi: (o) async => _json({'error': 'UNAUTHORIZED'}, 401),
      onRefresh: (o) async {
        refreshCalls++;
        throw _networkError(o, DioExceptionType.receiveTimeout);
      },
    );
    client.onAuthError = () => authErrorCalled = true;
    client.setAccessToken('old-at');
    await client.saveRefreshToken('rt-1');

    await expectLater(client.get('/clients'), throwsA(isA<DioException>()));

    expect(authErrorCalled, isFalse,
        reason: 'fallo de red transitorio NO debe cerrar sesión');
    expect(refreshCalls, 1,
        reason: 'receiveTimeout es ambiguo: no se reintenta el refresh');
    expect(await client.getRefreshToken(), 'rt-1',
        reason: 'el refresh token debe preservarse');
  });

  test('connectionError en refresh → reintenta 3 veces y NO cierra sesión',
      () async {
    var authErrorCalled = false;
    var refreshCalls = 0;

    final client = buildClient(
      onApi: (o) async => _json({'error': 'UNAUTHORIZED'}, 401),
      onRefresh: (o) async {
        refreshCalls++;
        throw _networkError(o, DioExceptionType.connectionError);
      },
    );
    client.onAuthError = () => authErrorCalled = true;
    client.setAccessToken('old-at');
    await client.saveRefreshToken('rt-1');

    await expectLater(client.get('/clients'), throwsA(isA<DioException>()));

    expect(refreshCalls, 3, reason: 'connectionError es seguro de reintentar');
    expect(authErrorCalled, isFalse);
    expect(await client.getRefreshToken(), 'rt-1');
  });

  test('401s concurrentes → un solo refresh (deduplicado)', () async {
    var refreshCalls = 0;

    final client = buildClient(
      onApi: (o) async {
        if (o.extra['__retried'] == true) {
          return _json({'data': 'ok'}, 200);
        }
        return _json({'error': 'UNAUTHORIZED'}, 401);
      },
      onRefresh: (o) async {
        refreshCalls++;
        // pequeño retardo para solapar las 3 requests sobre el mismo future
        await Future<void>.delayed(const Duration(milliseconds: 5));
        return _json({'accessToken': 'new-at', 'refreshToken': 'new-rt'}, 200);
      },
    );
    client.setAccessToken('old-at');
    await client.saveRefreshToken('rt-1');

    final results = await Future.wait([
      client.get('/clients'),
      client.get('/invoices'),
      client.get('/products'),
    ]);

    expect(results.every((r) => r.statusCode == 200), isTrue);
    expect(refreshCalls, 1,
        reason: 'el dedup (_refreshFuture) debe colapsar a un único refresh');
  });

  test('segundo 401 tras refresh → no entra en bucle de refresh', () async {
    var refreshCalls = 0;

    final client = buildClient(
      // El endpoint SIEMPRE responde 401, incluso con token nuevo.
      onApi: (o) async => _json({'error': 'FORBIDDEN-ISH'}, 401),
      onRefresh: (o) async {
        refreshCalls++;
        return _json({'accessToken': 'new-at', 'refreshToken': 'new-rt'}, 200);
      },
    );
    client.setAccessToken('old-at');
    await client.saveRefreshToken('rt-1');

    await expectLater(client.get('/clients'), throwsA(isA<DioException>()));

    expect(refreshCalls, 1,
        reason: 'la guarda __retried impide refrescar en bucle');
  });
}
