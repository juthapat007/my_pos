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
    r.child('/', child: (_) => const LoginPage());
  }
}
