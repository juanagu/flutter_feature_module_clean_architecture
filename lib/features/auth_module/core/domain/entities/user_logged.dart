class UserLogged {
  final String username;
  final String email;

  UserLogged(
    this.username,
    this.email,
  );

  bool isValid() {
    return username.isNotEmpty && email.isNotEmpty;
  }

  @override
  String toString() {
    return '\nusername: $username\n email: $email';
  }
}
