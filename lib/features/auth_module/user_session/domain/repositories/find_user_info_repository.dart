
import 'package:app/features/auth_module/core/domain/entities/user_info.dart';

abstract class FindUserInfoRepository {
  Future<UserInfo> byUsername(String username);
}
