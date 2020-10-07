import 'package:app/commons/helpers/connectivity_helper.dart';
import 'package:app/feature_module/feature.dart';
import 'package:app/features/auth_module/user_session/presentation/user_session_feature.dart';
import 'package:app/ioc/injector.dart';
import 'package:flutter/material.dart';

import 'presentation/pages/sign_in_page.dart';
import 'presentation/widgets/sign_in_main_widget.dart';
import 'presentation/bloc/bloc.dart';

class SignInFeature implements Feature {
  static const String key = 'SignInFeature';
  static const Route = '/auth/signin';

  Widget _buidlSignInForm(SignInSuccess signInSuccess) {
    var injector = Injector.getInstance();
    return SignInMainWidget(
      signInBloc: injector.resolve<SignInBloc>(),
      connectivityHelper: injector.resolve<ConnectivityHelper>(),
      signInSuccess: signInSuccess,
    );
  }

  @override
  Widget build(onResult, {arguments}) {
    return SignInPage(
      signInWidget: _buidlSignInForm(
        (context, user) => onResult(
          UserSessionValidResult(
            context,
            user.username,
          ),
        ),
      ),
    );
  }

  @override
  Future<void> register(Injector injector) async {}
}
