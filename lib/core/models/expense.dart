// Supplier invoice confirm payload — matches confirmSupplierInvoiceSchema
class SupplierInvoiceConfirmPayload {
  final int? supplierId;
  final String supplierName;
  final String? supplierCif;
  final String? supplierEmail;
  final String? supplierPhone;
  final String? supplierAddress;
  final String? supplierPostalCode;
  final String? supplierNotes;
  final String? invoiceNumber;
  final String issueDate;
  final String? dueDate;
  final String taxKind;
  final String status;
  final double total;
  final double tax;
  final List<Map<String, dynamic>> lines;
  final String imageBase64;
  final String imageMimeType;

  const SupplierInvoiceConfirmPayload({
    this.supplierId,
    required this.supplierName,
    this.supplierCif,
    this.supplierEmail,
    this.supplierPhone,
    this.supplierAddress,
    this.supplierPostalCode,
    this.supplierNotes,
    this.invoiceNumber,
    required this.issueDate,
    this.dueDate,
    required this.taxKind,
    required this.status,
    required this.total,
    required this.tax,
    required this.lines,
    required this.imageBase64,
    required this.imageMimeType,
  });

  Map<String, dynamic> toJson() => {
        if (supplierId != null) 'supplierId': supplierId,
        'supplierName': supplierName,
        if (supplierCif != null && supplierCif!.isNotEmpty)
          'supplierCif': supplierCif,
        if (supplierEmail != null && supplierEmail!.isNotEmpty)
          'supplierEmail': supplierEmail,
        if (supplierPhone != null && supplierPhone!.isNotEmpty)
          'supplierPhone': supplierPhone,
        if (supplierAddress != null && supplierAddress!.isNotEmpty)
          'supplierAddress': supplierAddress,
        if (supplierPostalCode != null && supplierPostalCode!.isNotEmpty)
          'supplierPostalCode': supplierPostalCode,
        if (supplierNotes != null && supplierNotes!.isNotEmpty)
          'supplierNotes': supplierNotes,
        if (invoiceNumber != null && invoiceNumber!.isNotEmpty)
          'invoiceNumber': invoiceNumber,
        'issueDate': issueDate,
        if (dueDate != null) 'dueDate': dueDate,
        'taxKind': taxKind,
        'status': status,
        'total': total,
        'tax': tax,
        'lines': lines,
        'imageBase64': imageBase64,
        'imageMimeType': imageMimeType,
      };
}

// Response from POST /receipts/confirm
class InvoiceCreatedResponse {
  final Map<String, dynamic> invoice;
  final Map<String, dynamic> supplier;
  final bool supplierCreated;
  final Map<String, dynamic>? attachment;

  InvoiceCreatedResponse({
    required this.invoice,
    required this.supplier,
    required this.attachment,
  }) : supplierCreated = supplier['created'] as bool? ?? false;

  factory InvoiceCreatedResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceCreatedResponse(
      invoice: json['invoice'] as Map<String, dynamic>,
      supplier: json['supplier'] as Map<String, dynamic>,
      attachment: json['attachment'] as Map<String, dynamic>?,
    );
  }
}
