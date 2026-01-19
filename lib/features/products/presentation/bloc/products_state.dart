part of 'products_bloc.dart';

@immutable
sealed class ProductsState {
  final ViewType viewType;
  final Map<int, int> cart;
  const ProductsState({
    this.viewType = ViewType.products,
    this.cart = const {},
  });
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial({super.viewType, super.cart});
}

final class ProductsLoading extends ProductsState {
  const ProductsLoading({super.viewType, super.cart});
}

final class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;

  const ProductsLoaded({required this.products, super.viewType, super.cart});
}

final class ProductsError extends ProductsState {
  final String message;
  const ProductsError({required this.message, super.viewType, super.cart});
}
