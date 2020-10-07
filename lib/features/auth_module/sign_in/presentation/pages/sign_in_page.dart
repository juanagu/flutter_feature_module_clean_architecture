import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/presentation/responsive/dimens.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '_desktop_sign_in_page.dart';
import '_mobile_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  final Widget signInWidget;

  SignInPage({
    Key key,
    this.signInWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => MobileSignInPage(
        signInWidget: signInWidget,
        welcomeMessage: _getWelcomeMessage(context),
      ),
      desktop: (BuildContext context) => DesktopSignInPage(
        signInWidget: signInWidget,
        welcomeMessage: _getWelcomeMessage(context),
      ),
    );
  }

  Widget _getWelcomeMessage(BuildContext context) {
    var subtitleFontSize = Dimens.of(context)
        .toPoints(Theme.of(context).textTheme.headline5.fontSize);
    return Semantics(
      label: I18n.of(context).translate('sign_in_welcome_message_semantic'),
      excludeSemantics: true,
      child: Text(
        I18n.of(context).translate('sign_in_welcome_message'),
        style: Theme.of(context).textTheme.headline4.copyWith(
              color: Colors.white,
              fontSize: subtitleFontSize,
            ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
