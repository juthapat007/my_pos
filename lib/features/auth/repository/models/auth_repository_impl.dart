import 'package:pos_02/features/auth/repository/models/auth_repository.dart';
import 'package:pos_02/features/auth/repository/models/login_response.dart';
import 'package:pos_02/features/auth/repository/service/auth_api.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl(this.authApi);

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authApi.login(email, password);

      final loginResponse = LoginResponse.fromJson(response.data);

      // เก็บ token ใน secure storage
      final storage = Modular.get<FlutterSecureStorage>();
      await storage.write(key: 'auth_token', value: loginResponse.token);

      return loginResponse;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    final storage = Modular.get<FlutterSecureStorage>();
    await storage.delete(key: 'auth_token');
  }

  @override
  Future<String?> getToken() async {
    final storage = Modular.get<FlutterSecureStorage>();
    return await storage.read(key: 'auth_token');
  }
}
