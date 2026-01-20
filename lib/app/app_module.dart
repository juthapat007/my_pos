import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pos_02/core/constants/setup_Logger.dart';
import 'package:pos_02/core/interceptors/auth_interceptor.dart';
import 'package:pos_02/features/auth/auth_module.dart';
import 'package:pos_02/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_02/features/auth/repository/service/auth_api.dart';
import 'package:pos_02/features/auth/repository/service/auth_repository.dart';
import 'package:pos_02/features/auth/repository/service/auth_repository_impl.dart';
import 'package:pos_02/features/main/main_module.dart';
import 'package:pos_02/features/receipts/receipts_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // Dio instance (global)
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://apipos-production.up.railway.app/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(setupLogger());
    i.addInstance<Dio>(dio);

    // Secure Storage (global)
    i.addInstance<FlutterSecureStorage>(const FlutterSecureStorage());

    // Auth dependencies (global - persists across navigation)
    i.addLazySingleton<AuthApi>(() => AuthApi(Modular.get<Dio>()));
    i.addLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(Modular.get<AuthApi>()),
    );
    i.addLazySingleton<AuthBloc>(
      () => AuthBloc(authRepository: Modular.get<AuthRepository>()),
    );
  }

  @override
  void routes(r) {
    r.module('/', module: AuthModule());
    r.module('/products', module: MainModule());
    r.module('/receipt',module: ReceiptsModule());
  }
}
