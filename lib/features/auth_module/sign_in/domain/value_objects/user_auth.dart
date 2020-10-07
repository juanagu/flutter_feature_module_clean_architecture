class UserAuth {
  final String username;
  final String email;
  final String token;

  UserAuth(
    this.username,
    this.email,
    this.token,
  );

  bool isValid() {
    return token.isNotEmpty;
  }
}
