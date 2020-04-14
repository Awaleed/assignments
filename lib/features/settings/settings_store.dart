import 'package:assignments/features/settings/preferences_service.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  _SettingsStore(this._preferencesService) {
    useDarkMode = _preferencesService.useDarkMode;
    showPerformanceOverlay = _preferencesService.showPerformanceOverlay;
    color = Colors.primaries
        .firstWhere((c) => c.value == _preferencesService.color);
  }

  final PreferencesService _preferencesService;

  @observable
  bool useDarkMode = false;

  @observable
  bool showPerformanceOverlay = false;

  @observable
  MaterialColor color;

  @action
  Future<void> setDarkMode({@required bool value}) async {
    _preferencesService.useDarkMode = value;
    useDarkMode = value;
  }

  @action
  Future<void> setShowPerformanceOverlay({@required bool value}) async {
    _preferencesService.showPerformanceOverlay = value;
    showPerformanceOverlay = value;
  }

  @action
  Future<void> setColor({@required Color value}) async {
    _preferencesService.color = value.value;
    color = value;
  }
}
