import 'dart:async';

abstract class ConnectivityHelper {
  StreamSubscription<bool> hasConnectionListen(updateConnectionStatus);

  Future<bool> hasConnection();
}

class DefaultConnectivityHelper implements ConnectivityHelper {
  @override
  StreamSubscription<bool> hasConnectionListen(updateConnectionStatus) {
    return Stream.value(true).listen(updateConnectionStatus);
  }

  @override
  Future<bool> hasConnection() {
    return Future.value(true);
  }
}
