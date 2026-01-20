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
      price: (json['price'] as num).toDouble(),
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

  // เพิ่ม copyWith สำหรับอัพเดทข้อมูล
  // ProductModel copyWith({
  //   int? id,
  //   String? name,
  //   int? amount,
  //   double? price,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  //   int? categoryId,
  //   String? categoryName,
  // }) {
  //   return ProductModel(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //     amount: amount ?? this.amount,
  //     price: price ?? this.price,
  //     createdAt: createdAt ?? this.createdAt,
  //     updatedAt: updatedAt ?? this.updatedAt,
  //     categoryId: categoryId ?? this.categoryId,
  //     categoryName: categoryName ?? this.categoryName,
  //   );
  // }
}
