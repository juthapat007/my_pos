import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pos_02/features/products/repository/services/products_api.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsApi productsApi;

  ProductsBloc({required this.productsApi}) : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) {
      // TODO
    });
  }
}
