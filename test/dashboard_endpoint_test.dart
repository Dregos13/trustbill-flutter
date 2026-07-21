import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/api/api_client.dart';
import 'package:trustinfacts_mobile/core/api/endpoints.dart';

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

ResponseBody _json(Map<String, dynamic> body) => ResponseBody.fromString(
  jsonEncode(body),
  200,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const storageChannel = MethodChannel(
    'plugins.it_nomads.com/flutter_secure_storage',
  );

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(storageChannel, (_) async => null);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(storageChannel, null);
  });

  test(
    'getMobileDashboard sends selected date range as query params',
    () async {
      RequestOptions? captured;
      final dio = Dio()
        ..httpClientAdapter = _FakeAdapter((options) async {
          captured = options;
          return _json({
            'month': {
              'label': '01/01 - 31/01',
              'facturado': 100,
              'facturadoPrev': 50,
              'cobrado': 80,
              'pendiente': 20,
              'gastos': 10,
              'facturasCount': 1,
            },
            'history': [],
            'upcoming': [],
            'topClients': [],
          });
        });

      final client = ApiClient(dio: dio, refreshDio: Dio());
      client.configure('test');

      await Endpoints(
        client,
      ).getMobileDashboard(from: '2026-01-01', to: '2026-01-31');

      expect(captured?.path, '/dashboard/mobile');
      expect(captured?.queryParameters['from'], '2026-01-01');
      expect(captured?.queryParameters['to'], '2026-01-31');
    },
  );
}
