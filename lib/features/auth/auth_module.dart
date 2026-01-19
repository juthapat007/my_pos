import 'package:flutter_modular/flutter_modular.dart';
import 'package:pos_02/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:pos_02/features/auth/repository/models/auth_repository.dart';
import 'package:pos_02/features/auth/repository/models/auth_repository_impl.dart';
import 'package:pos_02/features/auth/repository/service/auth_api.dart';
import 'package:pos_02/features/auth/views/login_page.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // r.child(
    //   '/',
    //   child: (_) => BlocProvider<AuthBloc>(
    //     create: (_) => Modular.get<AuthBloc>()..add(AuthLoading()),
    //     child: const LoginPage(),
    //   ),
    // );
    r.child('/', child: (_) => const LoginPage());
    
  }
}
