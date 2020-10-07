import 'package:app/commons/presentation/widgets/buttons/primary_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_widgets/test_widgets_helper.dart';

void main() {
  Future pumpPrimaryButton(WidgetTester tester, PrimaryButton button) async {
    await TestWidgetsHelper.pumpIntoMaterialApp(tester, button);
  }

  Future pumpBasicPrimaryButton(WidgetTester tester) {
    return pumpPrimaryButton(
      tester,
      PrimaryButton(
        titleText: 'Button',
        onPressed: () => {},
      ),
    );
  }

  group('primary_button: accessibility test', () {
    testWidgets('primary_button: contrast accessibility',
        (WidgetTester tester) async {
      await pumpBasicPrimaryButton(tester);
      await expectLater(
        tester,
        meetsGuideline(textContrastGuideline),
      );
    });

    testWidgets('primary_button: androidTapTargetGuideline accessibility',
        (WidgetTester tester) async {
      await pumpBasicPrimaryButton(tester);
      await expectLater(
        tester,
        meetsGuideline(androidTapTargetGuideline),
      );
    });

    testWidgets('primary_button: iOSTapTargetGuideline accessibility',
        (WidgetTester tester) async {
      await pumpBasicPrimaryButton(tester);
      await expectLater(
        tester,
        meetsGuideline(iOSTapTargetGuideline),
      );
    });
  });

  group('primary_button tests', () {
    testWidgets('primary_button: test title ',
        (WidgetTester tester) async {
      final titleText = 'title_test';
      var primaryButton = PrimaryButton(
        titleText: titleText,
      );
      await pumpPrimaryButton(tester, primaryButton);
      final buttonTitleFinder = find.text(titleText);
      expect(buttonTitleFinder, findsOneWidget);
    });

    testWidgets('primary_button: test onPressed', (WidgetTester tester) async {
      var testIfPressedIsCalled = false;

      final titleText = 'title_test';
      var primaryButton = PrimaryButton(
        titleText: titleText,
        onPressed: () => {testIfPressedIsCalled = true},
      );

      await pumpPrimaryButton(tester, primaryButton);
      expect(testIfPressedIsCalled, false);
      await tester.tap(find.byWidget(primaryButton));
      expect(testIfPressedIsCalled, true);
    });
  });
}
