import 'package:app/feature_module/feature.dart';
import 'package:app/feature_module/module.dart';
import 'package:app/features/auth_module/sign_in/sign_in_feature.dart';
import 'package:app/features/auth_module/user_registration/user_registration_feature.dart';
import 'package:flutter/material.dart';
import 'user_session/presentation/user_session_feature.dart';
import 'package:app/commons/helpers/http_helper.dart';
import 'package:app/commons/helpers/oauth_helper.dart';
import 'package:app/commons/helpers/session_storage_helper.dart';
import 'package:app/features/auth_module/core/data/session_storage/user_shared_session_repository.dart';
import 'package:app/features/auth_module/core/domain/entities/user_session.dart';
import 'package:app/features/auth_module/sign_in/data/remote/sign_in_remote_repository.dart';
import 'package:app/features/auth_module/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:app/features/auth_module/core/domain/respositories/user_session_repository.dart';
import 'package:app/features/auth_module/sign_in/domain/use_cases/implementation/sign_in_imp_use_case.dart';
import 'package:app/features/auth_module/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:app/features/auth_module/sign_in/presentation/bloc/bloc.dart';
import 'package:app/features/auth_module/user_session/data/remote/get_company_info_remote_repository.dart';
import 'package:app/features/auth_module/user_session/domain/repositories/find_user_info_repository.dart';
import 'package:app/features/auth_module/user_session/domain/use_cases/get_user_info_use_case.dart';
import 'package:app/features/auth_module/user_session/domain/use_cases/implementation/get_user_info_use_case_impl.dart';
import 'package:app/features/auth_module/user_session/presentation/bloc/user_session_bloc.dart';
import 'package:app/features/auth_module/user_session/presentation/helpers/user_session_helper.dart';
import 'package:app/ioc/injector.dart';

class AuthModule extends Module {
  static const String Index = UserSessionFeature.Route;

  AuthModule()
      : super(
          {
            UserSessionFeature.key: UserSessionFeature(),
            UserRegistrationFeature.key: UserRegistrationFeature(),
            SignInFeature.key: SignInFeature(),
          },
        );

  @override
  Future<void> register(Injector injector) async {
    _registerCore(injector);
    _registerUserSession(injector);
    _registerSignIn(injector);
    _registerGetCompanyInfo(injector);
    await super.register(injector);
  }

  @override
  Map<String, WidgetBuilder> routes() {
    return {
      UserSessionFeature.Route: (context) =>
          getFeatureByKey(UserSessionFeature.key).build(_onResult),
      SignInFeature.Route: (context) =>
          getFeatureByKey(SignInFeature.key).build(_onResult),
      UserRegistrationFeature.Route: (context) =>
          getFeatureByKey(UserRegistrationFeature.key).build(_onResult),
    };
  }

  void _onResult(FeatureResult featureResult) {
    if (featureResult is UserSessionValidResult) {
      _navigateToHome(featureResult.context);
    } else if (featureResult is UserSessionInvalidResult) {
      _navigateToLogin(featureResult.context);
    }
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(SignInFeature.Route, (route) => false);
  }

  void _navigateToHome(BuildContext context) {}

  void _registerCore(Injector injector) {
    injector.registerFactory<UserSessionRepository>(
      () => UserSharedSessionRepository(
        injector.resolve<SessionStorageHelper>(),
        injector.resolve<OAuthHelper>(),
      ),
    );
    injector.registerFactory(
      () => UserSession(
        injector.resolve<UserSessionRepository>(),
      ),
    );
  }

  void _registerUserSession(Injector injector) {
    injector.registerLazySingleton(
      () => UserSessionBloc(
        injector.resolve<GetUserInfoUseCase>(),
        injector.resolve<UserSessionRepository>(),
      ),
    );
    injector.registerFactory(
      () => UserSessionHelper(
        injector.resolve<UserSessionBloc>(),
      ),
    );
  }

  void _registerSignIn(Injector injector) {
    //data
    injector.registerFactory<SignInRepository>(
      () => SignInRemoteRepository(
        injector.resolveByName('baseUrl'),
        injector.resolve<HttpHelper>(),
        injector.resolve<OAuthHelper>(),
      ),
    );
    //domain
    injector.registerFactory<SignInUseCase>(
      () => SignInImpUseCase(
        injector.resolve<SignInRepository>(),
        injector.resolve<UserSession>(),
      ),
    );
    //presentation
    injector.registerFactory(
      () => SignInBloc(injector.resolve<SignInUseCase>()),
    );
  }

  void _registerGetCompanyInfo(Injector injector) {
    //data
    injector.registerFactory<FindUserInfoRepository>(
      () => FindUserInfoRemoteRepository(
        injector.resolveByName('baseUrl'),
        injector.resolve<HttpHelper>(),
      ),
    );
    //domain
    injector.registerFactory<GetUserInfoUseCase>(
      () => GetUserInfoUseCaseImpl(
        injector.resolve<UserSessionRepository>(),
        injector.resolve<FindUserInfoRepository>(),
      ),
    );
  }
}
