import 'package:flutter/material.dart';

abstract class Themes {
  static final ThemeData light = ThemeData.light().copyWith(
    cardTheme: _buildCardTheme(),
    accentColor: Colors.blue,
    bottomSheetTheme:
        ThemeData.light().bottomSheetTheme.copyWith(elevation: 10.0),
    iconTheme: IconThemeData.fallback().copyWith(color: Colors.grey),
    textTheme: ThemeData.light().textTheme.copyWith(
          button: ThemeData.light().textTheme.button.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
        ),
  );

  static final ThemeData dark = ThemeData.dark().copyWith(
    cardTheme: _buildCardTheme(),
    bottomSheetTheme:
        ThemeData.dark().bottomSheetTheme.copyWith(elevation: 10.0),
  );

  static CardTheme _buildCardTheme() {
    return CardTheme().copyWith(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
