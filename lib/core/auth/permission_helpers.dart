/// Permission key constants — mirror of VALID_MOBILE_PERMISSION_KEYS in the backend.
/// Use these constants everywhere instead of raw strings to avoid typos.
abstract class Permissions {
  // Clients
  static const clientsRead = 'clients.read';
  static const clientsWrite = 'clients.write';

  // Documents (invoices)
  static const documentsRead = 'documents.read';
  static const documentsWrite = 'documents.write';

  // Payments
  static const paymentsRead = 'payments.read';
  static const paymentsWrite = 'payments.write';

  // Catalog
  static const productsRead = 'products.read';
  static const servicesRead = 'services.read';

  // Reports / dashboard
  static const reportsRead = 'reports.read';

  // Expenses / purchases / scanner
  static const expensesRead = 'expenses.read';
  static const expensesWrite = 'expenses.write';
}

// ── Permission catalog for the management UI ───────────────────────────────────

class PermissionDef {
  final String key;
  final String label;

  const PermissionDef(this.key, this.label);
}

class PermissionGroup {
  final String title;
  final List<PermissionDef> permissions;

  const PermissionGroup(this.title, this.permissions);
}

const List<PermissionGroup> permissionCatalog = [
  PermissionGroup('Clientes', [
    PermissionDef(Permissions.clientsRead, 'Ver clientes'),
    PermissionDef(Permissions.clientsWrite, 'Crear y editar clientes'),
  ]),
  PermissionGroup('Facturas', [
    PermissionDef(Permissions.documentsRead, 'Ver facturas'),
    PermissionDef(Permissions.documentsWrite, 'Crear facturas'),
  ]),
  PermissionGroup('Pagos', [
    PermissionDef(Permissions.paymentsRead, 'Ver pagos'),
    PermissionDef(Permissions.paymentsWrite, 'Registrar pagos'),
  ]),
  PermissionGroup('Catálogo', [
    PermissionDef(Permissions.productsRead, 'Ver productos'),
    PermissionDef(Permissions.servicesRead, 'Ver servicios'),
  ]),
  PermissionGroup('Informes', [
    PermissionDef(Permissions.reportsRead, 'Ver dashboard e informes'),
  ]),
  PermissionGroup('Gastos', [
    PermissionDef(Permissions.expensesRead, 'Ver compras y gastos'),
    PermissionDef(Permissions.expensesWrite, 'Registrar gastos (escáner)'),
  ]),
];
