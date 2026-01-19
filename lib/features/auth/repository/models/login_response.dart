class LoginResponse {
  final String token;
  final String? refreshToken;
  final User? user;

  LoginResponse({required this.token, this.refreshToken, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    print('🔍 Login Response JSON: $json'); // Debug

    return LoginResponse(
      token: json['token'] ?? json['access_token'] ?? json['accessToken'] ?? '',
      refreshToken: json['refresh_token'] ?? json['refreshToken'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refresh_token': refreshToken,
      'user': user?.toJson(),
    };
  }
}

class User {
  final String? id;
  final String? email;
  final String? name;
  final String? username;

  User({this.id, this.email, this.name, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString(),
      email: json['email'],
      name: json['name'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'username': username};
  }
}
