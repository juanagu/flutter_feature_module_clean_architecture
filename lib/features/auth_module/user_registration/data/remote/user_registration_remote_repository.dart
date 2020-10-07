import 'package:app/commons/helpers/http_helper.dart';
import 'package:app/commons/helpers/oauth_helper.dart';
import 'package:app/core/data/mappers/user_data_mapper.dart';
import 'package:app/core/domain/entities/user.dart';
import 'package:app/features/auth_module/user_registration/domain/repositories/user_registration_repository.dart';
import 'package:app/features/auth_module/user_registration/domain/value_objects/user_registration.dart';

class UserRegistrationRemoteRepository implements UserRegistrationRepository {
  final String baseUrl;
  final HttpHelper httpHelper;
  final OAuthHelper oAuthHelper;

  static const String registrationEndpoint = '/User/account-user';

  UserRegistrationRemoteRepository(
    this.baseUrl,
    this.httpHelper,
    this.oAuthHelper,
  );

  @override
  Future<User> register(UserRegistration userRegistration) async {
    var url = getRegistrationUrl();
    var data = _toJsonRequest(userRegistration);
    var response = await httpHelper.post(url, data: data);
    if (response.isOk()) {
      return UserDataMapper.fromJson(response.data);
    }

    return null;
  }

  String getRegistrationUrl() {
    return '$baseUrl$registrationEndpoint';
  }

  dynamic _toJsonRequest(UserRegistration userRegistration) {
    return {
      'first_name': userRegistration.firstName,
      'last_name': userRegistration.lastName,
      'identification_number': userRegistration.identifier,
      'mobile_phone': userRegistration.phone,
      'email': userRegistration.email,
    };
  }
}
