import 'package:app/features/auth_module/core/domain/entities/user_logged.dart';
import 'package:app/features/auth_module/core/domain/respositories/user_session_repository.dart';


class UserSession {
  final UserSessionRepository userSessionRepository;
  UserLogged _userLogged;

  UserSession(
    this.userSessionRepository,
  );

  Future<bool> check() async {
    _userLogged = await userSessionRepository.get();
    return _userLogged != null && _userLogged.isValid();
  }

  Future<bool> create(UserLogged user) async {
    return await userSessionRepository.save(user);
  }
}
