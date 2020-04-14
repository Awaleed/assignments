import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService(this._sharedPreferences);

  static const String _useDarkModeKey = 'useDarkMode';
  static const String _showPerformanceOverlay = 'showPerformanceOverlay';
  static const String _color = 'color';
  final SharedPreferences _sharedPreferences;

  set useDarkMode(bool useDarkMode) {
    _sharedPreferences.setBool(_useDarkModeKey, useDarkMode);
  }

  set showPerformanceOverlay(bool showPerformanceOverlay) {
    _sharedPreferences.setBool(_showPerformanceOverlay, showPerformanceOverlay);
  }

  set color(int value) {
    _sharedPreferences.setInt(_color, value);
  }

  bool get useDarkMode => _sharedPreferences.getBool(_useDarkModeKey) ?? false;
  bool get showPerformanceOverlay =>
      _sharedPreferences.getBool(_showPerformanceOverlay) ?? false;
  int get color => _sharedPreferences.getInt(_color) ?? Colors.blue.value;
}
