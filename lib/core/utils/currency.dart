import 'package:intl/intl.dart';

final _currencyFormat = NumberFormat.currency(
  locale: 'es_ES',
  symbol: '\u20AC',
  decimalDigits: 2,
);

String formatCurrency(double value) => _currencyFormat.format(value);

String formatAmount(double value) =>
    NumberFormat('#,##0.00', 'es_ES').format(value);
