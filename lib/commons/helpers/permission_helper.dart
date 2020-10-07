abstract class PermissionHelper {
  Future<PermissionStatus> request(Permission requestPermission);

  Future openAppSettings();
}

enum Permission {
  Camera,
}

enum PermissionStatus {
  Undetermined,
  Denied,
  Granted,
  Restricted,
  PermanentlyDenied,
}

class GrantedPermissionHelper implements PermissionHelper {
  @override
  Future openAppSettings() {
    return Future.delayed(Duration(milliseconds: 250));
  }

  @override
  Future<PermissionStatus> request(Permission requestPermission) {
    return Future.value(PermissionStatus.Granted);
  }
}
