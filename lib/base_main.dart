import 'package:app/commons/presentation/themes/default_theme_properties.dart';
import 'package:app/apps/custom_app/custom_app_themes.dart';
import 'package:app/apps/custom_app/custom_app_application.dart';
import 'package:app/apps/custom_app/main_injection_manager.dart';
import 'package:app/feature_module/module.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'commons/presentation/responsive/dimens.dart';
import 'features/auth_module/auth_module.dart';
import 'infrastructure/environments/environment_configuration.dart';
import 'ioc/injector.dart';

final List<Module> modules = [
  AuthModule(),
];

void buildAndRunApp({
  Flavor flavor = Flavor.Dev,
  bool isTest,
  Function afterInit,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(flavor);
  onAfterInit(afterInit);
  setupOrientation();
  GestureBinding.instance.resamplingEnabled = true;

  runApp(
    buildApp(
      isTest: isTest,
      defaultLanguageCode: _getLanguageByFlavor(flavor),
    ),
  );
}

String _getLanguageByFlavor(Flavor flavor) {
  switch (flavor) {
    default:
      return 'es';
  }
}

void onAfterInit(Function afterInit) {
  if (afterInit != null) {
    afterInit();
  }
}

EngineAdminApplication buildApp({
  @required bool isTest,
  @required String defaultLanguageCode,
}) {
  return EngineAdminApplication(
    title: EnvironmentConfiguration.appName,
    isTest: isTest,
    modules: modules,
    theme: CustomAppThemes.instance,
    defaultLanguageCode: defaultLanguageCode,
  );
}

Future<void> init(Flavor flavor) async {
  EnvironmentConfiguration.init(flavor);
  _createThemeByFlavor(flavor);
  _setBreakpoints();
  _inject();
}

void _createThemeByFlavor(Flavor flavor) {
  switch (flavor) {
    case Flavor.Dev:
      CustomAppThemes.create(DefaultThemeProperties());
      break;
  }
}

void _inject() async {
  await MainInjectionManager(modules).register(Injector.getInstance());
}

void _setBreakpoints() {
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    ScreenBreakpoints(
      desktop: Dimens.desktopBreakpoint,
      tablet: Dimens.mobileScreenBreakpoint,
      watch: 150,
    ),
  );
}

void setupOrientation() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}
