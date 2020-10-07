import 'dart:io';
import 'package:flutter/foundation.dart';

abstract class EnvironmentConfiguration {
  static String _baseUrl;
  static String _appName;

  static String get appName => _getVariable('APP_NAME', _appName);
  static String get baseUrl => _getVariable('BASE_URL', _baseUrl);

  static String _getVariable(String key, String defaultValue) {
    if (kIsWeb) {
      return defaultValue;
    }

    var variable = Platform.environment[key];
    if (variable != null && variable.isNotEmpty) {
      return variable;
    }

    return defaultValue;
  }

  static void init(Flavor flavor) {
    switch (flavor) {
      case Flavor.Dev:
        _baseUrl = 'https://endpoint_url.com';
        _appName = 'AppName';
        break;
    }
  }
}

enum Flavor { Dev }
