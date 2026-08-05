import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/features/taskmap/agenda/calendar_week_view.dart';
import 'package:trustinfacts_mobile/features/taskmap/data/models/field_task.dart';
import 'package:trustinfacts_mobile/features/taskmap/data/models/task_status.dart';
import 'package:trustinfacts_mobile/features/taskmap/shared/task_palette.dart';

/// Zoom, rango de días y color por cliente.
///
/// El color dice de QUIÉN es la tarea, no en qué estado está: con el color por
/// estado, un día normal salía entero del mismo amarillo. El estado pasa a ser
/// el acabado (intensidad y tachado), que es otro canal y no compite.

FieldTask _tarea(
  int id,
  String titulo,
  DateTime cuando,
  int minutos, {
  int? clienteId,
  TaskStatus estado = TaskStatus.pending,
}) => FieldTask(
  id: id,
  title: titulo,
  status: estado,
  client: clienteId == null
      ? null
      : ClientRef(id: clienteId, name: 'Cliente $clienteId'),
  scheduledAt: cuando,
  durationMinutes: minutos,
);

Future<void> _montar(WidgetTester tester, List<FieldTask> tareas) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: CalendarWeekView(
          tasks: tareas,
          onSlotTap: (_) {},
          onTaskTap: (_) {},
        ),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  final hoy = DateTime.now();
  DateTime aLas(int hora, [int minuto = 0]) =>
      DateTime(hoy.year, hoy.month, hoy.day, hora, minuto);

  group('color por cliente', () {
    test('el mismo cliente da siempre el mismo color', () {
      expect(clientColor(7), clientColor(7));
    });

    test('dos clientes distintos dan colores distintos', () {
      // Con 12 tonos, ids consecutivos nunca colisionan.
      expect(clientColor(3), isNot(clientColor(4)));
    });

    test('sin cliente es gris neutro, no un color de la paleta', () {
      // La ausencia de cliente debe VERSE como ausencia, no como un cliente mas.
      expect(clientColor(null), kNoClientColor);
      expect(kClientPalette, isNot(contains(kNoClientColor)));
    });

    test('el estado cambia el acabado, no el tono', () {
      final pendiente = _tarea(1, 'a', aLas(9), 60, clienteId: 5);
      final hecha = _tarea(
        2,
        'a',
        aLas(9),
        60,
        clienteId: 5,
        estado: TaskStatus.done,
      );

      final ep = chipStyleFor(pendiente);
      final eh = chipStyleFor(hecha);

      expect(ep.base, eh.base, reason: 'el tono es del cliente, no del estado');
      expect(eh.fillOpacity, lessThan(ep.fillOpacity));
    });

    test('una tarea completada SIGUE LEYENDOSE', () {
      // Lo ya hecho sigue siendo información útil: dónde estuviste y cuánto te
      // llevó. La primera versión la dejaba al 10% de relleno y 55% de texto,
      // que sobre fondo oscuro equivale a borrarla del calendario.
      final hecha = chipStyleFor(
        _tarea(1, 'a', aLas(9), 60, clienteId: 5, estado: TaskStatus.done),
      );
      expect(
        hecha.textOpacity,
        greaterThanOrEqualTo(0.85),
        reason: 'el texto de una tarea hecha no se lee',
      );
      expect(hecha.borderOpacity, greaterThanOrEqualTo(0.5));
      // Se marca con un check, no apagándola ni tachándola.
      expect(hecha.check, isTrue);
      expect(hecha.strikeThrough, isFalse);
    });

    test('una cancelada sí se aparta, pero sigue siendo legible', () {
      // Eso NO llegó a pasar y ocupa un hueco que en realidad estaba libre.
      final cancelada = chipStyleFor(
        _tarea(1, 'a', aLas(9), 60, estado: TaskStatus.cancelled),
      );
      final hecha = chipStyleFor(
        _tarea(2, 'a', aLas(9), 60, estado: TaskStatus.done),
      );
      expect(cancelada.textOpacity, lessThan(hecha.textOpacity));
      expect(cancelada.textOpacity, greaterThanOrEqualTo(0.5));
      expect(cancelada.strikeThrough, isTrue);
    });

    test('en curso pesa mas que pendiente', () {
      final enCurso = chipStyleFor(
        _tarea(1, 'a', aLas(9), 60, clienteId: 5, estado: TaskStatus.inProgress),
      );
      final pendiente = chipStyleFor(_tarea(2, 'a', aLas(9), 60, clienteId: 5));
      expect(enCurso.fillOpacity, greaterThan(pendiente.fillOpacity));
    });
  });

  group('zoom', () {
    test('la altura del bloque escala con la altura de hora', () {
      final tarea = [_tarea(1, 'a', aLas(9), 60)];
      final normal = layoutDayTasks(tarea).single.height;
      final ampliado = layoutDayTasks(tarea, hourHeight: 112).single.height;
      expect(ampliado, closeTo(normal * 2, 0.01));
    });

    test('la posicion vertical tambien escala', () {
      final tarea = [_tarea(1, 'a', aLas(10), 60)];
      expect(
        layoutDayTasks(tarea, hourHeight: 112).single.top,
        closeTo(10 * 112, 0.01),
      );
    });

    testWidgets('el boton de zoom agranda los bloques', (tester) async {
      await _montar(tester, [_tarea(1, 'Revisar', aLas(9), 60)]);

      final antes = tester.getRect(find.byKey(const Key('task-chip-1'))).height;
      await tester.tap(find.byKey(const Key('calendar-zoom-in')));
      await tester.pumpAndSettle();
      final despues = tester.getRect(find.byKey(const Key('task-chip-1'))).height;

      expect(despues, greaterThan(antes));
    });

    testWidgets('al ampliar sigues mirando la misma hora', (tester) async {
      // El scroll guarda pixeles, no horas: sin reescalarlo, ampliar te
      // mandaba a la madrugada. Pasó en el movil antes de arreglarlo.
      await _montar(tester, [_tarea(1, 'Revisar', aLas(9), 60)]);

      final scroll = tester.widget<SingleChildScrollView>(
        find.byType(SingleChildScrollView),
      );
      final antes = scroll.controller!.offset;

      await tester.tap(find.byKey(const Key('calendar-zoom-in')));
      await tester.pumpAndSettle();

      final despues = scroll.controller!.offset;
      // Mas alto el pixel por hora => mas offset para la misma hora.
      expect(despues, greaterThan(antes));
      // Y la hora que se mira es la misma dentro de un margen de minutos.
      expect(antes / kDefaultHourHeight, closeTo(despues / (kDefaultHourHeight + 32), 0.1));
    });
  });

  group('rango de dias', () {
    testWidgets('la vista de dia da mas ancho al bloque que la de semana', (
      tester,
    ) async {
      await _montar(tester, [_tarea(1, 'Revisar caldera', aLas(9), 60)]);

      final enSemana = tester.getRect(find.byKey(const Key('task-chip-1'))).width;

      await tester.tap(find.byKey(const Key('calendar-span-1')));
      await tester.pumpAndSettle();

      final enDia = tester.getRect(find.byKey(const Key('task-chip-1'))).width;
      // Es el arreglo de fondo: el titulo no cabia por ANCHO, no por alto.
      expect(enDia, greaterThan(enSemana * 3));
    });

    testWidgets('cambiar de rango no pierde la tarea de hoy', (tester) async {
      await _montar(tester, [_tarea(1, 'Revisar', aLas(9), 60)]);

      for (final dias in [3, 1, 7]) {
        await tester.tap(find.byKey(Key('calendar-span-$dias')));
        await tester.pumpAndSettle();
        expect(
          find.byKey(const Key('task-chip-1')),
          findsOneWidget,
          reason: 'la tarea de hoy desaparece con $dias dias en pantalla',
        );
      }
    });
  });
}
