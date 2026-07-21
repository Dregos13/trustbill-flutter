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

ResponseBody _json(Object body) => ResponseBody.fromString(
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
    'getSuppliers sends pagination/search and parses supplier list',
    () async {
      RequestOptions? captured;
      final dio = Dio()
        ..httpClientAdapter = _FakeAdapter((options) async {
          captured = options;
          return _json({
            'items': [
              {
                'id': 1,
                'name': 'Proveedor Test SL',
                'taxId': 'B12345678',
                'email': 'hola@proveedor.test',
                'phone': '600111222',
                'address': 'Calle Uno 1',
                'postalCode': '28001',
                'notes': 'Preferente',
                'purchasesCount': 3,
              },
            ],
            'total': 1,
            'limit': 20,
            'offset': 0,
          });
        });

      final client = ApiClient(dio: dio, refreshDio: Dio());
      client.configure('test');

      final result = await Endpoints(
        client,
      ).getSuppliers(limit: 20, offset: 0, search: 'Proveedor');

      expect(captured?.path, '/suppliers');
      expect(captured?.queryParameters['limit'], 20);
      expect(captured?.queryParameters['offset'], 0);
      expect(captured?.queryParameters['search'], 'Proveedor');
      expect(result.items.single.name, 'Proveedor Test SL');
      expect(result.items.single.purchasesCount, 3);
    },
  );
}
