const _monthsEs = [
  'ene', 'feb', 'mar', 'abr', 'may', 'jun',
  'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
];

String _two(int n) => n.toString().padLeft(2, '0');

/// "20 jun" (local time).
String formatDay(DateTime date) {
  final d = date.toLocal();
  return '${d.day} ${_monthsEs[d.month - 1]}';
}

/// "20 jun · 09:00" (local time).
String formatDayTime(DateTime date) {
  final d = date.toLocal();
  return '${formatDay(d)} · ${_two(d.hour)}:${_two(d.minute)}';
}
