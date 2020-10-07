import 'package:app/feature_module/feature.dart';
import 'package:app/features/auth_module/user_session/presentation/widgets/user_session_welcome_and_logout.dart';
import 'package:app/ioc/injector.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc.dart';
import 'pages/index_page.dart';
import 'widgets/user_session_logout_main_widget.dart';

class UserSessionFeature implements Feature {
  static const String key = 'UserSessionFeature';
  static const String Route = '/';

  Widget buildMainWidget(Function onSuccessLogout) {
    return UserSessionLogoutMainWidget(
      bloc: Injector.getInstance().resolve<UserSessionBloc>(),
      onSuccessLogout: onSuccessLogout,
    );
  }

  Widget buildUserMenu(
    BuildContext context,
    Function onSuccessLogout,
    String userLoggedFullName,
  ) {
    var primaryTextColor =
        Theme.of(context).primaryColor.computeLuminance() > 0.5
            ? Colors.black
            : Colors.white;

    return UserSessionWelcomeAndLogout(
      logoutWidget: buildMainWidget(onSuccessLogout),
      userLoggedEmail: userLoggedFullName,
      primaryTextColor: primaryTextColor,
    );
  }

  @override
  Widget build(onResult, {arguments}) {
    return IndexPage(
      bloc: Injector.getInstance().resolve<UserSessionBloc>(),
      onValidSession: (context) => onResult(UserSessionValidResult(
        context,
        null,
      )),
      onInvalidSession: (context) =>
          onResult(UserSessionInvalidResult(context)),
    );
  }

  @override
  Future<void> register(Injector injector) async {}
}

class UserSessionValidResult extends FeatureResult {
  UserSessionValidResult(BuildContext context, data) : super(context, data);
}

class UserSessionInvalidResult extends FeatureResult {
  UserSessionInvalidResult(BuildContext context) : super(context, null);
}
