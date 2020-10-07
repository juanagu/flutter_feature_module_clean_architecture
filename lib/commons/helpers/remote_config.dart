abstract class RemoteConfig {
  Future<bool> getBoolValue(String key, bool defaultValue);
  Future<Map<String, dynamic>> getMap(
      String key, Map<String, dynamic> defaultValues);
}

class DefaultRemoteConfig implements RemoteConfig {
  @override
  Future<bool> getBoolValue(
    String key,
    bool defaultValue,
  ) {
    return Future.value(defaultValue ?? true);
  }

  @override
  Future<Map<String, dynamic>> getMap(
    String key,
    Map<String, dynamic> defaultValues,
  ) {
    return Future.value(defaultValues ?? {});
  }
}
