import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class TestDriverUtils {
  static Future<bool> isPresent(
      SerializableFinder byValueKey, FlutterDriver driver,
      {Duration timeout = const Duration(seconds: 1)}) async {
    try {
      await driver.waitFor(byValueKey, timeout: timeout);
      return true;
    } catch (exception) {
      return false;
    }
  }

  static Future checkHealthStatus(FlutterDriver driver) async {
    var health = await driver.checkHealth();
    expect(health.status, HealthStatus.ok);
  }

  static Future takeScreenshot(
    FlutterDriver driver,
    String path,
    String fileName,
  ) async {
    const basePath = 'screenshots/';

    var dirPath = '$basePath$path';
    if (!await File(dirPath).exists()) {
      await Directory(dirPath).create(recursive: true);
    }

    final pixels = await driver.screenshot();
    var fullPath = '$dirPath$fileName';
    final file = File(fullPath);
    await file.writeAsBytes(pixels);
    print('takeScreenshot on $fullPath');
  }
}
