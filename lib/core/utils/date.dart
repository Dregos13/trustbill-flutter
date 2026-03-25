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

String formatDateTime(String? iso) {
  if (iso == null || iso.isEmpty) return '-';
  try {
    final date = DateTime.parse(iso);
    return DateFormat('dd/MM/yyyy HH:mm', 'es_ES').format(date);
  } catch (_) {
    return '-';
  }
}
