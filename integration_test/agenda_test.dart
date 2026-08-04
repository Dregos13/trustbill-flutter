// El calendario de la agenda, sobre la app real y midiendo geometria de
// verdad. Los tests de test/calendar_layout_test.dart comprueban el reparto en
// columnas como funcion pura; esto comprueba lo otro: que lo que se PINTA en
// pantalla tiene la altura y la posicion que deberia.
//
// Es la diferencia que costo el fallo del cliente nulo: la logica estaba bien
// y la pantalla reventaba igual.
//
//   flutter test integration_test/agenda_test.dart -d <deviceId> \
//     --dart-define=TEST_TENANT=trustcore \
//     --dart-define=TEST_EMAIL=... \
//     --dart-define=TEST_PASSWORD=...
//
// Necesita tareas programadas en la empresa activa para tener algo que medir.
// Si no hay ninguna en la semana visible, los casos que necesitan datos se
// saltan en vez de fallar: un tenant vacio no es un fallo del calendario.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trustinfacts_mobile/app.dart';
import 'package:trustinfacts_mobile/core/theme/theme_controller.dart';

const _testTenant = String.fromEnvironment('TEST_TENANT');
const _testEmail = String.fromEnvironment('TEST_EMAIL');
const _testPassword = String.fromEnvironment('TEST_PASSWORD');

Future<void> _launchAuthenticatedApp(WidgetTester tester) async {
  await initializeDateFormatting('es_ES', null);
  final prefs = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const TrustInFactsApp(),
    ),
  );

  final avatar = find.byKey(const Key('app-header-account-button'));
  for (var i = 0; i < 45; i++) {
    await tester.pump(const Duration(seconds: 1));
    if (avatar.evaluate().isNotEmpty) break;

    if (find.text('Continuar').evaluate().isNotEmpty &&
        _testTenant.isNotEmpty) {
      await tester.enterText(find.byType(TextFormField), _testTenant);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continuar'));
      await tester.pump(const Duration(seconds: 1));
    } else if (find.text('Entrar').evaluate().isNotEmpty &&
        _testEmail.isNotEmpty) {
      final campos = find.byType(TextFormField);
      await tester.enterText(campos.at(0), _testTenant);
      await tester.enterText(campos.at(1), _testEmail);
      await tester.enterText(campos.at(2), _testPassword);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Entrar'));
      await tester.pump(const Duration(seconds: 1));
    }
  }

  expect(
    avatar,
    findsOneWidget,
    reason: _testEmail.isEmpty
        ? 'La app no llego a Inicio y no se pasaron credenciales '
              '(--dart-define=TEST_EMAIL=... TEST_PASSWORD=... TEST_TENANT=...).'
        : 'El login automatico no llego a Inicio: credenciales, backend o red.',
  );
}

/// Más → Tareas → Calendario.
Future<void> _abrirCalendario(WidgetTester tester) async {
  await tester.tap(find.text('Más').last);
  await tester.pumpAndSettle();

  await tester.tap(find.text('Tareas').last);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await tester.tap(find.text('Calendario'));
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

/// Rectangulos de los bloques pintados, por su `Key('task-chip-<id>')`.
Map<String, Rect> _bloques(WidgetTester tester) {
  final rects = <String, Rect>{};
  for (final element in find.byType(Positioned).evaluate()) {
    final key = element.widget.key;
    if (key is ValueKey<String> && key.value.startsWith('task-chip-')) {
      rects[key.value] = tester.getRect(find.byKey(key));
    }
  }
  return rects;
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('el calendario abre y pinta la rejilla horaria', (tester) async {
    await _launchAuthenticatedApp(tester);
    await _abrirCalendario(tester);

    // Las etiquetas de hora son fijas, no dependen de que haya tareas.
    expect(find.text('09:00'), findsWidgets);
    expect(find.text('13:00'), findsWidgets);
  });

  testWidgets('la altura del bloque es proporcional a su duracion', (
    tester,
  ) async {
    await _launchAuthenticatedApp(tester);
    await _abrirCalendario(tester);

    final bloques = _bloques(tester);
    if (bloques.length < 2) return; // semana sin datos suficientes

    final alturas = bloques.values.map((r) => r.height).toList()..sort();
    // Con duraciones distintas no pueden salir todos iguales, que es
    // exactamente lo que pasaba antes: todos median una hora fija.
    expect(
      alturas.first,
      lessThan(alturas.last),
      reason: 'Todos los bloques miden lo mismo: la duracion no se esta '
          'usando para calcular la altura.',
    );
    // Y ninguno puede quedar por debajo del minimo legible.
    expect(alturas.first, greaterThanOrEqualTo(20.0));
  });

  testWidgets('dos bloques que se solapan no se tapan', (tester) async {
    await _launchAuthenticatedApp(tester);
    await _abrirCalendario(tester);

    final bloques = _bloques(tester).values.toList();
    if (bloques.length < 2) return;

    // Si dos bloques se pisan en vertical, tienen que estar en columnas
    // distintas: sus rectangulos no pueden solaparse tambien en horizontal.
    for (var i = 0; i < bloques.length; i++) {
      for (var j = i + 1; j < bloques.length; j++) {
        final a = bloques[i];
        final b = bloques[j];
        final seSolapanEnVertical =
            a.top < b.bottom && b.top < a.bottom;
        if (!seSolapanEnVertical) continue;

        final seSolapanEnHorizontal =
            a.left < b.right - 1 && b.left < a.right - 1;
        expect(
          seSolapanEnHorizontal,
          isFalse,
          reason: 'Dos tareas a la misma hora se estan pintando encima: '
              '$a y $b.',
        );
      }
    }
  });

  testWidgets('ningun bloque se sale de su columna del dia', (tester) async {
    await _launchAuthenticatedApp(tester);
    await _abrirCalendario(tester);

    final bloques = _bloques(tester).values.toList();
    if (bloques.isEmpty) return;

    final ancho = tester.view.physicalSize.width / tester.view.devicePixelRatio;
    for (final r in bloques) {
      expect(r.left, greaterThanOrEqualTo(0));
      expect(
        r.right,
        lessThanOrEqualTo(ancho + 1),
        reason: 'Un bloque se sale de la pantalla: $r',
      );
    }
  });
}
