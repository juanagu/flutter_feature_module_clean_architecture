import 'package:app/apps/default/base_material_app.dart';
import 'package:app/commons/presentation/themes/themes.dart';
import 'package:app/feature_module/module.dart';
import 'package:flutter/material.dart';

import 'custom_app_themes.dart';

class EngineAdminApplication extends StatelessWidget {
  final String title;
  final bool isTest;
  final List<Module> modules;
  final CustomAppThemes theme;
  final String defaultLanguageCode;

  const EngineAdminApplication({
    Key key,
    this.title,
    this.isTest = false,
    @required this.modules,
    @required this.theme,
    @required this.defaultLanguageCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseMaterialApp(
      title: title,
      light: theme.light(),
      dark: Themes.dark,
      isTest: isTest,
      modules: modules,
      defaultLanguageCode: defaultLanguageCode,
    );
  }
}
