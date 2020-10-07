import 'package:flutter/material.dart';

abstract class GradientGenerator {
  static Decoration buildBackgroundGradient(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColorDark,
        ],
        tileMode: TileMode.clamp,
      ),
    );
  }

  static Decoration buildBackgroundLoginGradient(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          Theme.of(context).primaryColorDark,
          Theme.of(context).primaryColor,
        ],
        tileMode: TileMode.clamp,
      ),
    );
  }

  static Container buildBackground(BuildContext context) {
    return Container(
      decoration: GradientGenerator.buildBackgroundGradient(context),
    );
  }
}
