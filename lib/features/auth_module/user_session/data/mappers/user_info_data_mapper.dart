import 'package:app/features/auth_module/core/domain/entities/user_info.dart';

abstract class UserInfoDataMapper {
  static UserInfo fromJson(dynamic json) {
    return UserInfo(
      json['id'],
      json['full_name'],
    );
  }
}
