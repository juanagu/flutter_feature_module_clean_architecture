import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenAnAppWithoutSessionStep extends GivenWithWorld<FlutterWorld> {
  @override
  RegExp get pattern => RegExp(r'I have an app without session');

  @override
  Future<void> executeStep() async {
    final welcomeLabelFinder = find.byType('welcome_label');
    final isLogged =
        await FlutterDriverUtils.isPresent(world.driver, welcomeLabelFinder);
    if (isLogged) {
      await world.driver.tap(find.byValueKey('logout_button'));
      await world.driver.tap(find.byValueKey('logout_accept_button'));
      await world.driver.waitFor(find.byValueKey('sign_in_username'),
          timeout: Duration(
            seconds: 2,
          ));
    }
  }
}
