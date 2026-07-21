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

class Supplier {
  final int id;
  final String name;
  final String taxId;
  final String email;
  final String phone;
  final String address;
  final String postalCode;
  final String notes;
  final int purchasesCount;

  const Supplier({
    required this.id,
    required this.name,
    this.taxId = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.postalCode = '',
    this.notes = '',
    this.purchasesCount = 0,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json['id'] as int,
    name: json['name'] as String? ?? '',
    taxId: json['taxId'] as String? ?? '',
    email: json['email'] as String? ?? '',
    phone: json['phone'] as String? ?? '',
    address: json['address'] as String? ?? '',
    postalCode: json['postalCode'] as String? ?? '',
    notes: json['notes'] as String? ?? '',
    purchasesCount: json['purchasesCount'] as int? ?? 0,
  );
}
