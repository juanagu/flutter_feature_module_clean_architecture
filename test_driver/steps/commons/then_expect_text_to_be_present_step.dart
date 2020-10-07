import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ThenExpectTextToBePresentStep
    extends When2WithWorld<String, int, FlutterWorld> {
  @override
  RegExp get pattern => RegExp(
      r'I expect the text {string} to be present within {int} second(s)$');
  @override
  Future<void> executeStep(String text, int seconds) async {
    final isPresent = await FlutterDriverUtils.isPresent(
      world.driver,
      find.text(text),
      timeout: Duration(seconds: seconds),
    );
    expect(isPresent, true);
  }
}
