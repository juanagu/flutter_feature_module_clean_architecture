import 'package:app/commons/helpers/oauth_helper.dart';
import 'package:app/commons/helpers/session_storage_helper.dart';

class SharedPreferencesOAuthHelper implements OAuthHelper {
  final SessionStorageHelper sessionStorageHelper;
  final String _oAuthTokenKey = 'oauth_token';

  SharedPreferencesOAuthHelper(this.sessionStorageHelper);

  @override
  Future<void> clear() {
    return sessionStorageHelper.setString(_oAuthTokenKey, '');
  }

  @override
  Future<String> getToken() {
    return sessionStorageHelper.getString(_oAuthTokenKey);
  }

  @override
  Future<void> saveToken(String token) {
    return sessionStorageHelper.setString(_oAuthTokenKey, token);
  }
}
