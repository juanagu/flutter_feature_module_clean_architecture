import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import '../../data/user_credential_test_data.dart';

class GivenAUserLoggedStep extends GivenWithWorld<FlutterWorld> {
  GivenAUserLoggedStep();

  @override
  RegExp get pattern => RegExp(r'I have a user logged');
  @override
  Future<void> executeStep() async {
    final welcomeLabelFinder = find.byValueKey('welcome_label');

    final isLogged =
        await FlutterDriverUtils.isPresent(world.driver, welcomeLabelFinder);

    if (!isLogged) {
      await world.driver.tap(find.byValueKey('sign_in_username'));
      await world.driver.enterText(UserCredentialTestData.username);

      await world.driver.tap(find.byValueKey('sign_in_password'));
      await world.driver.enterText(UserCredentialTestData.password);

      await world.driver.tap(find.byValueKey('sign_in_button'));
      await world.driver.waitFor(
        welcomeLabelFinder,
        timeout: Duration(
          seconds: 10,
        ),
      );
    }
  }
}
