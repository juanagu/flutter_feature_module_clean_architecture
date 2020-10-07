import 'package:app/apps/default/i18n.dart';
import 'package:app/features/auth_module/user_session/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

class UserSessionHelper {
  final UserSessionBloc userSessionBloc;

  UserSessionHelper(this.userSessionBloc);

  void logout(BuildContext context) {
    var alert = AlertDialog(
      key: Key('ask_to_confirm_sign_off'),
      title: Text(
        I18n.of(context).translate('ask_to_confirm_sign_off'),
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: [
        FlatButton(
          child: Text(
            I18n.of(context).translate('cancel_sign_off').toUpperCase(),
            style: Theme.of(context).textTheme.button.copyWith(
                  color: Theme.of(context).accentColor,
                ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          key: Key('logout_accept_button'),
          child: Text(
            I18n.of(context).translate('accept_sign_off').toUpperCase(),
            style: Theme.of(context).textTheme.button.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          onPressed: () => userSessionBloc.add(Logout()),
        ),
      ],
    );

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
