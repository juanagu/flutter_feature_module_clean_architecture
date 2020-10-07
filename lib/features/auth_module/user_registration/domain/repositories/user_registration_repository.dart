import 'package:app/core/domain/entities/user.dart';
import 'package:app/features/auth_module/user_registration/domain/value_objects/user_registration.dart';

abstract class UserRegistrationRepository {
  Future<User> register(UserRegistration userRegistration);
}
