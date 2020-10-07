import 'package:equatable/equatable.dart';

abstract class UserSessionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckSession extends UserSessionEvent {}

class Logout extends UserSessionEvent {}
