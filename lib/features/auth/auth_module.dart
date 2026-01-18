import 'package:flutter_modular/flutter_modular.dart';
import 'package:pos_02/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:pos_02/features/auth/repository/models/auth_repository.dart';
import 'package:pos_02/features/auth/repository/models/auth_repository_impl.dart';
import 'package:pos_02/features/auth/repository/service/auth_api.dart';
import 'package:pos_02/features/auth/views/login_page.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AuthApi>(() => AuthApi(i<Dio>()));

    i.addLazySingleton<AuthRepository>(() => AuthRepositoryImpl(i<AuthApi>()));

    i.addLazySingleton<AuthBloc>(
      () => AuthBloc(authRepository: i<AuthRepository>()),
    );
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const LoginPage());
  }
}
