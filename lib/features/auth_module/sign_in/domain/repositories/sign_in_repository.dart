import 'package:app/features/auth_module/sign_in/domain/value_objects/user_auth.dart';
import 'package:app/features/auth_module/sign_in/domain/value_objects/user_credential.dart';

abstract class SignInRepository {
  Future<UserAuth> authorize(UserCredential userCredential);
}
