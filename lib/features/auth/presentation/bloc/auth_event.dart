part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  LoginRequested({required this.username, required this.password});
}

// class AuthLoading extends AuthEvent {}

class AuthReset extends AuthEvent {}

class AuthLogout extends AuthEvent {}

// class AuthSuccess extends AuthState {
//   final LoginResponse loginResponse;
//   AuthSuccess({required this.loginResponse});
// }
