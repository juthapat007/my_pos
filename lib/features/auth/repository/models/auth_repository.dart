import 'package:pos_02/features/auth/repository/models/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });
  //เอาไว้ ตอนlogin สำเร็จ เก็บ token

  Future<void> logout();
  Future<String?> getToken();
}
