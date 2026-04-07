class PurchaseListItem {
  final int id;
  final String? invoiceNumber;
  final String issueDate;
  final String? dueDate;
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
