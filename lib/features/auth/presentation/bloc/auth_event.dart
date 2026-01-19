part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String username; // เปลี่ยนเป็น username
  final String password;

  LoginRequested({required this.username, required this.password});
}

class LogoutRequested extends AuthEvent {}

class AuthSuccess extends AuthState {
  final LoginResponse loginResponse;
  AuthSuccess({required this.loginResponse});
}
