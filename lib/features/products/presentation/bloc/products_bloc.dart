import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
import 'package:pos_02/features/products/repository/models/product_model.dart';
import 'package:pos_02/features/products/repository/services/products_api.dart';
import 'package:pos_02/features/products/view/view_type.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsApi productsApi;

  ProductsBloc({required this.productsApi}) : super(ProductsInitial()) {
    on<ProductsLoadEvent>(_onLoadProducts);
    on<ChangeViewEvent>(_onChangeView);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ClearCartEvent>(_onClearCart);
  }

  List<ProductModel> _allProducts = [];

  Future<void> _onLoadProducts(
    ProductsLoadEvent event,
    Emitter<ProductsState> emit,
  ) async {
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

  void _onChangeView(ChangeViewEvent event, Emitter<ProductsState> emit) {
    if (state is ProductsLoaded) {
      emit(
        ProductsLoaded(
          products: _allProducts,
          viewType: event.viewType,
          cart: state.cart,
        ),
      );
    } else {
      emit(ProductsInitial(viewType: event.viewType, cart: state.cart));
    }
  }

  void _onAddToCart(AddToCartEvent event, Emitter<ProductsState> emit) {
    final newCart = Map<int, int>.from(state.cart);
    newCart[event.product.id] = (newCart[event.product.id] ?? 0) + 1;

    if (state is ProductsLoaded) {
      emit(
        ProductsLoaded(
          products: (state as ProductsLoaded).products,
          viewType: state.viewType,
          cart: newCart,
        ),
      );
    }
  }

  void _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<ProductsState> emit,
  ) {
    final newCart = Map<int, int>.from(state.cart);
    if (newCart.containsKey(event.product.id)) {
      if (newCart[event.product.id]! > 1) {
        newCart[event.product.id] = newCart[event.product.id]! - 1;
      } else {
        newCart.remove(event.product.id);
      }
    }

    if (state is ProductsLoaded) {
      emit(
        ProductsLoaded(
          products: (state as ProductsLoaded).products,
          viewType: state.viewType,
          cart: newCart,
        ),
      );
    }
  }

  void _onClearCart(ClearCartEvent event, Emitter<ProductsState> emit) {
    if (state is ProductsLoaded) {
      emit(
        ProductsLoaded(
          products: (state as ProductsLoaded).products,
          viewType: state.viewType,
          cart: {},
        ),
      );
    }
  }
}
