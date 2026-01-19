import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalStorage {
  final FlutterSecureStorage storage;

  AuthLocalStorage(this.storage);

  Future<String?> getToken() async {
    return storage.read(key: 'auth_token');
  }

  Future<void> saveToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  Future<void> clearToken() async {
    await storage.delete(key: 'auth_token');
  }
}
