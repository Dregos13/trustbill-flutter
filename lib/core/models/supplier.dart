class SupplierMatch {
  final int id;
  final String name;
  final String? taxId;
  final String? address;
  final String? email;
  final String? phone;
  final String? postalCode;
  final String? notes;

  const SupplierMatch({
    required this.id,
    required this.name,
    this.taxId,
    this.address,
    this.email,
    this.phone,
    this.postalCode,
    this.notes,
  });

  factory SupplierMatch.fromJson(Map<String, dynamic> json) => SupplierMatch(
        id: json['id'] as int,
        name: json['name'] as String,
        taxId: json['taxId'] as String?,
        address: json['address'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        postalCode: json['postalCode'] as String?,
        notes: json['notes'] as String?,
      );
}
