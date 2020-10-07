import 'package:app/core/domain/entities/user.dart';

abstract class UserDataMapper {
  static User fromJson(dynamic userJson) {
    if (userJson == null) return null;
    return User(
      userJson['id'],
      userJson['first_name'],
      userJson['last_name'],
      userJson['identification_number'],
    );
  }
}
