import 'package:app/commons/utils/test_configurations.dart';

class TestDriverTestConfigurations implements TestConfigurations {
  @override
  bool get isIntegration => true;

  @override
  bool get isSimulator => true;
}
