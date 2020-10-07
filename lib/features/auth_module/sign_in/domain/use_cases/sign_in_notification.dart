class SignInNotification {
  final List<SignInError> errors;

  SignInNotification() : errors = [];

  SignInNotification addError(SignInError error) {
    errors.add(error);
    return this;
  }

  bool hasErrors() {
    return errors.isNotEmpty;
  }
}

class SignInError {
  final SignInErrorType signInErrorType;
  final String message;

  SignInError(
    this.signInErrorType,
    this.message,
  );
}

enum SignInErrorType {
  EmptyCredentials,
  InvalidCredentials,
  UnknownError,
}
