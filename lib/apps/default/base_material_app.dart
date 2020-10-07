import 'package:app/commons/presentation/themes/themes.dart';
import 'package:app/core/presentation/pages/not_found_page.dart';
import 'package:app/feature_module/module.dart';
import 'package:app/features/auth_module/auth_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i18n.dart';

class BaseMaterialApp extends StatelessWidget {
  final String title;
  final ThemeData light;
  final ThemeData dark;
  final String initialRoute;
  final bool isTest;
  final List<Module> modules;
  final String defaultLanguageCode;

  BaseMaterialApp({
    Key key,
    this.title = '',
    this.light,
    this.dark,
    this.initialRoute,
    this.isTest = false,
    @required this.modules,
    @required this.defaultLanguageCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _initialRoute = initialRoute ?? AuthModule.Index;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      title: title,
      themeMode: ThemeMode.light,
      theme: light ?? Themes.light,
      darkTheme: dark ?? Themes.dark,
      initialRoute: _initialRoute,
      routes: _generateRoutes(),
      onUnknownRoute: (settings) => _onUnknownRoute(
        settings,
        _initialRoute,
      ),
      localizationsDelegates: [
        AppLocalizationsDelegate(
          isTest: isTest,
          defaultLanguageCode: defaultLanguageCode,
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es'),
        const Locale('pt'),
      ],
    );
  }

  static Widget buildTestWidgetApp(
    Widget widget,
    ThemeData theme,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test App',
      themeMode: ThemeMode.light,
      theme: theme ?? Themes.light,
      home: Scaffold(body: widget),
      localizationsDelegates: [
        AppLocalizationsDelegate(isTest: true),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es'),
        const Locale('pt'),
      ],
    );
  }

  Map<String, WidgetBuilder> _generateRoutes() {
    var routes = <String, WidgetBuilder>{};
    modules.forEach((element) => routes.addAll(element.routes()));
    return routes;
  }

  Route _onUnknownRoute(
    RouteSettings settings,
    String initialRoute,
  ) {
    return MaterialPageRoute(
      builder: (_) => NotFoundPage(
        initialRoute: initialRoute,
      ),
    );
  }
}
