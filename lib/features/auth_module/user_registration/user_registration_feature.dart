import 'package:app/commons/helpers/connectivity_helper.dart';
import 'package:app/commons/helpers/http_helper.dart';
import 'package:app/commons/helpers/oauth_helper.dart';
import 'package:app/core/domain/entities/user.dart';
import 'package:app/feature_module/feature.dart';
import 'package:app/features/auth_module/user_registration/data/remote/user_registration_remote_repository.dart';
import 'package:app/features/auth_module/user_registration/domain/repositories/user_registration_repository.dart';
import 'package:app/features/auth_module/user_registration/presentation/bloc/user_registration_bloc.dart';
import 'package:app/features/auth_module/user_registration/presentation/widgets/user_registration_form.dart';
import 'package:flutter/material.dart';
import 'package:app/ioc/injector.dart';

import 'presentation/pages/user_registration_page.dart';

class UserRegistrationFeature implements Feature {
  static const String key = 'UserRegistrationFeature';
  static const String Route = '/auth/registration';

  @override
  Widget build(onResult, {arguments}) {
    return UserRegistrationPage(
      buildForm: _buildForm,
    );
  }

  Widget _buildForm() {
    var injector = Injector.getInstance();
    return UserRegistrationForm(
      onSuccess: _onSuccessRegistration,
      bloc: UserRegistrationBloc(
        injector.resolve<UserRegistrationRepository>(),
      ),
      connectivityHelper: injector.resolve<ConnectivityHelper>(),
    );
  }

  @override
  Future<void> register(Injector injector) async {
    injector.registerFactory<UserRegistrationRepository>(
      () => UserRegistrationRemoteRepository(
        injector.resolveByName('baseUrl'),
        injector.resolve<HttpHelper>(),
        injector.resolve<OAuthHelper>(),
      ),
    );
  }

  void _onSuccessRegistration(BuildContext context, User user) {
    Navigator.of(context).pop(user);
  }
}
