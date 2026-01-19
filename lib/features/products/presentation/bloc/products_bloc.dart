import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
import 'package:pos_02/features/products/repository/models/product_model.dart';
import 'package:pos_02/features/products/repository/services/products_api.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsApi productsApi;

  ProductsBloc({required this.productsApi}) : super(ProductsInitial()) {
    on<ProductsLoadEvent>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    ProductsLoadEvent event,
    Emitter<ProductsState> emit,
  ) async {
    print('🔥 ProductsLoadEvent fired');
    emit(ProductsLoading());

    try {
      final products = await productsApi.getProducts();
      print('จำนวนสินค้า : ${products.length} items');
      emit(ProductsLoaded(products: products));
    } catch (e) {
      print('Products error: $e');
      emit(ProductsError(message: e.toString()));
    }
  }
}
