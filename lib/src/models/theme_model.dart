import 'package:flutter/material.dart';

class AppTheme {
  final MaterialColor primaryColor;
  final String arabicName;
  final String engleshName;
  final Brightness? lightModeTextBrightness;
  final Brightness? darkModeTextBrightness;

  const AppTheme({
    required this.primaryColor,
    required this.arabicName,
    required this.engleshName,
    this.lightModeTextBrightness,
    this.darkModeTextBrightness,
  });

  static const themes = <AppTheme>[
    AppTheme(
      primaryColor: Colors.amber,
      engleshName: 'Amber',
      arabicName: 'عنبر',
    ),
    AppTheme(
      primaryColor: Colors.red,
      engleshName: 'Red',
      arabicName: 'أحمر',
    ),
    AppTheme(
      primaryColor: Colors.pink,
      engleshName: 'Pink',
      arabicName: 'زهري',
    ),
    AppTheme(
      primaryColor: Colors.purple,
      engleshName: 'Purple',
      arabicName: 'أرجواني',
    ),
    AppTheme(
      primaryColor: Colors.deepPurple,
      engleshName: 'Deep Purple',
      arabicName: 'أرجواني عميق',
    ),
    AppTheme(
      primaryColor: Colors.indigo,
      engleshName: 'Indigo',
      arabicName: 'نيلي',
    ),
    AppTheme(
      primaryColor: Colors.blue,
      engleshName: 'Blue',
      arabicName: 'أزرق',
    ),
    AppTheme(
      primaryColor: Colors.lightBlue,
      engleshName: 'Light Blue',
      arabicName: 'أزرق فاتح',
    ),
    AppTheme(
      primaryColor: Colors.cyan,
      engleshName: 'Cyan',
      arabicName: 'ازرق سماوي',
    ),
    AppTheme(
      primaryColor: Colors.teal,
      engleshName: 'Teal',
      arabicName: 'أزرق مخضر',
    ),
    AppTheme(
      primaryColor: Colors.green,
      engleshName: 'Green',
      arabicName: 'أخضر',
    ),
    AppTheme(
      primaryColor: Colors.lightGreen,
      engleshName: 'Light Green',
      arabicName: 'اخضر فاتح',
    ),
    AppTheme(
      primaryColor: Colors.lime,
      engleshName: 'Lime',
      arabicName: 'ليموني',
    ),
    AppTheme(
      primaryColor: Colors.yellow,
      engleshName: 'Yellow',
      arabicName: 'أصفر',
    ),
    AppTheme(
      primaryColor: Colors.amber,
      engleshName: 'Amber',
      arabicName: 'عنبر',
    ),
    AppTheme(
      primaryColor: Colors.orange,
      engleshName: 'Orange',
      arabicName: 'برتقالي',
    ),
    AppTheme(
      primaryColor: Colors.deepOrange,
      engleshName: 'Deep Orange',
      arabicName: 'برتقالي عميق',
    ),
    AppTheme(
      primaryColor: Colors.brown,
      engleshName: 'Brown',
      arabicName: 'بنى',
    ),
    AppTheme(
      primaryColor: Colors.blueGrey,
      engleshName: 'Blue Grey',
      arabicName: 'رمادي مزرق',
    ),
  ];
}
