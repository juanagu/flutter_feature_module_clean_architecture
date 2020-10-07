import 'package:app/commons/helpers/app_version_info.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';

class AppPackageVersionInfo implements AppVersionInfo {
  final PackageInfo packageInfo;

  AppPackageVersionInfo(this.packageInfo);

  @override
  String get version => packageInfo.version;

  @override
  String get buildNumber => packageInfo.buildNumber;

  static Future<AppVersionInfo> init() async {
    if (kIsWeb) {
      return WebVersionInfo();
    }

    var packageInfo = await PackageInfo.fromPlatform();
    return AppPackageVersionInfo(packageInfo);
  }
}

class WebVersionInfo implements AppVersionInfo {
  @override
  String get version => '1.0.0';

  @override
  String get buildNumber => '1.0.0';
}
