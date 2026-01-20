// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:pos_02/features/main/views/main_page.dart';
// import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
// import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
// import 'package:pos_02/features/products/repository/services/products_api.dart';
// import 'package:pos_02/features/receipts/presentation/bloc/receipts_bloc.dart';
// import 'package:pos_02/features/receipts/repository/services/receipts_api.dart';
// import 'package:dio/dio.dart';

// class MainModule extends Module {
//   @override
//   void binds(i) {
//     // Products
//     i.addLazySingleton<ProductsApi>(() => ProductsApi(Modular.get<Dio>()));
//     i.addLazySingleton<ProductsBloc>(
//       () => ProductsBloc(productsApi: Modular.get<ProductsApi>()),
//     );

//     // Receipts
//     i.addLazySingleton<ReceiptsApi>(() => ReceiptsApi(Modular.get<Dio>()));
//     i.addLazySingleton<ReceiptsBloc>(
//       () => ReceiptsBloc(receiptsApi: Modular.get<ReceiptsApi>()),
//     );
//   }

//   @override
//   void routes(r) {
//     r.child(
//       '/',
//       child: (_) => MultiBlocProvider(
//         providers: [
//           BlocProvider<ProductsBloc>(
//             create: (_) =>
//                 Modular.get<ProductsBloc>()..add(ProductsLoadEvent()),
//           ),
//           BlocProvider<ReceiptsBloc>(
//             create: (_) => Modular.get<ReceiptsBloc>(),
//           ),
//         ],
//         child: const MainPage(),
//       ),
//     );
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pos_02/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_02/features/main/views/main_page.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
import 'package:pos_02/features/products/repository/services/products_api.dart';
import 'package:pos_02/features/receipts/presentation/bloc/receipts_bloc.dart';
import 'package:pos_02/features/receipts/repository/services/receipts_api.dart';
import 'package:dio/dio.dart';

class MainModule extends Module {
  @override
  void binds(i) {
    // Products
    i.addLazySingleton<ProductsApi>(() => ProductsApi(Modular.get<Dio>()));
    i.addLazySingleton<ProductsBloc>(
      () => ProductsBloc(productsApi: Modular.get<ProductsApi>()),
    );

    // Receipts
    i.addLazySingleton<ReceiptsApi>(() => ReceiptsApi(Modular.get<Dio>()));
    i.addLazySingleton<ReceiptsBloc>(
      () => ReceiptsBloc(receiptsApi: Modular.get<ReceiptsApi>()),
    );
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (_) => MultiBlocProvider(
        providers: [
          // Use .value to get existing AuthBloc from AppModule
          BlocProvider<AuthBloc>.value(value: Modular.get<AuthBloc>()),
          BlocProvider<ProductsBloc>(
            create: (_) =>
                Modular.get<ProductsBloc>()..add(ProductsLoadEvent()),
          ),
          BlocProvider<ReceiptsBloc>(
            create: (_) =>
                Modular.get<ReceiptsBloc>()..add(ReceiptsLoadEvent()),
          ),
        ],
        child: const MainPage(),
      ),
    );
  }
}
