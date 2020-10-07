abstract class UserCredentialTestData {
  static String get username =>
      String.fromEnvironment('username', defaultValue: 'fake_username');
  static String get password =>
      String.fromEnvironment('password', defaultValue: 'fake_user_password');

  static String get invalidUsername =>
      String.fromEnvironment('invalid_username',
          defaultValue: 'fake_invalid_username');

  static String get invalidPassword =>
      String.fromEnvironment('invalid_password',
          defaultValue: 'fake_invalid_password');
}
