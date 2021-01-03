import 'package:flutter/material.dart';

import 'generated/locale_base.dart';

class LocDelegate extends LocalizationsDelegate<LocaleBase> {
  LocDelegate();
  final Map<String, String> idMap = const {
    'en': 'locales/EN_US.json',
    'ar': 'locales/AR_SA.json',
  };

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<LocaleBase> load(Locale locale) async {
    var lang = 'en';
    if (isSupported(locale)) lang = locale.languageCode;
    final loc = LocaleBase();
    await loc.load(idMap[lang]);
    return loc;
  }

  @override
  bool shouldReload(LocDelegate old) => false;
}
