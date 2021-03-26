import 'package:flutter/material.dart';

class AppTheme {
  final MaterialColor primaryColor;
  final String arabicName;
  final String engleshName;
  final Brightness lightModeTextBrightness;
  final Brightness darkModeTextBrightness;

  const AppTheme({
    @required this.primaryColor,
    @required this.arabicName,
    @required this.engleshName,
    @required this.lightModeTextBrightness,
    @required this.darkModeTextBrightness,
  });

  static const themes = <AppTheme>[
    AppTheme(
      primaryColor: Colors.amber,
      engleshName: 'Amber',
      arabicName: 'عنبر',
      lightModeTextBrightness: Brightness.dark,
      darkModeTextBrightness: Brightness.light,
    ),
  ];
}
