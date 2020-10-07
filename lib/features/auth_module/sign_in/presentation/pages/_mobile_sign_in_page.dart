import 'package:app/apps/default/i18n.dart';
import 'package:app/commons/presentation/decorators/gradient_generator.dart';
import 'package:app/commons/presentation/responsive/dimens.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MobileSignInPage extends StatelessWidget {
  final Widget signInWidget;
  final Widget welcomeMessage;
  const MobileSignInPage({
    Key key,
    @required this.signInWidget,
    @required this.welcomeMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => _buildMobile(context),
      tablet: (context) => _buildTablet(context),
    );
  }

  Widget _buildMobile(BuildContext context) {
    var signInFormHorizontalPadding = MediaQuery.of(context).size.width * 0.1;

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _buildBackground(
              context,
            ),
          ),
          Align(
            child: _buildSignInForm(context, signInFormHorizontalPadding),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  Widget _buildTablet(BuildContext context) {
    var paddingMessage = Dimens.of(context).toPoints(32.0);
    var signInFormHorizontalPadding = MediaQuery.of(context).size.width * 0.2;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _buildBackground(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: paddingMessage,
                    bottom: paddingMessage,
                  ),
                  child: welcomeMessage,
                ),
                _buildSignInForm(context, signInFormHorizontalPadding),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    return GradientGenerator.buildBackground(context);
  }

  Widget _buildSignInForm(BuildContext context, double horizontalPadding) {
    var dimens = Dimens.of(context);
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: dimens.toPoints(24.0),
          ),
          SizedBox(
            height: dimens.toPoints(8.0),
          ),
          Text(
            '${I18n.of(context).translate('welcome')}!',
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: signInWidget,
          ),
          SizedBox(
            height: dimens.toPoints(24.0),
          ),
        ],
      ),
    );
  }
}
