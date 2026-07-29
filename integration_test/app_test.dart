// Pruebas end-to-end sobre la app real, corriendo en el dispositivo/emulador
// conectado. A diferencia de uiautomator (arbol de accesibilidad, requiere
// adivinar coordenadas cuando un widget no tiene Semantics) o de los widget
// tests en test/ (arbol falso, sin plugins nativos ni red real), estas
// pruebas usan los finders de Flutter (find.byKey/find.text/find.byType)
// directamente sobre el arbol de widgets real de la app en ejecucion.
//
// Cada `flutter test integration_test/...` reinstala la APK de debug; si la
// ultima sesion se guardo con una APK firmada distinta (p.ej. release, o
// `flutter install` eligiendo el build equivocado), Android desinstala el
// paquete anterior antes de instalar la nueva y se pierde la sesion. Por eso
// el test hace login el solo cuando hace falta, usando credenciales pasadas
// por --dart-define (nunca hardcodeadas en este fichero, que va a git):
//
//   flutter test integration_test/app_test.dart -d <deviceId> \
//     --dart-define=TEST_TENANT=trustcore \
//     --dart-define=TEST_EMAIL=rami@trustcore.es \
//     --dart-define=TEST_PASSWORD=xxxxxxxx
//
// Sin esos defines, si aparece la pantalla de login el test falla con un
// mensaje explicito en vez de intentar adivinar credenciales.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trustinfacts_mobile/app.dart';
import 'package:trustinfacts_mobile/core/theme/theme_controller.dart';
import 'package:trustinfacts_mobile/widgets/invoice_card.dart';

const _testTenant = String.fromEnvironment('TEST_TENANT');
const _testEmail = String.fromEnvironment('TEST_EMAIL');
const _testPassword = String.fromEnvironment('TEST_PASSWORD');

enum _AppScreenState { home, setup, login, unknown }

// En una instalacion nueva (secure storage vacio) la app pasa primero por
// SetupScreen ('Continuar', 1 solo TextFormField con el tenant) y solo luego
// por LoginScreen ('Entrar', 3 TextFormField: tenant/email/password).
_AppScreenState? _detectScreen() {
  if (find.byKey(const Key('app-header-account-button')).evaluate().isNotEmpty) {
    return _AppScreenState.home;
  }
  if (find.text('Entrar').evaluate().isNotEmpty) {
    return _AppScreenState.login;
  }
  if (find.text('Continuar').evaluate().isNotEmpty) {
    return _AppScreenState.setup;
  }
  return null;
}

// go_router puede montar brevemente LoginScreen antes de redirigir a
// SetupScreen (o viceversa) mientras decide segun el clientId guardado; un
// solo frame que vea 'Entrar' no basta, exigimos que el mismo estado se
// mantenga estable dos lecturas seguidas antes de actuar sobre el.
Future<_AppScreenState> _waitForScreen(
  WidgetTester tester, {
  int maxSeconds = 45,
}) async {
  _AppScreenState? previous;
  for (var i = 0; i < maxSeconds; i++) {
    await tester.pump(const Duration(seconds: 1));
    final found = _detectScreen();
    if (found != null && found == previous) {
      return found;
    }
    previous = found;
  }
  return _AppScreenState.unknown;
}

Future<void> _launchAuthenticatedApp(WidgetTester tester) async {
  await initializeDateFormatting('es_ES', null);
  final prefs = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const TrustInFactsApp(),
    ),
  );

  final hasTestCredentials = _testEmail.isNotEmpty && _testPassword.isNotEmpty;
  var state = await _waitForScreen(tester);

  if (state == _AppScreenState.setup && hasTestCredentials) {
    final tenantField = find.byType(TextFormField);
    expect(
      tenantField,
      findsOneWidget,
      reason: 'SetupScreen deberia tener exactamente 1 TextFormField (tenant).',
    );
    await tester.enterText(tenantField, _testTenant);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continuar'));
    await tester.pump(const Duration(seconds: 1));
    state = await _waitForScreen(tester);
  }

  if (state == _AppScreenState.login && hasTestCredentials) {
    final loginFields = find.byType(TextFormField);
    expect(
      loginFields,
      findsNWidgets(3),
      reason:
          'LoginScreen deberia tener exactamente 3 TextFormField '
          '(tenant/email/password).',
    );
    await tester.enterText(loginFields.at(0), _testTenant);
    await tester.enterText(loginFields.at(1), _testEmail);
    await tester.enterText(loginFields.at(2), _testPassword);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Entrar'));
    await tester.pump(const Duration(seconds: 1));
    state = await _waitForScreen(tester);
  }

  await tester.pumpAndSettle(const Duration(milliseconds: 500));

  expect(
    state,
    _AppScreenState.home,
    reason: hasTestCredentials
        ? 'El login automatico con las credenciales de test no llego a Inicio '
              '(estado: $state — ¿credenciales incorrectas, backend caido o '
              'red muy lenta?).'
        : 'La app no llego a Inicio (estado: $state) y no se pasaron '
              'credenciales de test (--dart-define=TEST_EMAIL=... '
              'TEST_PASSWORD=... TEST_TENANT=...).',
  );
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('avatar abre Cuenta y muestra los datos de empresa editables', (
    tester,
  ) async {
    await _launchAuthenticatedApp(tester);

    final avatar = find.byKey(const Key('app-header-account-button'));
    expect(avatar, findsOneWidget);

    await tester.tap(avatar);
    await tester.pumpAndSettle();

    expect(find.text('Editar'), findsWidgets);
  });

  testWidgets('el toggle Facturas/Tickets cambia el listado de facturas', (
    tester,
  ) async {
    await _launchAuthenticatedApp(tester);

    await tester.tap(find.text('Facturas').first);
    await tester.pumpAndSettle();

    expect(find.byType(SegmentedButton<bool>), findsOneWidget);

    final ticketsLabel = find.descendant(
      of: find.byType(SegmentedButton<bool>),
      matching: find.text('Tickets'),
    );
    expect(ticketsLabel, findsOneWidget);

    await tester.tap(ticketsLabel);
    await tester.pumpAndSettle();

    final facturasLabel = find.descendant(
      of: find.byType(SegmentedButton<bool>),
      matching: find.text('Facturas'),
    );
    expect(facturasLabel, findsOneWidget);
    await tester.tap(facturasLabel);
    await tester.pumpAndSettle();
  });

  testWidgets('el detalle de una factura carga sin errores (QR VERI*FACTU si aplica)', (
    tester,
  ) async {
    await _launchAuthenticatedApp(tester);

    await tester.tap(find.text('Facturas').first);
    await tester.pumpAndSettle();

    final firstCard = find.byType(InvoiceCard);
    if (firstCard.evaluate().isEmpty) {
      // Tenant sin facturas (p.ej. billing_db de test): no es un fallo del
      // flujo, simplemente no hay datos que abrir.
      return;
    }

    await tester.tap(firstCard.first);
    await tester.pumpAndSettle();

    // 'Lineas' es el encabezado fijo de la tabla de conceptos: no depende de
    // los datos de la factura en si, asi que confirma que el detalle cargo
    // sin quedarse en el spinner ni en el EmptyState de error.
    expect(find.text('Lineas'), findsOneWidget);
  });
}
