import 'dart:ui';

import 'package:app/apps/default/app_theme_properties.dart';

class DefaultThemeProperties implements AppThemeProperties {
 
  //Colors
  final Color _primaryColorDark = Color(0xFF113d6b);
  final Color _accentColor = Color(0xFF1d84ef);
  final Color _backgroundColor = Color(0xFFfafbfc);
  final Color _footerColor = Color(0xfff2f6fa);
  final Color _textColor = Color(0xff333333);
  final Color _warningColor = Color(0xfffdb44d);
  final Color _backgroundTooltipColor = Color(0xffdae7ff);
  final Color _secondaryBackgroundCardColor = Color(0xfff8f8fa);
  final Color _successBackgroundColor = Color(0xff5dc772);
  final Color _backgroundField = Color(0xffe5edf5);
  final Color _backgroundIcon = Color(0xfff5f7fa);
  final Color _breadcrumbBackgroundColor = Color(0xfff2f6fa);

  @override
  Color get accentColor => _accentColor;

  @override
  Color get backgroundColor => _backgroundColor;

  @override
  Color get backgroundTooltipColor => _backgroundTooltipColor;

  @override
  Color get footerColor => _footerColor;

  @override
  Color get primaryColorDark => _primaryColorDark;

  @override
  Color get secondaryBackgroundCardColor => _secondaryBackgroundCardColor;

  @override
  Color get successBackgroundColor => _successBackgroundColor;

  @override
  Color get textColor => _textColor;

  @override
  Color get warningColor => _warningColor;

  @override
  Color get backgroundField => _backgroundField;

  @override
  Color get backgroundIcon => _backgroundIcon;

  @override
  Color get breadcrumbBackgroundColor => _breadcrumbBackgroundColor;
}
