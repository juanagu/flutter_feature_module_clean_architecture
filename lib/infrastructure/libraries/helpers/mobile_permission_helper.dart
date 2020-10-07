import 'package:app/commons/helpers/permission_helper.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

class MobilePermissionHelper implements PermissionHelper {
  @override
  Future<PermissionStatus> request(Permission requestPermission) async {
    var permission = _getPermissionFromPermissions(requestPermission);
    if (permission == null) {
      return PermissionStatus.Undetermined;
    }

    var status = await permission.request();
    return _statusFromResponse(status);
  }

  @override
  Future openAppSettings() {
    return permission_handler.openAppSettings();
  }

  permission_handler.Permission _getPermissionFromPermissions(
      Permission requestPermission) {
    switch (requestPermission) {
      case Permission.Camera:
        return permission_handler.Permission.camera;
      default:
        return null;
    }
  }

  PermissionStatus _statusFromResponse(
      permission_handler.PermissionStatus status) {
    if (status.isDenied) {
      return PermissionStatus.Denied;
    } else if (status.isGranted) {
      return PermissionStatus.Granted;
    } else if (status.isPermanentlyDenied) {
      return PermissionStatus.PermanentlyDenied;
    } else if (status.isRestricted) {
      return PermissionStatus.Restricted;
    }

    return PermissionStatus.Undetermined;
  }
}
