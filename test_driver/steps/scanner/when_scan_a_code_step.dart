import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class WhenScanACodeStep extends When1WithWorld<String, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'I scan a code {string}$');

  @override
  Future<void> executeStep(String code) async {
    await world.driver.tap(find.byValueKey('scanner_input'));
    await world.driver.enterText(code);
    await world.driver.tap(find.byValueKey('scanner_input_button'));
  }
}
