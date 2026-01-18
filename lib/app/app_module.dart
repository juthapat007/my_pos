import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pos_02/core/constants/setup_Logger.dart';
import 'package:pos_02/features/auth/auth_module.dart';
import 'package:pos_02/features/products/product_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: 'https://apipos-production.up.railway.app/',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      ),
    );

    i<Dio>().interceptors.add(setupLogger());

    i.addSingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  }

  @override
  void routes(r) {
    r.module('/', module: AuthModule());
    r.module('/products', module: ProductModule());
  }
}
