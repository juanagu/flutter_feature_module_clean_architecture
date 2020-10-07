import 'package:app/apps/default/i18n.dart';
import 'package:app/features/auth_module/user_session/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class UserSessionLogoutMainWidget extends StatelessWidget {
  final UserSessionBloc bloc;
  final VoidCallback onSuccessLogout;
  final Color iconColor;

  const UserSessionLogoutMainWidget({
    Key key,
    this.bloc,
    this.onSuccessLogout,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => bloc,
      child: BlocConsumer<UserSessionBloc, UserSessionState>(
        cubit: bloc,
        listener: _listenerByState,
        builder: _buildByState,
      ),
    );
  }

  void _onLogoutPressed(BuildContext context) {
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
          onPressed: () => bloc.add(Logout()),
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

  void _listenerByState(BuildContext context, UserSessionState state) {
    if (state is InvalidSession) {
      if (onSuccessLogout != null) {
        onSuccessLogout();
      }
    }
  }

  Widget _buildByState(BuildContext context, UserSessionState state) {
    return IconButton(
      key: Key('logout_button'),
      icon: Icon(
        AntDesign.logout,
        color: iconColor,
      ),
      onPressed: () => _onLogoutPressed(context),
    );
  }
}
