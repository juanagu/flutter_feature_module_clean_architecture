import 'package:app/features/auth_module/user_session/presentation/bloc/bloc.dart';
import 'package:app/features/auth_module/user_session/presentation/bloc/user_session_bloc.dart';
import 'package:app/ioc/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SimpleHeaderProfileMenu extends StatelessWidget {
  const SimpleHeaderProfileMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              FlutterIcons.person_outline_mdi,
              color: Theme.of(context).accentColor,
              size: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: _buildUserLoggedName(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserLoggedName(BuildContext context) {
    return BlocBuilder<UserSessionBloc, UserSessionState>(
      cubit: Injector.getInstance().resolve<UserSessionBloc>()
        ..add(CheckSession()),
      builder: (context, state) {
        if (state is ValidSession) {
          return Text(
            state.userInfo.fullName,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.bold),
          );
        }

        return Container();
      },
    );
  }
}
