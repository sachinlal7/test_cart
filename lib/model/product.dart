class Product {
  final String name;
  final int id;
  final double cost;
  final int availability;
  final String details;
  final String category;

  Product({
    required this.name,
    required this.id,
    required this.cost,
    required this.availability,
    required this.details,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json["p_name"] ?? '',
      id: json["p_id"],
      cost: double.parse(json["p_cost"].toString()),
      availability: json["p_availability"],
      details: json["p_details"] ?? 'Not Provided',
      category: json["p_category"] ?? 'Default',
    );
  }
}
