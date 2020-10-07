import 'package:app/features/auth_module/sign_in/domain/value_objects/user_credential.dart';

class SignInInputDto {
  final String username;
  final String credential;

  SignInInputDto(
    this.username,
    this.credential,
  );

  static SignInInputDto fromUserCredential(UserCredential userCredential) {
    return SignInInputDto(
      userCredential.username,
      userCredential.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': credential,
    };
  }
}
