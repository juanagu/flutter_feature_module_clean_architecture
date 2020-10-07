import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class I18n {
  I18n(
    this._locale, {
    this.isTest = false,
  });

  final Locale _locale;
  bool isTest;
  Map<String, String> _sentences;

  static I18n of(BuildContext context) {
    return Localizations.of<I18n>(context, I18n);
  }

  Future<I18n> loadTest(Locale locale) async {
    return I18n(locale);
  }

  Future<I18n> load({String defaultLanguageCode = 'es'}) async {
    var data = await _loadData(defaultLanguageCode);

    Map<String, dynamic> _result = json.decode(data);
    _sentences = {};
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });
    return I18n(_locale);
  }

  Future<String> _loadData(String defaultLanguageCode) async {
    try {
      return await rootBundle
          .loadString('assets/i18n/${_locale.languageCode}.json');
    } catch (_) {
      return await rootBundle
          .loadString('assets/i18n/$defaultLanguageCode.json');
    }
  }

  String translate(String key) {
    if (isTest) return key;

    if (key == null) {
      return '...';
    }
    return _sentences[key];
  }

  String toUpperCase(String key) {
    return translate(key).toUpperCase();
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<I18n> {
  final bool isTest;
  final String defaultLanguageCode;

  const AppLocalizationsDelegate({
    this.isTest = false,
    this.defaultLanguageCode = 'es',
  });

  @override
  bool isSupported(Locale locale) {
    return ['es', 'en'].contains(locale.languageCode);
  }

  @override
  Future<I18n> load(Locale locale) async {
    var localizations = I18n(
      locale,
      isTest: isTest,
    );
    if (isTest) {
      await localizations.loadTest(locale);
    } else {
      await localizations.load();
    }

    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
