import 'package:app/features/auth_module/sign_in/presentation/widgets/sign_in_main_widget.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/auth_module/sign_in/presentation/bloc/bloc.dart';
import '../../../../commons/test_widgets/test_widgets_helper.dart';

class SignInBlockMock extends MockBloc<SignInState> implements SignInBloc {}

void main() {
  testWidgets('sign in widget: contrast accessibility',
      (WidgetTester tester) async {
    await pumpSignInWidget(tester);
    await expectLater(
      tester,
      meetsGuideline(textContrastGuideline),
    );
  });

  testWidgets('sign in widget: androidTapTargetGuideline accessibility',
      (WidgetTester tester) async {
    await pumpSignInWidget(tester);
    await expectLater(
      tester,
      meetsGuideline(androidTapTargetGuideline),
    );
  });

  testWidgets('sign in widget: iOSTapTargetGuideline accessibility',
      (WidgetTester tester) async {
    await pumpSignInWidget(tester);
    await expectLater(
      tester,
      meetsGuideline(iOSTapTargetGuideline),
    );
  });
}

Future pumpSignInWidget(WidgetTester tester) async {
  await TestWidgetsHelper.pumpIntoMaterialApp(
    tester,
    SignInMainWidget(
      signInBloc: SignInBlockMock(),
    ),
  );
}
