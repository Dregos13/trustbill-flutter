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
  static const products = 'products:';
  static const services = 'services:';
  static const purchases = 'purchases:';
  static const suppliers = 'suppliers:';
  static const dashboard = 'dashboard:';

  const CacheKeys._();
}

/// Un cambio en facturas (crear/editar/confirmar/finalizar/anular/cobrar)
/// afecta a la lista de facturas y a los totales del dashboard.
Future<void> bustInvoiceCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.invoices);
  await cache.deleteByPrefix(CacheKeys.dashboard);
}

/// Crear una venta afecta a la lista de ventas.
Future<void> bustSalesCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.sales);
}

/// Crear/aceptar/rechazar un presupuesto afecta a la lista de presupuestos.
Future<void> bustBudgetCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.budgets);
}

/// Alta/edición/borrado en catálogo afecta a productos y servicios.
Future<void> bustCatalogCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.products);
  await cache.deleteByPrefix(CacheKeys.services);
}

/// Un cambio en compras/gastos afecta a la lista de compras y al dashboard.
Future<void> bustPurchaseCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.purchases);
  await cache.deleteByPrefix(CacheKeys.dashboard);
}

/// Alta/edición de proveedor afecta a proveedores y a compras (relacionadas).
Future<void> bustSupplierCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.suppliers);
  await cache.deleteByPrefix(CacheKeys.purchases);
}
