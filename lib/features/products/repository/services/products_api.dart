import 'package:dio/dio.dart';
import 'package:pos_02/features/products/product_module.dart';
import 'package:pos_02/features/products/repository/models/product_model.dart';

class ProductsApi {
  final Dio dio;
  ProductsApi(this.dio) {
    print('ProductsApi instance created: $hashCode');
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get('/sku_masters');
    return [ProductModel.fromJson(response.data)];
  }

  Future<List<ProductModel>> getProductById(int id) async {
    print('\n========== GET PRODUCT ID = $id ==========');
    final response = await dio.get('/sku_masters/$id');
    return [ProductModel.fromJson(response.data)];
  }
}
