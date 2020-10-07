import 'package:app/features/auth_module/core/domain/entities/user_logged.dart';

import 'sign_in_notification.dart';

class SignInOutput {
  final UserLogged user;
  final SignInNotification signInNotification;

  SignInOutput(
    this.user,
    this.signInNotification,
  );

  bool isOk() {
    return user != null && user.isValid();
  }

  bool isUnauthenticated() {
    return signInNotification.errors
        .where((element) =>
            element.signInErrorType != SignInErrorType.UnknownError)
        .isNotEmpty;
  }
}
