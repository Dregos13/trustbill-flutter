class PurchaseListItem {
  final int id;
  final String? invoiceNumber;
  final String issueDate;
  final String? dueDate;
  final String? paidAt;
  final double total;
  final double tax;
  final String taxKind;
  final String status; // UNPAID | PAID
  final Map<String, dynamic> supplier; // {id, name, taxId}

  PurchaseListItem({
    required this.id,
    this.invoiceNumber,
    required this.issueDate,
    this.dueDate,
    this.paidAt,
    required this.total,
    required this.tax,
    required this.taxKind,
    required this.status,
    required this.supplier,
  });

  factory PurchaseListItem.fromJson(Map<String, dynamic> json) {
    return PurchaseListItem(
      id: json['id'] as int,
      invoiceNumber: json['invoiceNumber'] as String?,
      issueDate: json['issueDate'] as String,
      dueDate: json['dueDate'] as String?,
      paidAt: json['paidAt'] as String?,
      total: double.parse(json['total'].toString()),
      tax: double.parse(json['tax'].toString()),
      taxKind: json['taxKind'] as String? ?? 'IVA',
      status: json['status'] as String? ?? 'UNPAID',
      supplier: json['supplier'] as Map<String, dynamic>,
    );
  }

  String get supplierName => supplier['name'] as String? ?? '—';
  String get supplierTaxId => supplier['taxId'] as String? ?? '';
}

class PurchaseDetail {
  final int id;
  final String? invoiceNumber;
  final String issueDate;
  final String? dueDate;
  final String? paidAt;
  final double total;
  final double tax;
  final String taxKind;
  final String status;
  final Map<String, dynamic> supplier;
  final List<PurchaseLine> lines;
  final List<Map<String, dynamic>> attachments;

  PurchaseDetail({
    required this.id,
    this.invoiceNumber,
    required this.issueDate,
    this.dueDate,
    this.paidAt,
    required this.total,
    required this.tax,
    required this.taxKind,
    required this.status,
    required this.supplier,
    required this.lines,
    required this.attachments,
  });

  factory PurchaseDetail.fromJson(Map<String, dynamic> json) => PurchaseDetail(
    id: json['id'] as int,
    invoiceNumber: json['invoiceNumber'] as String?,
    issueDate: json['issueDate'] as String,
    dueDate: json['dueDate'] as String?,
    paidAt: json['paidAt'] as String?,
    total: double.parse(json['total'].toString()),
    tax: double.parse(json['tax'].toString()),
    taxKind: json['taxKind'] as String? ?? 'IVA',
    status: json['status'] as String? ?? 'UNPAID',
    supplier: json['supplier'] as Map<String, dynamic>,
    lines: ((json['lines'] as List?) ?? const [])
        .map((e) => PurchaseLine.fromJson(e as Map<String, dynamic>))
        .toList(),
    attachments: ((json['attachments'] as List?) ?? const [])
        .map((e) => e as Map<String, dynamic>)
        .toList(),
  );

  int? get supplierId => supplier['id'] as int?;
  String get supplierName => supplier['name'] as String? ?? '—';
  String get supplierTaxId => supplier['taxId'] as String? ?? '';
}

class PurchaseLine {
  final int? id;
  final String description;
  final double base;
  final double taxRate;
  final double taxAmount;

  PurchaseLine({
    this.id,
    required this.description,
    required this.base,
    required this.taxRate,
    required this.taxAmount,
  });

  factory PurchaseLine.fromJson(Map<String, dynamic> json) => PurchaseLine(
    id: json['id'] as int?,
    description: json['description'] as String? ?? '',
    base: double.parse(json['base'].toString()),
    taxRate: double.parse(json['taxRate'].toString()),
    taxAmount: double.parse(json['taxAmount'].toString()),
  );
}
