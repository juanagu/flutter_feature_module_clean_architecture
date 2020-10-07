import 'package:app/apps/default/i18n.dart';
import 'package:flutter/material.dart';

class UserSessionWelcomeAndLogout extends StatelessWidget {
  final String userLoggedEmail;
  final Color primaryTextColor;
  final Widget logoutWidget;

  const UserSessionWelcomeAndLogout({
    Key key,
    this.userLoggedEmail,
    this.primaryTextColor = Colors.white,
    this.logoutWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(
        left: 32.0,
        top: 16.0,
        right: 16.0,
        bottom: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildUserInfo(context),
          logoutWidget,
        ],
      ),
    ));
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          I18n.of(context).translate('welcome'),
          key: Key('welcome_label'),
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: primaryTextColor.withOpacity(0.7)),
        ),
        Text(userLoggedEmail,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: primaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ))
      ],
    );
  }
}
