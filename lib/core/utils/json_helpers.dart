/// Safely converts a JSON value (num or String) to double.
/// The API may return amounts as int, double, or String.
double toDouble(dynamic v) {
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v) ?? 0.0;
  return 0.0;
}

/// Like [toDouble] but preserves null (for optional decimal fields).
double? toDoubleN(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}
