
import 'package:app/features/auth_module/core/domain/entities/user_logged.dart';

abstract class UserMapper {
  static Map<String, dynamic> toJson(UserLogged user) {
    if (user == null) return null;

    return {
      'username': user.username,
      'email': user.email,
    };
  }

  static UserLogged fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return UserLogged(
      json['username'],
      json['email'],
    );
  }
}
