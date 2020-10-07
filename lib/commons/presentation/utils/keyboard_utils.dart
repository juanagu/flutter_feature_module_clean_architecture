import 'package:flutter/material.dart';

abstract class KeyboardUtils {
  static bool isEnter(RawKeyEvent key) {
    var keyLabel = key.data.keyLabel;
    return keyLabel == 'Enter';
  }
}
