import 'package:app/commons/helpers/session_storage_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorageHelper implements SessionStorageHelper {
  @override
  Future<int> getInt(String key) async {
    return (await _getDynamic(key)) as int;
  }

  @override
  Future<String> getString(String key) async {
    return (await _getDynamic(key)) as String;
  }

  @override
  Future<void> setInt(String key, int value) async {
    var instance = await _getInstance();
    await instance.setInt(key, value);
  }

  @override
  Future<void> setString(String key, String value) async {
    var instance = await _getInstance();
    await instance.setString(key, value);
  }

  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  Future<dynamic> _getDynamic(String key) async {
    var instance = await _getInstance();
    return instance.get(key);
  }
}
