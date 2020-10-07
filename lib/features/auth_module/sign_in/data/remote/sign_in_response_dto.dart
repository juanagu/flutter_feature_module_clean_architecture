import 'package:app/features/auth_module/sign_in/domain/value_objects/user_auth.dart';

class SignInResponseDto {

  final String username;
  final String email;
  final String token;

  SignInResponseDto(
    this.username,
    this.email,
    this.token,
  );

  UserAuth toAuth() {
    return UserAuth(
      username,
      email,
      token,
    );
  }

  static SignInResponseDto fromJson(Map<String, dynamic> json) {
    return SignInResponseDto(
      json['username'] as String,
      json['email'] as String,
      json['token'] as String,
    );
  }
}
