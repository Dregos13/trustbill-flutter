/// Decimales que admite la cantidad de una linea.
///
/// La columna es `numeric(14,3)` en toda la base —lineas de documento, de
/// presupuesto, de venta y movimientos de inventario— y el escritorio valida
/// con este mismo tope en `packages/shared/src/index.ts::MAX_QUANTITY_DECIMALS`.
/// Lo que no quepa lo redondearia Postgres en silencio.
const int kMaxQuantityDecimals = 3;

/// ¿Cabe el valor en `numeric(14,3)` sin perder nada?
///
/// Se compara con tolerancia porque 1.1 * 1000 da 1100.0000000000002 en coma
/// flotante. Mismo criterio que `hasValidQuantityPrecision` del escritorio.
bool hasValidQuantityPrecision(double value) {
  if (!value.isFinite) return false;
  final scaled = value * 1000;
  return (scaled - scaled.roundToDouble()).abs() < 1e-6;
}

/// Cantidad tal como se le enseña a una persona: sin decimales cuando es
/// entera ("2"), y con coma cuando no ("2,5", "12,75").
String formatQuantity(double value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  }
  var text = value.toStringAsFixed(kMaxQuantityDecimals);
  text = text.replaceFirst(RegExp(r'0+$'), '');
  text = text.replaceFirst(RegExp(r'\.$'), '');
  return text.replaceAll('.', ',');
}

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
