import 'package:app/apps/default/base_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class TestWidgetsHelper {
  static Future pumpIntoMaterialApp(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      BaseMaterialApp.buildTestWidgetApp(widget, null),
    );
    await tester.pump(Duration(seconds: 1));
  }
}
