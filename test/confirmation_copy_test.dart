import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/features/assistant/assistant_provider.dart';
import 'package:trustinfacts_mobile/features/assistant/assistant_screen.dart';
import 'package:trustinfacts_mobile/features/assistant/confirmation_copy.dart';

/// Tarjeta de confirmacion del asistente.
///
/// Esto existe por un fallo real: la tarjeta era un binario
/// (`isExpense ? gasto : factura`), asi que al confirmar una TAREA el boton
/// decia "Si, crear factura". Los cobros tenian el mismo problema, y la
/// cabecera de resuelto mandaba al usuario a buscar la tarea en la bandeja de
/// borradores, donde nunca estuvo.
///
/// Los tres primeros tests son el port de `confirmationCopy.test.ts` de la web.
/// Los de widget son la parte que alli falta: comprueban que la tabla LLEGA A
/// PINTARSE, que es donde estaba el fallo — una tabla correcta que la tarjeta
/// ignora no arregla nada.

/// Tools de escritura que el gateway puede mandar a confirmar. Es la lista de
/// `requires_confirmation=True` en trustcore-ai/app/tools/*.py.
///
/// Si se anade una tool de escritura nueva y no se anade su texto aqui, este
/// test falla — que es justo el aviso que falto la primera vez.
const _operacionesDelGateway = [
  'create_invoice_draft',
  'create_expense_draft',
  'register_payment',
  'create_task',
  'reschedule_task',
  'set_task_status',
];

PendingConfirmationView _confirmacion({
  required String operation,
  Map<String, String> summary = const {},
  ConfirmationUiStatus status = ConfirmationUiStatus.pending,
  String? resultLine,
}) {
  return PendingConfirmationView(
    id: 'conf-1',
    operation: operation,
    summary: summary,
    expiresAt: DateTime(2030, 1, 1),
    status: status,
    resultLine: resultLine,
  );
}

Future<void> _montar(
  WidgetTester tester,
  PendingConfirmationView confirmacion,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: ConfirmationCard(
            confirmation: confirmacion,
            onConfirm: (_) {},
            onCancel: (_) {},
          ),
        ),
      ),
    ),
  );
}

void main() {
  test('toda operacion de escritura del gateway tiene su texto', () {
    for (final operacion in _operacionesDelGateway) {
      expect(
        confirmationCopyByOperation[operacion],
        isNotNull,
        reason:
            'falta el texto de confirmacion para "$operacion": la tarjeta lo '
            'anunciaria con el texto generico',
      );
    }
  });

  test('ninguna operacion se anuncia como algo que no es', () {
    // El fallo concreto: una tarea con el boton de crear factura.
    const prohibido = <String, List<String>>{
      'create_task': ['factura', 'gasto', 'cobro'],
      'reschedule_task': ['factura', 'gasto', 'cobro'],
      'set_task_status': ['factura', 'gasto', 'cobro'],
      'register_payment': ['factura', 'gasto', 'tarea'],
      'create_expense_draft': ['factura', 'tarea', 'cobro'],
      'create_invoice_draft': ['gasto', 'tarea', 'cobro'],
    };

    prohibido.forEach((operacion, palabras) {
      final copy = confirmationCopyByOperation[operacion]!;
      final texto = '${copy.question} ${copy.confirm} ${copy.done} ${copy.thing}'
          .toLowerCase();
      for (final palabra in palabras) {
        expect(
          texto.contains(palabra),
          isFalse,
          reason: '"$operacion" menciona "$palabra": $texto',
        );
      }
    });
  });

  test('una operacion desconocida cae al texto generico, no a factura', () {
    // La app instalada no se actualiza sola: el gateway puede desplegar una
    // tool nueva antes. Es preferible un texto soso a que la app afirme que va
    // a crear algo que no va a crear.
    final copy = confirmationCopyFor('operacion_del_futuro');
    expect(copy, same(genericConfirmationCopy));
    expect(copy.confirm.toLowerCase().contains('factura'), isFalse);
  });

  test('solo los borradores dicen que se guardan en borradores', () {
    expect(confirmationCopyByOperation['create_invoice_draft']!.savesToDrafts, isTrue);
    expect(confirmationCopyByOperation['create_expense_draft']!.savesToDrafts, isTrue);
    expect(confirmationCopyByOperation['register_payment']!.savesToDrafts, isFalse);
    expect(confirmationCopyByOperation['create_task']!.savesToDrafts, isFalse);
  });

  test('el proveedor solo aparece en los gastos', () {
    expect(confirmationCopyByOperation['create_expense_draft']!.partyLabel, 'Proveedor');
    expect(confirmationCopyByOperation['create_invoice_draft']!.partyLabel, 'Cliente');
    expect(confirmationCopyByOperation['create_task']!.partyLabel, 'Cliente');
  });

  testWidgets('la tarjeta de una tarea no menciona facturas', (tester) async {
    await _montar(
      tester,
      _confirmacion(
        operation: 'create_task',
        summary: const {
          'task': 'Revisar el cuadro electrico',
          'when': '12/03/2030 10:00',
          'duration': '1 h',
          'client': 'Cliente Ejemplo S.L.',
        },
      ),
    );

    expect(find.text('¿Crear esta tarea?'), findsOneWidget);
    expect(find.text('Sí, crear tarea'), findsOneWidget);
    // El fallo original, en su forma exacta.
    expect(find.textContaining('factura', findRichText: true), findsNothing);
    expect(find.textContaining('Factura', findRichText: true), findsNothing);
  });

  testWidgets('las claves del resumen se pintan traducidas', (tester) async {
    await _montar(
      tester,
      _confirmacion(
        operation: 'create_task',
        summary: const {
          'task': 'Revisar el cuadro electrico',
          'when': '12/03/2030 10:00',
          'duration': '1 h',
          'client': 'Cliente Ejemplo S.L.',
        },
      ),
    );

    expect(find.text('Tarea'), findsOneWidget);
    expect(find.text('Cuándo'), findsOneWidget);
    expect(find.text('Duración'), findsOneWidget);
    expect(find.text('Cliente'), findsOneWidget);
    // Sin etiqueta, el usuario leia la clave del gateway en crudo.
    expect(find.text('when'), findsNothing);
    expect(find.text('duration'), findsNothing);
  });

  testWidgets('una tarea creada no dice que este en los borradores', (
    tester,
  ) async {
    await _montar(
      tester,
      _confirmacion(
        operation: 'create_task',
        status: ConfirmationUiStatus.confirmed,
      ),
    );

    expect(find.text('Tarea creada'), findsOneWidget);
    // Decirlo mandaria al usuario a buscar donde no hay nada.
    expect(find.textContaining('borradores'), findsNothing);
  });

  testWidgets('una factura creada si dice que esta en los borradores', (
    tester,
  ) async {
    await _montar(
      tester,
      _confirmacion(
        operation: 'create_invoice_draft',
        status: ConfirmationUiStatus.confirmed,
      ),
    );

    expect(find.text('Factura creada'), findsOneWidget);
    expect(find.textContaining('borradores'), findsOneWidget);
  });

  testWidgets('una etiqueta no se parte en vertical por un valor largo', (
    tester,
  ) async {
    // Visto en el movil: la fila "Lineas" de un borrador de factura salia
    // "L / i / n / e / a / s", una letra por renglon. El valor era un Text sin
    // restringir, se quedaba con todo el ancho y al Expanded de la etiqueta le
    // sobraban dos pixeles.
    await _montar(
      tester,
      _confirmacion(
        operation: 'create_invoice_draft',
        summary: const {
          'customer': 'Cliente Ejemplo S.L.',
          'lines': 'Consultoría: 5 horas × 100,00 € · Desplazamiento: '
              '1 unidad × 40,00 €',
          'subtotal': '540,00 €',
          'total': '561,60 €',
        },
      ),
    );

    // Una linea a 15px mide ~21px de alto; partida en letras pasaba de 100.
    expect(tester.getSize(find.text('Líneas')).height, lessThan(40));
    // Y el valor sigue visible entero, repartiendo el ancho en vez de robarlo.
    expect(find.textContaining('Consultoría: 5 horas'), findsOneWidget);
  });

  testWidgets('una operacion desconocida no se pinta como factura', (
    tester,
  ) async {
    await _montar(tester, _confirmacion(operation: 'crear_presupuesto'));

    expect(find.text('¿Confirmar esta operación?'), findsOneWidget);
    expect(find.text('Sí, confirmar'), findsOneWidget);
    expect(find.textContaining('factura', findRichText: true), findsNothing);
  });
}
