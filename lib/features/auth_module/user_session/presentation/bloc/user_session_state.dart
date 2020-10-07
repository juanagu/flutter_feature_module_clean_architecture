import 'package:app/features/auth_module/core/domain/entities/user_info.dart';
import 'package:equatable/equatable.dart';

abstract class UserSessionState extends Equatable {
  @override
  List<Object> get props => [];
}

class Initial extends UserSessionState {}

class ValidSession extends UserSessionState {
  final UserInfo userInfo;

  ValidSession(
    this.userInfo,
  );
}

class InvalidSession extends UserSessionState {}
