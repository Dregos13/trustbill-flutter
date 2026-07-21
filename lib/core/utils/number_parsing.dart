double parseLocalizedDecimal(String value, {double fallback = 0}) {
  var normalized = value.trim().replaceAll(RegExp(r'\s+'), '');
  if (normalized.isEmpty) return fallback;

  final comma = normalized.lastIndexOf(',');
  final dot = normalized.lastIndexOf('.');
  if (comma >= 0 && dot >= 0) {
    final decimalSeparator = comma > dot ? ',' : '.';
    final thousandsSeparator = decimalSeparator == ',' ? '.' : ',';
    normalized = normalized
        .replaceAll(thousandsSeparator, '')
        .replaceAll(decimalSeparator, '.');
  } else if (comma >= 0) {
    normalized = normalized.replaceAll('.', '').replaceAll(',', '.');
  } else if (RegExp(r'^\d{1,3}(\.\d{3})+$').hasMatch(normalized)) {
    normalized = normalized.replaceAll('.', '');
  }

  return double.tryParse(normalized) ?? fallback;
}
