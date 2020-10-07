import 'package:app/features/auth_module/core/domain/entities/user_logged.dart';
import 'package:app/features/auth_module/core/domain/entities/user_session.dart';
import 'package:app/features/auth_module/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:app/features/auth_module/sign_in/domain/value_objects/user_auth.dart';
import 'package:app/features/auth_module/sign_in/domain/value_objects/user_credential.dart';

import '../sign_in_use_case.dart';
import '../sign_in_input.dart';
import '../sign_in_notification.dart';
import '../sign_in_output.dart';

class SignInImpUseCase implements SignInUseCase {
  static const String invalidCredential = 'invalid_credential';

  final SignInRepository signInRepository;
  final UserSession userSession;

  UserLogged user;
  SignInNotification notification;

  SignInImpUseCase(
    this.signInRepository,
    this.userSession,
  );

  @override
  Future<SignInOutput> execute(SignInInput input) async {
    notification = SignInNotification();
    if (_isValidInput(input)) {
      try {
        var auth = await signInRepository.authorize(input.credential);
        await _analyzeSignInResponse(auth, input.credential);
      } catch (e) {
        notification.addError(SignInError(
          SignInErrorType.UnknownError,
          e.toString(),
        ));
      }
    }

    return SignInOutput(user, notification);
  }

  Future<void> _analyzeSignInResponse(
    UserAuth userAuth,
    UserCredential userCredential,
  ) async {
    if (userAuth != null && userAuth.isValid()) {
      user = UserLogged(
        userAuth.username,
        userAuth.email,
      );

      await userSession.create(user);
    } else {
      notification.addError(SignInError(
        SignInErrorType.InvalidCredentials,
        'not authorize',
      ));
    }
  }

  bool _isValidInput(SignInInput input) {
    if (input.isValid()) return true;
    notification.addError(SignInError(
      SignInErrorType.EmptyCredentials,
      'credentials cannot be empty',
    ));

    return false;
  }
}
