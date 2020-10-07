import 'package:app/features/auth_module/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:app/features/auth_module/sign_in/domain/value_objects/user_auth.dart';
import 'package:app/features/auth_module/sign_in/domain/value_objects/user_credential.dart';

import '../../../data/user_credential_test_data.dart';

class FakeSignInTestDriverRepository implements SignInRepository {
  @override
  Future<UserAuth> authorize(UserCredential userCredential) async {
    if (isValid(userCredential)) {
      await Future.delayed(Duration(seconds: 2));
      return UserAuth(
        UserCredentialTestData.username,
        'testuser@fake.com',
        'fake_token',
      );
    }

    return null;
  }

  bool isValid(UserCredential userCredential) {
    return userCredential.username == UserCredentialTestData.username &&
        userCredential.password == UserCredentialTestData.password;
  }
}
