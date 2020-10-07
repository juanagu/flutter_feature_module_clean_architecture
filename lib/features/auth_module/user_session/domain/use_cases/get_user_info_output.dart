import 'package:app/features/auth_module/core/domain/entities/user_info.dart';

class GetUserInfoOutput {
  final UserInfo userInfo;

  GetUserInfoOutput(this.userInfo);

  bool isValid() {
    return userInfo != null;
  }

  static GetUserInfoOutput notUserLogged() {
    return GetUserInfoOutput(null);
  }

  static GetUserInfoOutput notFound() {
    return GetUserInfoOutput(null);
  }

  static GetUserInfoOutput byResult(UserInfo company) {
    if (company == null) {
      return GetUserInfoOutput.notFound();
    }

    return GetUserInfoOutput(company);
  }
}
