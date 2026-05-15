import '../utils/json_helpers.dart';

class TaxReturnListResponse {
  final List<TaxReturnListItem> items;
  final int total;
  final int limit;
  final int offset;
  final TaxReturnSummary summary;

  const TaxReturnListResponse({
    required this.items,
    required this.total,
    required this.limit,
    required this.offset,
    required this.summary,
  });

  factory TaxReturnListResponse.fromJson(Map<String, dynamic> json) {
    return TaxReturnListResponse(
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => TaxReturnListItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int? ?? 0,
      limit: json['limit'] as int? ?? 0,
      offset: json['offset'] as int? ?? 0,
      summary: TaxReturnSummary.fromJson(
        json['summary'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }
}

class TaxReturnListItem {
  final int id;
  final String model;
  final int year;
  final String period;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? presentedAt;
  final String? presentedBy;
  final double totalAmount;
  final Map<String, double> casillas;
  final int boxCount;
  final int exportCount;

  const TaxReturnListItem({
    required this.id,
    required this.model,
    required this.year,
    required this.period,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.presentedAt,
    required this.presentedBy,
    required this.totalAmount,
    required this.casillas,
    required this.boxCount,
    required this.exportCount,
  });

  factory TaxReturnListItem.fromJson(Map<String, dynamic> json) {
    final rawCasillas = json['casillas'] as Map<String, dynamic>? ?? {};
    return TaxReturnListItem(
      id: json['id'] as int,
      model: json['model'] as String? ?? '',
      year: json['year'] as int? ?? 0,
      period: json['period'] as String? ?? '',
      status: json['status'] as String? ?? 'draft',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      presentedAt: json['presentedAt'] as String?,
      presentedBy: json['presentedBy'] as String?,
      totalAmount: toDouble(json['totalAmount']),
      casillas: rawCasillas.map((k, v) => MapEntry(k, toDouble(v))),
      boxCount: json['boxCount'] as int? ?? 0,
      exportCount: json['exportCount'] as int? ?? 0,
    );
  }
}

class TaxReturnSummary {
  final int total;
  final int presented;
  final int draft;
  final String? lastPresentedAt;
  final TaxNextDue? nextDue;

  const TaxReturnSummary({
    required this.total,
    required this.presented,
    required this.draft,
    required this.lastPresentedAt,
    required this.nextDue,
  });

  factory TaxReturnSummary.fromJson(Map<String, dynamic> json) {
    final nextDueJson = json['nextDue'];
    return TaxReturnSummary(
      total: json['total'] as int? ?? 0,
      presented: json['presented'] as int? ?? 0,
      draft: json['draft'] as int? ?? 0,
      lastPresentedAt: json['lastPresentedAt'] as String?,
      nextDue: nextDueJson is Map<String, dynamic>
          ? TaxNextDue.fromJson(nextDueJson)
          : null,
    );
  }
}

class TaxNextDue {
  final String model;
  final String label;
  final String dueDate;

  const TaxNextDue({
    required this.model,
    required this.label,
    required this.dueDate,
  });

  factory TaxNextDue.fromJson(Map<String, dynamic> json) {
    return TaxNextDue(
      model: json['model'] as String? ?? '',
      label: json['label'] as String? ?? '',
      dueDate: json['dueDate'] as String? ?? '',
    );
  }
}
