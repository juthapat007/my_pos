import 'package:flutter/material.dart';
import 'package:pos_02/features/products/view/view_type.dart';

@immutable
sealed class ProductsEvent {}

class ProductsLoadEvent extends ProductsEvent {}

class ProductsErrorEvent extends ProductsEvent {}

