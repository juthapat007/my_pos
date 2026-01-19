import 'package:dio/dio.dart';

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<Response> login(String username, String password) async {
    final response = await dio.post(
      '/login',
      data: {'username': username, 'password': password},
    );
    return response;
  }
}
