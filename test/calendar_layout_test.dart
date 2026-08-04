import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/features/taskmap/agenda/calendar_week_view.dart';
import 'package:trustinfacts_mobile/features/taskmap/data/models/field_task.dart';
import 'package:trustinfacts_mobile/features/taskmap/data/models/task_status.dart';

/// Reparto de las tareas del día en columnas.
///
/// Hasta la migración de agenda todos los bloques medían una hora fija porque
/// no había duración, y dos tareas a la misma hora se tapaban. Lo que se
/// comprueba aquí es que la altura sale de la duración real y que el ancho
/// solo se parte donde de verdad hay solape.

FieldTask _tarea(String titulo, String hora, int minutos) => FieldTask(
  id: titulo.hashCode,
  title: titulo,
  status: TaskStatus.pending,
  scheduledAt: DateTime.parse('2026-08-05T$hora:00'),
  durationMinutes: minutos,
);

void main() {
  test('la altura sale de la duración, no de una hora fija', () {
    final placed = layoutDayTasks([
      _tarea('media hora', '09:00', 30),
      _tarea('dos horas', '11:00', 120),
    ]);

    // Una hora son 56 px: 30 min -> 28, 120 min -> 112.
    expect(placed[0].height, closeTo(28, 0.01));
    expect(placed[1].height, closeTo(112, 0.01));
  });

  test('una tarea muy corta no se pinta ilegible', () {
    final placed = layoutDayTasks([_tarea('un cuarto', '09:00', 15)]);
    // 15 min serían 14 px, donde no cabe ni una línea: se sube al mínimo.
    expect(placed.single.height, 22.0);
  });

  test('la posición vertical respeta los minutos', () {
    final placed = layoutDayTasks([_tarea('y media', '09:30', 60)]);
    expect(placed.single.top, closeTo(9.5 * 56, 0.01));
  });

  test('sin solape cada tarea ocupa el ancho entero', () {
    final placed = layoutDayTasks([
      _tarea('primera', '09:00', 60),
      _tarea('segunda', '10:00', 60),
    ]);
    expect(placed.every((p) => p.columns == 1), isTrue);
    expect(placed.every((p) => p.column == 0), isTrue);
  });

  test('dos que se pisan se reparten el ancho', () {
    final placed = layoutDayTasks([
      _tarea('larga', '09:00', 120),
      _tarea('dentro', '09:30', 30),
    ]);
    expect(placed.every((p) => p.columns == 2), isTrue);
    expect(placed.map((p) => p.column).toSet(), {0, 1});
  });

  test('la columna se reutiliza cuando la anterior ya ha terminado', () {
    // A 09:00-11:00 se solapa con B y con C, pero B (09:30-10:00) termina
    // antes de que empiece C (10:00-10:30): C cabe en la columna de B.
    final placed = layoutDayTasks([
      _tarea('A', '09:00', 120),
      _tarea('B', '09:30', 30),
      _tarea('C', '10:00', 30),
    ]);
    final porTitulo = {for (final p in placed) p.task.title: p};

    expect(porTitulo['A']!.column, 0);
    expect(porTitulo['B']!.column, 1);
    // Sin reutilizar columnas esto seria 2 y el dia se estrecharia sin motivo.
    expect(porTitulo['C']!.column, 1);
    expect(placed.every((p) => p.columns == 2), isTrue);
  });

  test('tareas pegadas no cuentan como solape', () {
    // 09:00-10:00 y 10:00-11:00 se tocan pero no se pisan.
    final placed = layoutDayTasks([
      _tarea('antes', '09:00', 60),
      _tarea('despues', '10:00', 60),
    ]);
    expect(placed.every((p) => p.columns == 1), isTrue);
  });

  test('las tareas sin hora no entran en la rejilla', () {
    final placed = layoutDayTasks([
      FieldTask(
        id: 1,
        title: 'sin fecha',
        status: TaskStatus.pending,
        durationMinutes: 60,
      ),
      _tarea('con fecha', '09:00', 60),
    ]);
    expect(placed.length, 1);
    expect(placed.single.task.title, 'con fecha');
  });

  test('un dia vacio no revienta', () {
    expect(layoutDayTasks(const []), isEmpty);
  });

  test('la duracion por defecto es una hora', () {
    // Si el backend no manda durationMinutes (version anterior), el bloque
    // tiene que verse igual que antes de la migracion.
    final tarea = FieldTask.fromJson({
      'id': 1,
      'title': 'sin duracion',
      'status': 'PENDING',
      'client': null,
      'scheduledAt': '2026-08-05T09:00:00',
    });
    expect(tarea.durationMinutes, 60);
    expect(layoutDayTasks([tarea]).single.height, closeTo(56, 0.01));
  });

  test('una tarea sin cliente no revienta al leerla', () {
    // clientId paso a opcional: el JSON puede traer client: null.
    final tarea = FieldTask.fromJson({
      'id': 7,
      'title': 'Ir a Hacienda',
      'status': 'PENDING',
      'client': null,
      'scheduledAt': '2026-08-05T09:00:00',
      'durationMinutes': 90,
    });
    expect(tarea.client, isNull);
    expect(tarea.durationMinutes, 90);
  });
}
