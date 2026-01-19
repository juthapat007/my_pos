import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
import 'package:pos_02/features/products/presentation/page/products.dart';
import 'package:pos_02/features/products/repository/services/products_api.dart';
import 'package:dio/dio.dart';

class ProductModule extends Module {
  @override
  void binds(i) {
    // ใช้ Modular.get เพื่อดึง Dio จาก AppModule
    i.addLazySingleton<ProductsApi>(() => ProductsApi(Modular.get<Dio>()));

    i.addLazySingleton<ProductsBloc>(
      () => ProductsBloc(productsApi: Modular.get<ProductsApi>()),
    );
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => BlocProvider<ProductsBloc>(
        create: (_) => Modular.get<ProductsBloc>()..add(ProductsLoadEvent()),
        child: const ProductsPage(),
      ),
    );
  }
}
