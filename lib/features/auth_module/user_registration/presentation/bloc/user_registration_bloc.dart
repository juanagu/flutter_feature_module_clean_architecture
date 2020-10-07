import 'package:app/core/domain/entities/user.dart';
import 'package:app/features/auth_module/user_registration/domain/repositories/user_registration_repository.dart';
import 'package:app/features/auth_module/user_registration/domain/value_objects/user_registration.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRegistrationBloc extends Cubit<UserRegistrationState> {
  final UserRegistrationRepository _userRegistrationRepository;

  UserRegistrationBloc(
    this._userRegistrationRepository,
  ) : super(Initial());

  Future<void> register(UserRegistration userRegistration) async {
    emit(Uploading());
    try {
      var user = await _userRegistrationRepository.register(userRegistration);
      if (user != null) {
        emit(Success(user));
      } else {
        emit(Error());
      }
    } catch (_) {
      emit(Error());
    }
  }
}

class UserRegistrationState {}

class Initial extends UserRegistrationState {}

class Uploading extends UserRegistrationState {}

class Success extends UserRegistrationState {
  final User user;

  Success(this.user);
}

class Error extends UserRegistrationState {}
