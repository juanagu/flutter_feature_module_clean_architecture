abstract class SessionStorageHelper {
  Future<void> setString(String key, String value);

  Future<String> getString(String key);

  Future<void> setInt(String key, int value);

  Future<int> getInt(String key);
}
