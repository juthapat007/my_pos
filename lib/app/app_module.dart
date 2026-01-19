import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pos_02/core/constants/setup_Logger.dart';
import 'package:pos_02/core/interceptors/auth_interceptor.dart';
import 'package:pos_02/features/auth/auth_module.dart';
import 'package:pos_02/features/products/product_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // สร้าง Dio instance ก่อน
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://apipos-production.up.railway.app/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
       dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(setupLogger());

    // ใช้ addInstance เพื่อให้เป็น global
    i.addInstance<Dio>(dio);

    i.addInstance<FlutterSecureStorage>(const FlutterSecureStorage());
  }

  @override
  void routes(r) {
    r.module('/', module: AuthModule());
    r.module('/products', module: ProductModule());
  }
}
