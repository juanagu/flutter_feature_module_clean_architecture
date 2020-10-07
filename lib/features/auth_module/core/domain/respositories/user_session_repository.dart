import 'package:app/features/auth_module/core/domain/entities/user_logged.dart';

abstract class UserSessionRepository {
  Future<UserLogged> get();

  Future<bool> save(UserLogged user);

  Future logout();
}
