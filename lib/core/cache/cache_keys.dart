import 'cache_repository.dart';

/// Prefijos lógicos de las claves de caché por feature. La clave completa
/// añade el scope `tenant:empresa` (ver `cacheScopeProvider`), p.ej.
/// `invoices:acme:12`. Borrar por prefijo invalida todas las variantes de
/// scope de una feature de una vez (over-clear seguro).
class CacheKeys {
  // Listas
  static const clients = 'clients:';
  static const invoices = 'invoices:';
  static const sales = 'sales:';
  static const budgets = 'budgets:';
  static const products = 'products:';
  static const services = 'services:';
  static const purchases = 'purchases:';
  static const suppliers = 'suppliers:';
  static const dashboard = 'dashboard:';

  // Detalle (por id). Se limpian junto a su lista en los busters.
  static const clientDetail = 'client_detail:';
  static const invoiceDetail = 'invoice_detail:';
  static const saleDetail = 'sale_detail:';
  static const budgetDetail = 'budget_detail:';
  static const productDetail = 'product_detail:';
  static const supplierDetail = 'supplier_detail:';
  static const purchaseDetail = 'purchase_detail:';

  const CacheKeys._();
}

/// Cliente creado/editado: invalida lista y fichas de detalle.
Future<void> bustClientCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.clients);
  await cache.deleteByPrefix(CacheKeys.clientDetail);
}

/// Un cambio en facturas (crear/editar/confirmar/finalizar/anular/cobrar)
/// afecta a la lista de facturas, su detalle y a los totales del dashboard.
Future<void> bustInvoiceCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.invoices);
  await cache.deleteByPrefix(CacheKeys.invoiceDetail);
  await cache.deleteByPrefix(CacheKeys.dashboard);
}

/// Crear una venta / convertir en factura afecta a la lista y detalle de ventas.
Future<void> bustSalesCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.sales);
  await cache.deleteByPrefix(CacheKeys.saleDetail);
}

/// Crear/aceptar/rechazar un presupuesto afecta a lista y detalle de presupuestos.
Future<void> bustBudgetCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.budgets);
  await cache.deleteByPrefix(CacheKeys.budgetDetail);
}

/// Alta/edición/borrado en catálogo afecta a productos, servicios y su detalle.
Future<void> bustCatalogCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.products);
  await cache.deleteByPrefix(CacheKeys.services);
  await cache.deleteByPrefix(CacheKeys.productDetail);
}

/// Un cambio en compras/gastos afecta a la lista/detalle de compras y al dashboard.
Future<void> bustPurchaseCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.purchases);
  await cache.deleteByPrefix(CacheKeys.purchaseDetail);
  await cache.deleteByPrefix(CacheKeys.dashboard);
}

/// Alta/edición de proveedor afecta a proveedores (lista+detalle) y a compras.
Future<void> bustSupplierCaches(CacheRepository cache) async {
  await cache.deleteByPrefix(CacheKeys.suppliers);
  await cache.deleteByPrefix(CacheKeys.supplierDetail);
  await cache.deleteByPrefix(CacheKeys.purchases);
}
