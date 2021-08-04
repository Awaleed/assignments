import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 0)
class SettingsModel extends HiveObject {
  SettingsModel({
    this.isFirstLaunch = true,
    this.languageCode = 'ar',
    this.themeIndex = 0,
  });

  @HiveField(0)
  bool isFirstLaunch;
  @HiveField(1)
  String languageCode;
  @HiveField(2)
  int themeIndex;

  Locale get locale => languageCode.isEmpty ? null : Locale(languageCode, '');

  @override
  bool operator ==(dynamic other) => false;

  @override
  int get hashCode => isFirstLaunch.hashCode ^ languageCode.hashCode ^ themeIndex.hashCode;
}
