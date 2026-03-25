import 'package:intl/intl.dart';

String formatDate(String iso) {
  final date = DateTime.parse(iso);
  return DateFormat('dd/MM/yyyy', 'es_ES').format(date);
}

String formatDateTime(String iso) {
  final date = DateTime.parse(iso);
  return DateFormat('dd/MM/yyyy HH:mm', 'es_ES').format(date);
}
