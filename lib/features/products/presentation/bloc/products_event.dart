import 'package:flutter/material.dart';
import 'package:pos_02/features/products/repository/models/product_model.dart';
import 'package:pos_02/features/products/view/view_type.dart';

@immutable
sealed class ProductsEvent {}

class ProductsLoadEvent extends ProductsEvent {}

class ProductsSuccessEvent extends ProductsEvent {}

class LogoutEvent extends ProductsEvent {}

class ProductsErrorEvent extends ProductsEvent {}

class ChangeViewEvent extends ProductsEvent {
  final ViewType viewType;
  ChangeViewEvent(this.viewType);
}

class AddToCartEvent extends ProductsEvent {
  final ProductModel product;
  AddToCartEvent(this.product);
}

class RemoveFromCartEvent extends ProductsEvent {
  final ProductModel product;
  RemoveFromCartEvent(this.product);
}

class ClearCartEvent extends ProductsEvent {}
