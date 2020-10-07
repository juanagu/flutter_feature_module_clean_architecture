import 'package:app/features/auth_module/sign_in/domain/value_objects/user_credential.dart';

class SignInInput {
  final UserCredential credential;

  SignInInput(this.credential);

  static SignInInput fromCredential(String username, String password) {
    return SignInInput(UserCredential(username, password));
  }

  bool isValid() {
    return credential.username.isNotEmpty && credential.password.isNotEmpty;
  }
}
