import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_provider.dart';
import '../auth/auth_state.dart';
import 'app_database.dart';
import 'cache_repository.dart';

/// Instancia única de la base de datos local (Drift). Vive toda la sesión.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final cacheRepositoryProvider = Provider<CacheRepository>((ref) {
  return CacheRepository(ref.watch(appDatabaseProvider));
});

/// Prefijo de scope para todas las claves de caché: `<tenant>:<companyId>`.
///
/// Aísla los datos por tenant (multi-DB) y por empresa activa, de modo que
/// cambiar de empresa o de cliente nunca muestra datos cacheados de otro.
/// Se recalcula al cambiar la sesión (login / switchCompany).
final cacheScopeProvider = Provider<String>((ref) {
  final tenant = ref.watch(apiClientProvider).tenant;
  final auth = ref.watch(authProvider);
  final companyId = auth is AuthAuthenticated ? auth.activeCompanyId : 0;
  return '$tenant:$companyId';
});
