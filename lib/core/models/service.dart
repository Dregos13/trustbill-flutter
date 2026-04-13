class Service {
  final int id;
  final String name;
  final String? description;
  final double unitPrice;
  final double taxRate;

  const Service({
    required this.id,
    required this.name,
    this.description,
    required this.unitPrice,
    required this.taxRate,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String?,
        unitPrice: double.parse(json['unitPrice'].toString()),
        taxRate: double.parse((json['taxRate'] ?? 0).toString()),
      );
}
