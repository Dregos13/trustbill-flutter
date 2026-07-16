import 'package:flutter/material.dart';

import 'tm_type.dart';

/// Money rendered with tabular figures and es-ES grouping (1.234,50 €).
class MoneyText extends StatelessWidget {
  const MoneyText(this.amount, {super.key, this.style, this.symbol = '€'});

  final num? amount;
  final TextStyle? style;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Text(format(amount, symbol: symbol), style: style ?? TmType.money(context));
  }

  static String format(num? amount, {String symbol = '€'}) {
    if (amount == null) return '—';
    final fixed = amount.toDouble().toStringAsFixed(2);
    final negative = fixed.startsWith('-');
    final unsigned = negative ? fixed.substring(1) : fixed;
    final parts = unsigned.split('.');
    final digits = parts[0];
    final decimals = parts[1];

    final grouped = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) grouped.write('.');
      grouped.write(digits[i]);
    }
    return '${negative ? '-' : ''}$grouped,$decimals $symbol';
  }
}
