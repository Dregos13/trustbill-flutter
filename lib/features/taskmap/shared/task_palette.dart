import 'package:flutter/material.dart';

import '../data/models/field_task.dart';
import '../data/models/task_status.dart';

/// Color de un bloque de agenda.
///
/// El color dice **de quién** es la tarea, no en qué estado está. Con el color
/// por estado, un día normal —todo pendiente— salía entero del mismo amarillo y
/// no se distinguía nada, que es justo el problema que había que resolver.
///
/// El estado pasa a ser el *acabado*: relleno más sólido si está en curso,
/// atenuado y tachado si ya está hecha o cancelada. Así se leen las dos cosas
/// sin que compitan, porque usan canales distintos (tono contra intensidad).

/// Doce tonos separados en la rueda, con saturación y luminosidad parejas para
/// que ninguno pese más que otro. Elegidos para verse sobre fondo oscuro y
/// claro; el bloque siempre pinta el relleno translúcido y el borde al 70%.
const List<Color> kClientPalette = [
  Color(0xFF38BDF8), // azul cielo
  Color(0xFFA78BFA), // violeta
  Color(0xFFF472B6), // rosa
  Color(0xFFFB923C), // naranja
  Color(0xFF34D399), // verde menta
  Color(0xFF60A5FA), // azul
  Color(0xFFFBBF24), // ámbar
  Color(0xFF4ADE80), // verde
  Color(0xFFF87171), // rojo suave
  Color(0xFF22D3EE), // cian
  Color(0xFFC084FC), // lila
  Color(0xFF2DD4BF), // turquesa
];

/// Gris para las tareas que no son de ningún cliente ("ir a Hacienda").
/// No entra en la paleta a propósito: la ausencia de cliente debe *verse* como
/// ausencia, no como un cliente más.
const Color kNoClientColor = Color(0xFF94A3B8);

/// Color estable de un cliente a partir de su id.
///
/// El mismo cliente sale siempre del mismo color, hoy y dentro de un mes, sin
/// guardar nada: es el id contra el tamaño de la paleta. No se usa `hashCode`
/// del nombre porque cambiaría al renombrar al cliente.
Color clientColor(int? clientId) {
  if (clientId == null) return kNoClientColor;
  return kClientPalette[clientId.abs() % kClientPalette.length];
}

/// Cómo se pinta un bloque: color base y tratamiento según el estado.
class TaskChipStyle {
  const TaskChipStyle({
    required this.base,
    required this.fillOpacity,
    required this.borderOpacity,
    required this.textOpacity,
    required this.strikeThrough,
    this.check = false,
  });

  final Color base;
  final double fillOpacity;
  final double borderOpacity;
  final double textOpacity;
  final bool strikeThrough;

  /// Marca "✓" delante del título. Es como se señala lo ya hecho sin apagarlo.
  final bool check;

  Color get fill => base.withValues(alpha: fillOpacity);
  Color get border => base.withValues(alpha: borderOpacity);
  Color get text => base.withValues(alpha: textOpacity);
}

TaskChipStyle chipStyleFor(FieldTask task) {
  final base = clientColor(task.client?.id);
  return switch (task.status) {
    // En curso: lo que está pasando ahora mismo pesa más que el resto.
    TaskStatus.inProgress => TaskChipStyle(
      base: base,
      fillOpacity: 0.42,
      borderOpacity: 1.0,
      textOpacity: 1.0,
      strikeThrough: false,
    ),
    TaskStatus.pending => TaskChipStyle(
      base: base,
      fillOpacity: 0.20,
      borderOpacity: 0.75,
      textOpacity: 1.0,
      strikeThrough: false,
    ),
    // Hecha: se distingue, pero SIGUE LEYÉNDOSE. Lo que ya has hecho sigue
    // siendo información útil —dónde estuviste, cuánto te llevó— y apagarlo
    // al 10% equivale a borrarlo del calendario. Se marca con un ✓ y un
    // relleno algo menor, no bajando el texto hasta que no se ve.
    TaskStatus.done => TaskChipStyle(
      base: base,
      fillOpacity: 0.16,
      borderOpacity: 0.55,
      textOpacity: 0.92,
      strikeThrough: false,
      check: true,
    ),
    // Cancelada sí se aparta: eso NO llegó a pasar, y ocupa un hueco que en
    // realidad estaba libre. Aun así, legible.
    TaskStatus.cancelled => TaskChipStyle(
      base: base,
      fillOpacity: 0.08,
      borderOpacity: 0.35,
      textOpacity: 0.60,
      strikeThrough: true,
    ),
  };
}
