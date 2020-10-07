import 'package:app/commons/helpers/error_reporter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class FirebaseErrorReporter implements ErrorReporter {
  FirebaseErrorReporter() {
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
  }

  @override
  void report(String tag, Exception error) {
    reportWithMessage(tag, error.toString());
  }

  @override
  void reportWithMessage(String tag, String message) {
    Crashlytics.instance.log('Tag: $tag, Message:$message');
  }
}
