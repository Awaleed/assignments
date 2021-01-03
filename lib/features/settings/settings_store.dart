import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'preferences_service.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  _SettingsStore(this._preferencesService) {
    useDarkMode = _preferencesService.useDarkMode;
    // showPerformanceOverlay = _preferencesService.showPerformanceOverlay;
    color = Colors.primaries
        .firstWhere((c) => c.value == _preferencesService.color);
    languageCode = _preferencesService.languageCode;
  }

  final PreferencesService _preferencesService;

  @observable
  bool useDarkMode = false;

  @observable
  bool showPerformanceOverlay = false;

  @observable
  MaterialColor color;

  @observable
  String languageCode;

  @action
  Future<void> setDarkMode({@required bool value}) async {
    _preferencesService.useDarkMode = value;
    useDarkMode = value;
  }

  @action
  Future<void> setShowPerformanceOverlay({@required bool value}) async {
    // _preferencesService.showPerformanceOverlay = value;
    showPerformanceOverlay = value;
  }

  @action
  Future<void> setColor({@required MaterialColor value}) async {
    _preferencesService.color = value.value;
    color = value;
  }

  @action
  Future<void> setLanguageCode(String code) async {
    _preferencesService.languageCode = code;
    languageCode = code;
  }
}
