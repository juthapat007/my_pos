import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pos_02/features/auth/repository/models/auth_repository.dart';
import 'package:pos_02/features/auth/repository/models/login_response.dart';
part 'auth_event.dart';
part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository authRepository;

//   AuthBloc({required this.authRepository}) : super(AuthInitial()) {
//     on<AuthLogout>((event, emit) async {
//       await authRepository.logout();
//       emit(AuthUnauthenticated());
//     });
//     on<LoginRequested>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         final loginResponse = await authRepository.login(
//           username: event.username,
//           password: event.password,
//         );

//         // 🔐 token ถูกเก็บใน secure storage แล้ว (ใน repo)
//         // loginResponse เอาไว้ใช้ต่อได้

//         emit(AuthAuthenticated());
//       } catch (e) {
//         emit(AuthError('Username or Password is wrong'));
//         emit(AuthInitial());
//       }
//     });
//     on<AuthReset>((event, emit) => emit(AuthInitial()));
//   }

//   // Future<void> _onLoginRequested(
//   //   LoginRequested event,
//   //   Emitter<AuthState> emit,
//   // ) async {
//   //   emit(AuthLoaded());
//   //   try {
//   //     final loginResponse = await authRepository.login(
//   //       username: event.username,
//   //       password: event.password,
//   //     );
//   //     emit(AuthSuccess(loginResponse: loginResponse));
//   //   } catch (e) {
//   //     emit(AuthError(message: e.toString()));
//   //   }
//   // }
// }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<AuthLogout>(_onLogout);
    on<AuthReset>(_onReset);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.login(
        username: event.username,
        password: event.password,
      );
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError('Username or Password is wrong'));
      emit(AuthInitial()); 
      //ที่ไม่ใช้ AuthSuccess เพราะ
    }
    
  }

  Future<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }

  void _onReset(AuthReset event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
