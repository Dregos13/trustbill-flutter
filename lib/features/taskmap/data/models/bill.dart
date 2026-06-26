/// A line on the related bill (present only in task detail).
class BillLine {
  const BillLine({
    required this.id,
    required this.description,
    required this.quantity,
    required this.total,
  });

  final int id;
  final String description;
  final num quantity;
  final num total;

  factory BillLine.fromJson(Map<String, dynamic> json) => BillLine(
    id: (json['id'] as num).toInt(),
    description: json['description'] as String? ?? '',
    quantity: (json['quantity'] as num?) ?? 0,
    total: (json['total'] as num?) ?? 0,
  );
}

/// Read-only summary of the invoice linked to a task.
/// `total` is a number (the API serializes Prisma.Decimal via `.toNumber()`).
class BillSummary {
  const BillSummary({
    required this.id,
    required this.number,
    required this.total,
    required this.status,
    this.lines = const [],
  });

  final int id;
  final String number;
  final num total;
  final String status;
  final List<BillLine> lines;

  factory BillSummary.fromJson(Map<String, dynamic> json) => BillSummary(
    id: (json['id'] as num).toInt(),
    number: json['number'] as String? ?? '',
    total: (json['total'] as num?) ?? 0,
    status: json['status'] as String? ?? '',
    lines:
        (json['lines'] as List?)
            ?.map((e) => BillLine.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const [],
  );
}
