import 'package:intl/intl.dart';

String formatDate(String? iso) {
  if (iso == null || iso.isEmpty) return '-';
  try {
    final date = DateTime.parse(iso);
    return DateFormat('dd/MM/yyyy', 'es_ES').format(date);
  } catch (_) {
    return '-';
  }
}

String formatIsoDateForDisplay(String? iso) {
  if (iso == null || iso.isEmpty) return '';
  final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})').firstMatch(iso);
  if (match != null) {
    return '${match.group(3)}/${match.group(2)}/${match.group(1)}';
  }
  try {
    final date = DateTime.parse(iso);
    return DateFormat('dd/MM/yyyy', 'es_ES').format(date);
  } catch (_) {
    return '';
  }
}

String parseDisplayDateToApiIso(String display) {
  try {
    final parts = display.trim().split('/');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime.utc(year, month, day, 12).toIso8601String();
    }
  } catch (_) {}

  final now = DateTime.now();
  return DateTime.utc(now.year, now.month, now.day, 12).toIso8601String();
}

String formatDateTime(String? iso) {
  if (iso == null || iso.isEmpty) return '-';
  try {
    final date = DateTime.parse(iso);
    return DateFormat('dd/MM/yyyy HH:mm', 'es_ES').format(date);
  } catch (_) {
    return '-';
  }
}
