import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/api/api_client.dart';
import 'package:trustinfacts_mobile/core/api/endpoints.dart';
import 'package:trustinfacts_mobile/core/auth/auth_provider.dart';
import 'package:trustinfacts_mobile/core/auth/auth_state.dart';

/// Adaptador Dio falso para la ruta /auth/refresh.
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  AuthNotifier buildNotifier(
      Future<ResponseBody> Function(RequestOptions) onRefresh) {
    final dio = Dio()..httpClientAdapter = _FakeAdapter(onRefresh);
    final client = ApiClient(dio: dio, refreshDio: Dio());
    final notifier = AuthNotifier(client, Endpoints(client));
    client.onAuthError = notifier.forceLogout;
    return notifier;
  }

  test('startup con fallo de red → conserva el refresh token (no logout)',
      () async {
    store['client_id'] = 'test';
    store['refresh_token'] = 'rt-valido';

    final notifier = buildNotifier((o) async {
      // El server no responde (sin conexión).
      throw DioException(
          requestOptions: o, type: DioExceptionType.connectionError);
    });

    await notifier.initialize();

    expect(store['refresh_token'], 'rt-valido',
        reason:
            'un fallo de red al abrir la app NO debe destruir el token válido');
    expect(notifier.state, isA<AuthUnauthenticated>());
  });

  test('startup con token rechazado (401) → limpia el refresh token', () async {
    store['client_id'] = 'test';
    store['refresh_token'] = 'rt-muerto';

    final notifier = buildNotifier((o) async => ResponseBody.fromString(
          jsonEncode({'error': 'UNAUTHORIZED', 'message': 'Refresh invalido'}),
          401,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        ));

    await notifier.initialize();

    expect(store.containsKey('refresh_token'), isFalse,
        reason: 'un token rechazado por el server sí debe limpiarse');
    expect(notifier.state, isA<AuthUnauthenticated>());
  });
}
