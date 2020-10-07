import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/presentation/decorators/gradient_generator.dart';
import 'package:app/commons/presentation/responsive/dimens.dart';
import 'package:flutter/material.dart';

class DesktopSignInPage extends StatelessWidget {
  final Widget signInWidget;
  final Widget welcomeMessage;

  const DesktopSignInPage({
    Key key,
    @required this.signInWidget,
    @required this.welcomeMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    var position = Dimens.of(context).toPoints(54.0);

    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              GradientGenerator.buildBackground(context),
              Positioned(
                bottom: position,
                left: position,
                child: welcomeMessage,
              ),
            ],
          ),
        ),
        _buildSignInForm(context),
      ],
    );
  }

  Container _buildSignInForm(
    BuildContext context, {
    Color backgroundColor = Colors.transparent,
    double width = 650.0,
    double height,
  }) {
    const padding = EdgeInsets.only(left: 24.0);
    return Container(
      height: height,
      width: width,
      color: backgroundColor,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimens.of(context).toPoints(64.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32.0),
            Padding(
              padding: padding,
              child: Text(
                '${I18n.of(context).translate('welcome')}!',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            signInWidget,
          ],
        ),
      ),
    );
  }
}
