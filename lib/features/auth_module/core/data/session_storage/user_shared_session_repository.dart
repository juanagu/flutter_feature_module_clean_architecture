import 'dart:convert';

import 'package:app/commons/helpers/oauth_helper.dart';
import 'package:app/commons/helpers/session_storage_helper.dart';
import 'package:app/features/auth_module/core/domain/entities/user_logged.dart';
import 'package:app/features/auth_module/sign_in/data/mappers/user_mapper.dart';
import 'package:app/features/auth_module/core/domain/respositories/user_session_repository.dart';

class UserSharedSessionRepository implements UserSessionRepository {
  static const userKey = 'user_logged';
  final SessionStorageHelper sessionStorageHelper;
  final OAuthHelper _oAuthHelper;

  UserSharedSessionRepository(
    this.sessionStorageHelper,
    this._oAuthHelper,
  );

  @override
  Future<UserLogged> get() async {
    var userJson = await sessionStorageHelper.getString(userKey);
    if (userJson != null && userJson.isNotEmpty) {
      var json = jsonDecode(userJson);
      return UserMapper.fromJson(json);
    }

    return null;
  }

  @override
  Future<bool> save(UserLogged user) async {
    if (user != null) {
      var userJson = jsonEncode(UserMapper.toJson(user));
      await sessionStorageHelper.setString(userKey, userJson);
      return true;
    }

    return false;
  }

  @override
  Future logout() async {
    await sessionStorageHelper.setString(userKey, null);
    await _oAuthHelper.clear();
  }
}
