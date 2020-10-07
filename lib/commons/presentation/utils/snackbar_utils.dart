import 'package:app/apps/custom_app/custom_app_themes.dart';
import 'package:flutter/material.dart';

abstract class SnackBarUtils {
  static void showError(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 10.0,
        backgroundColor: Theme.of(context).errorColor,
        content: Text(
          message.toUpperCase(),
          style: Theme.of(context).textTheme.overline.copyWith(
                color: Colors.white,
              ),
        ),
        duration: Duration(seconds: 4),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message,
      {int seconds = 4}) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 10.0,
        backgroundColor: CustomAppThemes.properties().successBackgroundColor,
        content: Text(
          message.toUpperCase(),
          style: Theme.of(context).textTheme.overline.copyWith(
                color: Colors.white,
              ),
        ),
        duration: Duration(seconds: seconds),
      ),
    );
  }

  static void showSuccessWithAction(
    BuildContext context,
    String message,
    String actionLabel,
    Function action, {
    int duration = 4,
  }) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 10.0,
        backgroundColor: CustomAppThemes.properties().successBackgroundColor,
        content: Text(
          message.toUpperCase(),
          style: Theme.of(context).textTheme.overline.copyWith(
                color: Colors.white,
              ),
        ),
        duration: Duration(seconds: duration),
        action: SnackBarAction(
          label: actionLabel.toUpperCase(),
          onPressed: action,
          textColor: Colors.black87,
        ),
      ),
    );
  }
}
