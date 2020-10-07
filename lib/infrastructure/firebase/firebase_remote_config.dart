import 'dart:convert' as json;
import 'package:app/commons/helpers/remote_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart'
    as remoteconfig;

class FirebaseRemoteConfig implements RemoteConfig {
  remoteconfig.RemoteConfig _remoteConfig;

  @override
  Future<bool> getBoolValue(
    String key,
    bool defaultValue,
  ) async {
    await _init();
    var value = _remoteConfig.getBool(key);

    if (value != null) return value;
    return defaultValue;
  }

  @override
  Future<Map<String, dynamic>> getMap(
      String key, Map<String, dynamic> defaultValues) async {
    await _init();
    var value = _remoteConfig.getValue(key);
    if (value != null) {
      return json.jsonDecode(value.asString());
    }

    return defaultValues;
  }

  Future<void> _init() async {
    if (_remoteConfig == null) {
      _remoteConfig = await remoteconfig.RemoteConfig.instance;
      await _remoteConfig.fetch(
        expiration: Duration(minutes: 1),
      );
      await _remoteConfig.activateFetched();
    }
  }
}
