import 'package:drift/drift.dart';
import 'app_database.dart';

/// Una entrada leída de la caché: el JSON crudo + cuándo se guardó.
class CachedEntry {
  final String payload;
  final DateTime fetchedAt;

  const CachedEntry({required this.payload, required this.fetchedAt});

  /// True si la entrada supera [maxAge] (candidata a revalidar). Aun siendo
  /// stale se puede seguir mostrando mientras llega la respuesta de red (SWR).
  bool isStale(Duration maxAge) =>
      DateTime.now().difference(fetchedAt) > maxAge;
}

/// Acceso a la caché en dispositivo. Guarda respuestas GET como JSON opaco;
/// la (de)serialización vive en la capa que la usa (repos/providers de cada
/// feature). Diseñado para stale-while-revalidate.
class CacheRepository {
  final AppDatabase _db;

  CacheRepository(this._db);

  Future<CachedEntry?> read(String key) async {
    final row = await (_db.select(_db.cacheEntries)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    if (row == null) return null;
    return CachedEntry(
      payload: row.payload,
      fetchedAt: DateTime.fromMillisecondsSinceEpoch(row.fetchedAt),
    );
  }

  Future<void> write(String key, String payload) async {
    await _db.into(_db.cacheEntries).insertOnConflictUpdate(
          CacheEntriesCompanion.insert(
            key: key,
            payload: payload,
            fetchedAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
  }

  Future<void> delete(String key) async {
    await (_db.delete(_db.cacheEntries)..where((t) => t.key.equals(key))).go();
  }

  /// Borra por prefijo lógico (p.ej. `clients:`) — útil para invalidar todas
  /// las variantes de scope de una feature de una vez.
  Future<void> deleteByPrefix(String prefix) async {
    await (_db.delete(_db.cacheEntries)..where((t) => t.key.like('$prefix%')))
        .go();
  }

  /// Vacía toda la caché. Llamar al cerrar sesión (evita fuga entre tenants).
  Future<void> clearAll() async {
    await _db.delete(_db.cacheEntries).go();
  }
}
