import 'dart:async';

import 'package:app/commons/helpers/connectivity_helper.dart';
import 'package:connectivity/connectivity.dart';

class FlutterConnectivityHelper implements ConnectivityHelper {
  final Connectivity _connectivity = Connectivity();

  @override
  StreamSubscription<bool> hasConnectionListen(updateConnectionStatus) {
    return _connectivity.onConnectivityChanged
        .map((event) => event != ConnectivityResult.none)
        .listen(updateConnectionStatus);
  }

  @override
  Future<bool> hasConnection() async {
    var result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
