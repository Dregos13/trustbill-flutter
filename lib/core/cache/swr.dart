import 'dart:convert';
import '../models/paginated.dart';
import 'cache_repository.dart';

/// Stale-while-revalidate genérico para providers de tipo Stream.
///
/// 1. Si [cacheable] y hay caché, la emite al instante (pinta sin spinner).
/// 2. Lanza [fetch]; guarda la respuesta y la emite.
/// 3. Si la red falla PERO ya se sirvió caché, se mantiene lo cacheado
///    (tolerante a fallos/offline). Sin caché previa, propaga el error.
///
/// El "force network" del pull-to-refresh se resuelve borrando la clave antes
/// de reejecutar el provider: sin caché que servir, va directo a red.
Stream<T> swrStream<T>({
  required CacheRepository cache,
  required String key,
  required bool cacheable,
  required String Function(T value) encode,
  required T Function(String json) decode,
  required Future<T> Function() fetch,
}) async* {
  var servedCache = false;
  if (cacheable) {
    final entry = await cache.read(key);
    if (entry != null) {
      yield decode(entry.payload);
      servedCache = true;
    }
  }
  try {
    final fresh = await fetch();
    if (cacheable) await cache.write(key, encode(fresh));
    yield fresh;
  } catch (_) {
    if (!servedCache) rethrow;
  }
}

/// JSON de una respuesta paginada (los items usan su propio `toJson`).
String encodePaginated<T>(
  PaginatedResponse<T> r,
  Map<String, dynamic> Function(T item) toJson,
) =>
    jsonEncode({
      'items': r.items.map(toJson).toList(),
      'total': r.total,
      'limit': r.limit,
      'offset': r.offset,
    });

PaginatedResponse<T> decodePaginated<T>(
  String json,
  T Function(Map<String, dynamic>) fromJson,
) =>
    PaginatedResponse.fromJson(
      jsonDecode(json) as Map<String, dynamic>,
      fromJson,
    );

/// SWR para pantallas con estado manual (setState) que cargan una `List<T>`.
///
/// Llama [onData] primero con la caché (si [cacheable] y existe) y luego con la
/// respuesta de red, que además se guarda. [onError] solo se invoca si no había
/// caché que mostrar (con caché servida, un fallo de red se ignora → offline ok).
Future<void> swrLoadList<T>({
  required CacheRepository cache,
  required String key,
  required bool cacheable,
  required Map<String, dynamic> Function(T item) toJson,
  required T Function(Map<String, dynamic>) fromJson,
  required Future<List<T>> Function() fetch,
  required void Function(List<T> items) onData,
  required void Function(Object error) onError,
}) async {
  var served = false;
  if (cacheable) {
    final entry = await cache.read(key);
    if (entry != null) {
      onData(
        (jsonDecode(entry.payload) as List)
            .map((e) => fromJson(e as Map<String, dynamic>))
            .toList(),
      );
      served = true;
    }
  }
  try {
    final items = await fetch();
    if (cacheable) {
      await cache.write(key, jsonEncode(items.map(toJson).toList()));
    }
    onData(items);
  } catch (e) {
    if (!served) onError(e);
  }
}
