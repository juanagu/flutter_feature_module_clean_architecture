import 'package:app/commons/helpers/connectivity_helper.dart';
import 'package:app/commons/helpers/permission_helper.dart';
import 'package:app/commons/helpers/remote_config.dart';
import 'package:app/features/auth_module/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:app/features/auth_module/user_session/domain/repositories/find_user_info_repository.dart';
import 'package:app/ioc/injector.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:app/main_dev.dart' as app;
import 'mock_data/repositories/remote/fake_find_user_info_test_driver_repository.dart';
import 'mock_data/repositories/remote/fake_sign_in_test_driver_repository.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  app.main(
    afterInit: registerTestDriverDependencies,
  );
}

void registerTestDriverDependencies() {
  final injector = Injector.getInstance();
  injector.registerFactory<SignInRepository>(
      () => FakeSignInTestDriverRepository());
  injector.registerFactory<FindUserInfoRepository>(
    () => FakeFindUserInfoTestDriverRepository(),
  );
  injector.registerFactory<PermissionHelper>(() => GrantedPermissionHelper());
  injector.registerFactory<RemoteConfig>(() => DefaultRemoteConfig());
  injector
      .registerFactory<ConnectivityHelper>(() => DefaultConnectivityHelper());
}
