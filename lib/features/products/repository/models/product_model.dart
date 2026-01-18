class ProductModel {
  final int id;
  final String name;
  final int amount;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int categoryId;
  final String categoryName;

  const ProductModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
    required this.categoryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      amount: json['amount'] as int,
      price: json['price'] as double,
      //บอกให้ backend ส่งprice เป็น double มันไม่ควรเป็นstring
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      categoryId: json['category_id'] as int,
      categoryName: json['category_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }
}
