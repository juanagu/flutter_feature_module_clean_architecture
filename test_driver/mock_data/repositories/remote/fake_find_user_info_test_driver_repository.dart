import 'package:app/features/auth_module/core/domain/entities/user_info.dart';
import 'package:app/features/auth_module/user_session/domain/repositories/find_user_info_repository.dart';

import '../../../data/user_credential_test_data.dart';

class FakeFindUserInfoTestDriverRepository implements FindUserInfoRepository {
  @override
  Future<UserInfo> byUsername(String username) async {
    await Future.delayed(Duration(seconds: 3));

    if (username == UserCredentialTestData.username) {
      return UserInfo(1, 'Agu Juan Ignacio');
    }

    return null;
  }
}
