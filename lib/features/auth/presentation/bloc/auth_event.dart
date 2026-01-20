part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

//เรียก eventจากตรงนี้ไปเก็บ username password
class LoginRequested extends AuthEvent {
  final String username; 
  final String password;

  LoginRequested({required this.username, required this.password});
}

class LogoutRequested extends AuthEvent {}

class AuthReset extends AuthEvent {}

class AuthLogout extends AuthEvent {}
