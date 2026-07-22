import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Tabla genérica clave/valor para cachear respuestas GET en el dispositivo.
///
/// [key]      = identificador lógico + scope (p.ej. `clients:acme:12`).
/// [payload]  = JSON serializado de la respuesta.
/// [fetchedAt]= epoch millis del momento en que se guardó (para TTL/staleness).
class CacheEntries extends Table {
  TextColumn get key => text()();
  TextColumn get payload => text()();
  IntColumn get fetchedAt => integer()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [CacheEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor inyectable para tests (base en memoria).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() =>
    driftDatabase(name: 'trustbill_cache');
