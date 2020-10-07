class User {
  final int id;
  final String firstName;
  final String lastName;
  final String identifier;

  User(
    this.id,
    this.firstName,
    this.lastName,
    this.identifier,
  );

  String get fullName => '$firstName $lastName';
}