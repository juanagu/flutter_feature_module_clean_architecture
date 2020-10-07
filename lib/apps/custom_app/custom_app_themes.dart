import 'package:app/apps/default/app_theme_properties.dart';
import 'package:app/commons/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppThemes {
  static final subtitle1FontSize = 18.0;
  static final subtitle2FontSize = 16.0;
  static final bodyText1FontSize = 18.0;
  static final bodyText2FontSize = 16.0;
  static final captionFontSize = 13.0;
  static final overlineFontSize = 13.0;
  static final buttonFontSize = 18.0;
  static final font = GoogleFonts.poppins();
  static final fontRegular = GoogleFonts.poppins(fontWeight: FontWeight.w400);
  static final fontMedium = GoogleFonts.poppins(fontWeight: FontWeight.w500);
  static final fontSemiBold = GoogleFonts.poppins(fontWeight: FontWeight.w600);
  static final fontBold = GoogleFonts.poppins(fontWeight: FontWeight.w700);

  final AppThemeProperties lightProperties;

  CustomAppThemes._privateConstructor(this.lightProperties);

  static CustomAppThemes instance;

  static CustomAppThemes create(AppThemeProperties lightProperties) {
    instance = CustomAppThemes._privateConstructor(lightProperties);
    return instance;
  }

  static AppThemeProperties properties() {
    return instance.lightProperties;
  }

  ThemeData light() {
    return Themes.light.copyWith(
      accentColor: lightProperties.accentColor,
      primaryColor: lightProperties.accentColor,
      primaryColorDark: lightProperties.primaryColorDark,
      backgroundColor: const Color(0xFFfafbfc),
      highlightColor: lightProperties.accentColor,
      cardTheme: Themes.light.cardTheme.copyWith(elevation: 5.0),
      appBarTheme: Themes.light.appBarTheme.copyWith(
        color: Colors.white,
        iconTheme: IconThemeData(color: lightProperties.primaryColorDark),
        textTheme: Themes.light.textTheme.copyWith(
          headline6: fontSemiBold.copyWith(
            fontSize: 22.0,
            color: lightProperties.primaryColorDark,
          ),
          headline5: fontSemiBold.copyWith(
            fontSize: 16.0,
            color: lightProperties.textColor,
            letterSpacing: 0.43,
          ),
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        headline3: fontSemiBold.copyWith(
          fontSize: 50.0,
          color: lightProperties.textColor,
        ),
        headline4: fontSemiBold.copyWith(
          fontSize: 32.0,
          color: lightProperties.primaryColorDark,
        ),
        headline5: fontMedium.copyWith(
          fontSize: 26.0,
          color: lightProperties.textColor,
        ),
        headline6: fontMedium.copyWith(
          fontSize: 18.0,
          color: lightProperties.textColor,
        ),
        subtitle1: fontSemiBold.copyWith(
          fontSize: subtitle1FontSize,
          color: lightProperties.textColor,
        ),
        subtitle2: GoogleFonts.poppinsTextTheme().subtitle2.copyWith(
              fontSize: subtitle2FontSize,
              color: Colors.grey,
            ),
        bodyText1: fontRegular.copyWith(
          fontSize: bodyText1FontSize,
          color: lightProperties.textColor,
        ),
        bodyText2: GoogleFonts.poppinsTextTheme().bodyText2.copyWith(
              fontSize: bodyText2FontSize,
            ),
        caption: fontMedium.copyWith(
          fontSize: captionFontSize,
          color: lightProperties.textColor,
        ),
        overline: fontRegular.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: overlineFontSize,
          color: lightProperties.textColor,
        ),
        button: GoogleFonts.poppinsTextTheme().button.copyWith(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.6,
              fontSize: buttonFontSize,
            ),
      ),
    );
  }
}
