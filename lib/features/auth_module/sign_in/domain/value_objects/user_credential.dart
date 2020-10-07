import 'package:equatable/equatable.dart';

class UserCredential extends Equatable {
  final String username;
  final String password;

  UserCredential(
    this.username,
    this.password,
  );

  @override
  List<Object> get props => [username, password];
}
