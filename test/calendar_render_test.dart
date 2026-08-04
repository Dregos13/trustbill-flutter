import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/features/taskmap/agenda/calendar_week_view.dart';
import 'package:trustinfacts_mobile/features/taskmap/data/models/field_task.dart';
import 'package:trustinfacts_mobile/features/taskmap/data/models/task_status.dart';

/// El calendario montado de verdad, no la funcion de reparto.
///
/// calendar_layout_test.dart comprueba que `layoutDayTasks` calcula bien; esto
/// comprueba que lo calculado LLEGA A PINTARSE. La diferencia no es teorica:
/// el reparto estaba perfecto y el calendario salia vacio porque los bloques
/// colgaban de un Stack cuyos hijos eran todos Positioned. Un Stack asi no
/// tiene de quien sacar su tamaño, con constraints holgadas se encoge a cero
/// y sus hijos desaparecen. Sin error, sin excepcion, sin nada en el log.

FieldTask _tarea(int id, String titulo, DateTime cuando, int minutos) => FieldTask(
  id: id,
  title: titulo,
  status: TaskStatus.pending,
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
  // Hoy, para que caigan en la semana que el calendario abre por defecto.
  final hoy = DateTime.now();
  DateTime aLas(int hora, [int minuto = 0]) =>
      DateTime(hoy.year, hoy.month, hoy.day, hora, minuto);

  testWidgets('los bloques del dia se pintan en el calendario', (tester) async {
    await _montar(tester, [_tarea(1, 'Revisar caldera', aLas(9), 60)]);

    final bloque = find.byKey(const Key('task-chip-1'));
    expect(
      bloque,
      findsOneWidget,
      reason: 'La tarea no llega a pintarse: la rejilla se ve y el dia sale '
          'vacio (revisar que el Stack de los bloques tenga tamaño).',
    );

    // Y ocupa espacio de verdad, que es lo que fallaba: existir en el arbol
    // no basta si el rectangulo es de area cero.
    final rect = tester.getRect(bloque);
    expect(rect.width, greaterThan(0));
    expect(rect.height, greaterThan(0));
  });

  testWidgets('una tarea larga se pinta mas alta que una corta', (tester) async {
    await _montar(tester, [
      _tarea(1, 'Corta', aLas(9), 30),
      _tarea(2, 'Larga', aLas(12), 120),
    ]);

    final corta = tester.getRect(find.byKey(const Key('task-chip-1')));
    final larga = tester.getRect(find.byKey(const Key('task-chip-2')));
    expect(larga.height, greaterThan(corta.height));
  });

  testWidgets('dos tareas solapadas se pintan lado a lado', (tester) async {
    await _montar(tester, [
      _tarea(1, 'Larga', aLas(9), 120),
      _tarea(2, 'Dentro', aLas(9, 30), 30),
    ]);

    final a = tester.getRect(find.byKey(const Key('task-chip-1')));
    final b = tester.getRect(find.byKey(const Key('task-chip-2')));

    // Se pisan en vertical...
    expect(a.top < b.bottom && b.top < a.bottom, isTrue);
    // ...asi que NO pueden pisarse tambien en horizontal.
    expect(
      a.left < b.right - 1 && b.left < a.right - 1,
      isFalse,
      reason: 'Dos tareas a la misma hora se pintan una encima de otra.',
    );
  });

  testWidgets('una tarea sin cliente se pinta igual', (tester) async {
    // El caso que reventaba la pantalla cuando client era obligatorio.
    await _montar(tester, [
      FieldTask(
        id: 9,
        title: 'Ir a Hacienda',
        status: TaskStatus.pending,
        client: null,
        scheduledAt: aLas(10),
        durationMinutes: 90,
      ),
    ]);
    expect(find.byKey(const Key('task-chip-9')), findsOneWidget);
  });

  testWidgets('un dia sin tareas pinta la rejilla y ningun bloque', (
    tester,
  ) async {
    await _montar(tester, const []);
    expect(find.text('09:00'), findsWidgets);
    expect(find.byKey(const Key('task-chip-1')), findsNothing);
  });
}
