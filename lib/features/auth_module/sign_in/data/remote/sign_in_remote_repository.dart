import 'package:app/commons/helpers/http_helper.dart';
import 'package:app/commons/helpers/oauth_helper.dart';
import 'package:app/features/auth_module/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:app/features/auth_module/sign_in/domain/value_objects/user_auth.dart';
import 'package:app/features/auth_module/sign_in/domain/value_objects/user_credential.dart';

import 'sign_in_input_dto.dart';
import 'sign_in_response_dto.dart';

class SignInRemoteRepository implements SignInRepository {
  final String baseUrl;
  final HttpHelper httpHelper;
  final OAuthHelper oAuthHelper;

  static const String signInEndpoint = 'login/company';

  SignInRemoteRepository(
    this.baseUrl,
    this.httpHelper,
    this.oAuthHelper,
  );

  @override
  Future<UserAuth> authorize(UserCredential userCredential) async {
    var url = getSignInUrl();
    var json = SignInInputDto.fromUserCredential(userCredential).toJson();
    var response = await httpHelper.post(url, data: json);
    if (response.isOk()) {
      var userAuth = SignInResponseDto.fromJson(response.data).toAuth();
      if (userAuth.isValid()) {
        await oAuthHelper.saveToken(userAuth.token);
        return userAuth;
      }
    }

    return null;
  }

  String getSignInUrl() => '$baseUrl/$signInEndpoint';
}
