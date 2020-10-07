import 'package:app/commons/helpers/app_version_info.dart';
import 'package:app/commons/helpers/connectivity_helper.dart';
import 'package:app/commons/helpers/date_format_helper.dart';
import 'package:app/commons/helpers/error_reporter.dart';
import 'package:app/commons/helpers/event_bus_helper.dart';
import 'package:app/commons/helpers/http_helper.dart';
import 'package:app/commons/helpers/logger.dart';
import 'package:app/commons/helpers/oauth_helper.dart';
import 'package:app/commons/helpers/permission_helper.dart';
import 'package:app/commons/helpers/remote_config.dart';
import 'package:app/commons/helpers/session_storage_helper.dart';
import 'package:app/commons/helpers/url_helper.dart';
import 'package:app/commons/presentation/utils/shimmer_factory.dart';
import 'package:app/infrastructure/environments/environment_configuration.dart';
import 'package:app/infrastructure/firebase/firebase_error_reporter.dart';
import 'package:app/infrastructure/firebase/firebase_remote_config.dart';
import 'package:app/infrastructure/libraries/helpers/app_package_version_info.dart';
import 'package:app/infrastructure/libraries/helpers/dart_date_format_helper.dart';
import 'package:app/infrastructure/libraries/helpers/dart_event_bus.dart';
import 'package:app/infrastructure/libraries/helpers/dio_http_helper.dart';
import 'package:app/infrastructure/libraries/helpers/flutter_connectivity_helper.dart';
import 'package:app/infrastructure/libraries/helpers/flutter_logger_impl.dart';
import 'package:app/infrastructure/libraries/helpers/launcher_url_helper.dart';
import 'package:app/infrastructure/libraries/helpers/mobile_permission_helper.dart';
import 'package:app/infrastructure/libraries/helpers/shared_preferences_oauth_helper.dart';
import 'package:app/infrastructure/libraries/helpers/shared_preferences_storage_helper.dart';
import 'package:app/infrastructure/libraries/utils/flutter_shimmer_factory.dart';
import 'package:app/ioc/injection_manager.dart';
import 'package:app/ioc/injector.dart';

class CommonInjectionManager implements InjectionManager {
  @override
  Future<void> register(Injector injector) async {
    _registerEnvironmentsConfiguration(injector);

    injector.registerLazySingleton<ErrorReporter>(
      () => FirebaseErrorReporter(),
    );
    injector.registerLazySingleton<Logger>(
      () => FlutterLoggerImpl(),
    );

    injector.registerLazySingleton<SessionStorageHelper>(
      () => SharedPreferencesStorageHelper(),
    );

    injector.registerLazySingleton<OAuthHelper>(
      () => SharedPreferencesOAuthHelper(
          injector.resolve<SessionStorageHelper>()),
    );

    _injectHttpHelper(injector);
    injector.registerLazySingleton<DateFormatHelper>(
      () => DartDateFormatHelper(),
    );
    injector.registerLazySingleton<EventBusHelper>(
      () => DartEventBus(),
    );

    injector.registerFactory<ShimmerFactory>(() => FlutterShimmerFactory());

    injector.registerFactory<PermissionHelper>(() => MobilePermissionHelper());
    injector.registerLazySingleton<RemoteConfig>(() => FirebaseRemoteConfig());
    injector.registerFactory<ConnectivityHelper>(
      () => FlutterConnectivityHelper(),
    );

    var appVersionInfo = await AppPackageVersionInfo.init();
    injector.registerSingleton<AppVersionInfo>(appVersionInfo);

    injector.registerFactory<UrlHelper>(() => LauncherUrlHelper());
  }

  void _injectHttpHelper(Injector injector) {
    injector.registerLazySingleton<HttpHelper>(
      () => DioHttpHelper(injector.resolve<OAuthHelper>()),
    );
  }

  void _registerEnvironmentsConfiguration(Injector injector) {
    injector.registerFactoryByName(
      () => EnvironmentConfiguration.baseUrl,
      'baseUrl',
    );
  }
}
