import 'package:app/base_main.dart';

import 'infrastructure/environments/environment_configuration.dart';

void main({
  bool isTest = false,
  Function afterInit,
}) async {
  buildAndRunApp(
    flavor: Flavor.Dev,
    isTest: isTest,
    afterInit: afterInit,
  );
}
