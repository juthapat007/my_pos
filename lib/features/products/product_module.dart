import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:pos_02/features/products/presentation/page/products.dart';
import 'package:pos_02/features/products/repository/services/products_api.dart';
import 'package:dio/dio.dart';

class ProductModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<ProductsApi>(() => ProductsApi(i<Dio>()));

    i.addLazySingleton<ProductsBloc>(
      () => ProductsBloc(productsApi: i<ProductsApi>()),
    );
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => BlocProvider<ProductsBloc>(
        create: (_) => Modular.get<ProductsBloc>(),
        child: const ProductsPage(),
      ),
    );
  }
}
