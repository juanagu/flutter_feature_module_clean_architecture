class UserRegistration {
  final String firstName;
  final String lastName;
  final String identifier;
  final String phone;
  final String email;

  UserRegistration(
    this.firstName,
    this.lastName,
    this.identifier,
    this.phone, {
    this.email,
  });
}
