class SupplierMatch {
  final int id;
  final String name;
  final String? taxId;
  final String? address;

  const SupplierMatch({
    required this.id,
    required this.name,
    this.taxId,
    this.address,
  });

  factory SupplierMatch.fromJson(Map<String, dynamic> json) => SupplierMatch(
        id: json['id'] as int,
        name: json['name'] as String,
        taxId: json['taxId'] as String?,
        address: json['address'] as String?,
      );
}
