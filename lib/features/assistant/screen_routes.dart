/// Traduce las pantallas SEMÁNTICAS que propone el gateway
/// (`trustcore-ai/app/tools/navigation.py::Screen`) a rutas reales de la app.
///
/// Vive fuera de `assistant_screen.dart` a propósito: es la mitad de un
/// contrato entre tres repositorios (gateway, web, móvil) y necesita test
/// propio. La web tiene su gemelo en `src/assistant/screenRoutes.ts`.
///
/// Si el gateway añade una pantalla y esta tabla no se actualiza,
/// `routeForGatewayScreen` devuelve null y no se navega: nunca un crash por una
/// ruta desconocida. Lo que sí es un fallo silencioso —y el motivo de que esto
/// tenga tests— es mandar al usuario al dominio equivocado: pedir un
/// presupuesto y aterrizar en la pantalla de crear factura.
library;

/// Copia del enum `Screen` del gateway, en su mismo orden. Existe para que el
/// test compruebe que no falta ninguna: sin ella, olvidar una pantalla nueva no
/// rompe nada visible, solo deja de navegar.
///
/// Al tocar `navigation.py::Screen`, actualizar esta lista en el mismo trabajo.
const gatewayScreens = <String>[
  'trustinfacts.dashboard',
  'trustinfacts.reports',
  'trustinfacts.customers.list',
  'trustinfacts.customers.detail',
  'trustinfacts.suppliers.list',
  'trustinfacts.suppliers.detail',
  'trustinfacts.catalog.list',
  'trustinfacts.catalog.detail',
  'trustinfacts.budgets.list',
  'trustinfacts.budgets.create',
  'trustinfacts.budgets.detail',
  'trustinfacts.sales.list',
  'trustinfacts.sales.create',
  'trustinfacts.sales.detail',
  'trustinfacts.invoices.list',
  'trustinfacts.invoices.create',
  'trustinfacts.invoices.detail',
  'trustinfacts.expenses.list',
  'trustinfacts.expenses.create',
  'trustinfacts.expenses.detail',
  'trustinfacts.tasks.list',
  'trustinfacts.tasks.create',
  'trustinfacts.tasks.detail',
  'trustinfacts.tasks.map',
  'trustinfacts.settings.taxes',
];

String? routeForGatewayScreen(String screen, String? entityId) {
  switch (screen) {
    case 'trustinfacts.dashboard':
    case 'trustinfacts.reports':
      return '/';
    case 'trustinfacts.customers.list':
      return '/clients';
    case 'trustinfacts.customers.detail':
      return entityId != null ? '/clients/$entityId' : '/clients';
    case 'trustinfacts.suppliers.list':
      return '/suppliers';
    // La app no tiene ficha de proveedor: solo listado, alta y edición. Se
    // lleva al listado en vez de no navegar.
    case 'trustinfacts.suppliers.detail':
      return '/suppliers';
    case 'trustinfacts.catalog.list':
      return '/catalog';
    case 'trustinfacts.catalog.detail':
      return entityId != null ? '/catalog/products/$entityId' : '/catalog';
    case 'trustinfacts.budgets.list':
      return '/budgets';
    case 'trustinfacts.budgets.create':
      return '/budgets/new';
    case 'trustinfacts.budgets.detail':
      return entityId != null ? '/budgets/$entityId' : '/budgets';
    case 'trustinfacts.sales.list':
      return '/sales';
    case 'trustinfacts.sales.create':
      return '/sales/new';
    case 'trustinfacts.sales.detail':
      return entityId != null ? '/sales/$entityId' : '/sales';
    case 'trustinfacts.invoices.list':
      return '/invoices';
    case 'trustinfacts.invoices.create':
      return '/invoices/new';
    case 'trustinfacts.invoices.detail':
      return entityId != null ? '/invoices/$entityId' : '/invoices';
    // "expenses" en el gateway es el libro de gastos (ExpenseEntry); la
    // pantalla más cercana en la app es "Compras" (facturas/tickets de
    // proveedor), que es de donde salen esos gastos. Todavía no existe una
    // pantalla "/expenses" dedicada.
    case 'trustinfacts.expenses.list':
      return '/purchases';
    case 'trustinfacts.expenses.create':
      return '/scan';
    case 'trustinfacts.expenses.detail':
      return entityId != null ? '/purchases/$entityId' : '/purchases';
    // Ojo: el listado es '/tasks' en plural y la tarea suelta '/task' en
    // singular. No es un desliz, es como están declaradas en app_router.dart.
    case 'trustinfacts.tasks.list':
      return '/tasks';
    case 'trustinfacts.tasks.create':
      return '/task/new';
    case 'trustinfacts.tasks.detail':
      return entityId != null ? '/task/$entityId' : '/tasks';
    case 'trustinfacts.tasks.map':
      return '/map';
    case 'trustinfacts.settings.taxes':
      return '/tax';
    default:
      return null;
  }
}
