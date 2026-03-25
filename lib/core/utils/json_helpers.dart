/// Safely converts a JSON value (num or String) to double.
/// The API may return amounts as int, double, or String.
double toDouble(dynamic v) {
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v) ?? 0.0;
  return 0.0;
}
