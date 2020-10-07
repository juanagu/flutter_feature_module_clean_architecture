import 'package:app/commons/presentation/widgets/forms/sign_in_form.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_widgets/test_widgets_helper.dart';

void main() {
  Future pumpSignInForm(WidgetTester tester) async {
    await TestWidgetsHelper.pumpIntoMaterialApp(
      tester,
      SignInForm(
        passwordRequiredMessageText: 'password_is_required',
        passwordText: 'password',
        signInButtonText: 'sign_in',
        usernameRequiredMessageText: 'username_is_required',
        usernameText: 'username',
      ),
    );
  }

  group('sign_in_form: accessibility test', () {
    testWidgets('sign_in_form: contrast accessibility',
        (WidgetTester tester) async {
      await pumpSignInForm(tester);
      await expectLater(
        tester,
        meetsGuideline(textContrastGuideline),
      );
    });

    testWidgets('sign_in_form: androidTapTargetGuideline accessibility',
        (WidgetTester tester) async {
      await pumpSignInForm(tester);
      await expectLater(
        tester,
        meetsGuideline(androidTapTargetGuideline),
      );
    });

    testWidgets('sign_in_form: iOSTapTargetGuideline accessibility',
        (WidgetTester tester) async {
      await pumpSignInForm(tester);
      await expectLater(
        tester,
        meetsGuideline(iOSTapTargetGuideline),
      );
    });
  });
}
