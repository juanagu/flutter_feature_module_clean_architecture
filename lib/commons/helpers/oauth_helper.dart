abstract class OAuthHelper {
  Future<void> saveToken(String token);
  Future<String> getToken();
  Future<void> clear();
}
