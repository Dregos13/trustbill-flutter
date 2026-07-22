import 'cache_repository.dart';

/// Prefijos lógicos de las claves de caché por feature. La clave completa
/// añade el scope `tenant:empresa` (ver `cacheScopeProvider`), p.ej.
/// `invoices:acme:12`. Borrar por prefijo invalida todas las variantes de
/// scope de una feature de una vez (over-clear seguro).
class CacheKeys {
  static const clients = 'clients:';
  static const invoices = 'invoices:';
  static const sales = 'sales:';
  static const budgets = 'budgets:';
  static const dashboard = 'dashboard:';

  const CacheKeys._();
}

/// Un cambio en facturas (crear/editar/confirmar/finalizar/anular/cobrar)
/// afecta a la lista de facturas y a los totales del dashboard.
Future<void> bustInvoiceCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.invoices);
  await cache.deleteByPrefix(CacheKeys.dashboard);
}
