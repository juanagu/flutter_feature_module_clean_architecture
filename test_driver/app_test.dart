import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob('./test_driver/features//**.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './test_driver/report.json'),
      FlutterDriverReporter(
        logErrorMessages: true,
        logInfoMessages: true,
        logWarningMessages: true,
      ),
    ]
    ..hooks = [
      AttachScreenshotOnFailedStepHook(),
    ]
    ..stepDefinitions = [
      ThenExpectTextToBePresentStep(),
      GivenAUserLoggedStep(),
      GivenAnAppWithoutSessionStep(),
      WhenScanACodeStep(),
    ]
    ..customStepParameterDefinitions = [
      //ColourParameter(),
    ]
    ..restartAppBetweenScenarios = false
    //..targetAppWorkingDirectory = '../'
    ..targetAppPath = 'test_driver/app.dart'
    ..order = ExecutionOrder.sequential
    // ..buildFlavor = "staging" // uncomment when using build flavor and check android/ios flavor setup see android file android\app\build.gradle
    ..targetDeviceId =
        'all' // uncomment to run tests on all connected devices or set specific device target id
    // ..tagExpression = '@smoke' // uncomment to see an example of running scenarios based on tag expressions
    // ..logFlutterProcessOutput = true // uncomment to see command invoked to start the flutter test app
    // ..verboseFlutterProcessLogs = true // uncomment to see the verbose output from the Flutter process
    // ..flutterBuildTimeout = Duration(minutes: 3) // uncomment to change the default period that flutter is expected to build and start the app within
    // ..runningAppProtocolEndpointUri =
    //     'http://127.0.0.1:51540/bkegoer6eH8=/' // already running app observatory / service protocol uri (with enableFlutterDriverExtension method invoked) to test against if you use this set `restartAppBetweenScenarios` to false
    ..exitAfterTestRun = true;

  return GherkinRunner().execute(config);
}
