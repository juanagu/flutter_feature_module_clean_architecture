import 'package:app/features/auth_module/core/domain/entities/user_logged.dart';
import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class Uninitialized extends SignInState {}

class Authenticating extends SignInState {}

class Authenticated extends SignInState {
  final UserLogged user;

  Authenticated(
    this.user,
  );

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends SignInState {}

class Failed extends SignInState {
  final Exception error;

  Failed(
    this.error,
  );
}

class ConnectionError extends SignInState {}
