import 'package:dio/dio.dart';
import 'package:pos_02/features/products/repository/models/product_model.dart';

class ProductsApi {
  final Dio dio;
  ProductsApi(this.dio);

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get('/sku_masters');

    if (response.statusCode != 200) {
      throw Exception(
        'โหลดข้อมูลสินค้าไม่สําเร็จ สถานะ : ${response.statusCode}',
      );
    }

    // ดึง sku_masters array ออกมา
    final Map<String, dynamic> responseMap =
        response.data as Map<String, dynamic>;
    final List productsList = responseMap['sku_masters'] as List;

    return productsList
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
