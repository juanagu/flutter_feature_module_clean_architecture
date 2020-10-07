import 'package:app/features/auth_module/auth_module.dart';
import 'package:flutter/material.dart';

class AuthNavigatorRoute {
  final BuildContext context;

  AuthNavigatorRoute(this.context);

  Future toIndex() {
    return Navigator.of(context).pushNamedAndRemoveUntil(
      AuthModule.Index,
      (Route<dynamic> route) => false,
    );
  }
}
