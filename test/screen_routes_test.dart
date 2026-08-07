import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/features/assistant/screen_routes.dart';

// Rutas reales declaradas en app_router.dart. Se copian aquí porque el router
// construye pantallas y no se puede importar sin arrastrar media app a un test
// que solo compara cadenas.
const _appRoutes = <String>{
  '/',
  '/clients',
  '/clients/:id',
  '/suppliers',
  '/catalog',
  '/catalog/products/:id',
  '/budgets',
  '/budgets/new',
  '/budgets/:id',
  '/sales',
  '/sales/new',
  '/sales/:id',
  '/invoices',
  '/invoices/new',
  '/invoices/:id',
  '/purchases',
  '/purchases/:id',
  '/scan',
  '/tasks',
  '/task/new',
  '/task/:id',
  '/map',
  '/tax',
};

/// Devuelve la ruta con el id sustituido por ':id', para poder compararla con
/// la tabla de rutas declaradas.
String _templateFor(String screen) {
  final route = routeForGatewayScreen(screen, '123');
  return route == null ? '' : route.replaceAll('123', ':id');
}

void main() {
  test('toda pantalla del gateway tiene ruta: una que falte deja de navegar en silencio', () {
    final missing = gatewayScreens
        .where((screen) => routeForGatewayScreen(screen, null) == null)
        .toList();
    expect(missing, isEmpty, reason: 'pantallas del gateway sin ruta en la app: $missing');
  });

  test('ninguna ruta del mapa es inventada: todas existen en el router', () {
    final unknown = gatewayScreens
        .map((screen) => '$screen -> ${_templateFor(screen)}')
        .where((pair) => !_appRoutes.contains(pair.split(' -> ').last))
        .toList();
    expect(unknown, isEmpty, reason: 'rutas que el router no monta: $unknown');
  });

  // El fallo caro, y el motivo de que este archivo exista: antes de tener
  // pantallas de presupuesto en el vocabulario del gateway, pedir un
  // presupuesto terminaba abriendo la creación de factura.
  test('crear un presupuesto NO lleva a la pantalla de factura', () {
    final budget = routeForGatewayScreen('trustinfacts.budgets.create', null);
    expect(budget, '/budgets/new');
    expect(budget, isNot(routeForGatewayScreen('trustinfacts.invoices.create', null)));
  });

  test('presupuesto, venta, factura y gasto aterrizan cada uno en su dominio', () {
    expect(routeForGatewayScreen('trustinfacts.budgets.list', null), '/budgets');
    expect(routeForGatewayScreen('trustinfacts.sales.list', null), '/sales');
    expect(routeForGatewayScreen('trustinfacts.invoices.list', null), '/invoices');
    // En esta app el libro de gastos se ve como "Compras".
    expect(routeForGatewayScreen('trustinfacts.expenses.list', null), '/purchases');
  });

  test('el id de la entidad se interpola', () {
    expect(routeForGatewayScreen('trustinfacts.budgets.detail', '42'), '/budgets/42');
    // Listado en plural, tarea suelta en singular: se comprueba a propósito.
    expect(routeForGatewayScreen('trustinfacts.tasks.detail', '7'), '/task/7');
  });

  test('sin id, una pantalla de detalle cae en su listado', () {
    expect(routeForGatewayScreen('trustinfacts.budgets.detail', null), '/budgets');
    expect(routeForGatewayScreen('trustinfacts.sales.detail', null), '/sales');
  });

  test('una pantalla desconocida no navega, no revienta', () {
    expect(routeForGatewayScreen('trustinfacts.payroll.list', null), isNull);
  });
}
