/// Safely converts a JSON num (int or double) to double.
/// json_serializable fails when API returns `0` instead of `0.0`.
double toDouble(dynamic v) => (v as num).toDouble();
