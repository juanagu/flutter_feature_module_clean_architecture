import 'package:app/commons/helpers/http_helper.dart';
import 'package:app/features/auth_module/core/domain/entities/user_info.dart';
import 'package:app/features/auth_module/user_session/data/mappers/user_info_data_mapper.dart';
import 'package:app/features/auth_module/user_session/domain/repositories/find_user_info_repository.dart';

class FindUserInfoRemoteRepository implements FindUserInfoRepository {
  final String baseUrl;
  final HttpHelper httpHelper;

  static const String endpoint = 'user/find/';

  FindUserInfoRemoteRepository(
    this.baseUrl,
    this.httpHelper,
  );

  @override
  Future<UserInfo> byUsername(String username) async {
    var url = '$getEndpointUrl$username';
    var response = await httpHelper.get(url);
    if (response.isOk()) {
      return UserInfoDataMapper.fromJson(response.data);
    }

    return null;
  }

  String get getEndpointUrl => '$baseUrl/$endpoint';
}
