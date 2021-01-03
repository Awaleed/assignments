// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on _SettingsStore, Store {
  final _$useDarkModeAtom = Atom(name: '_SettingsStore.useDarkMode');

  @override
  bool get useDarkMode {
    _$useDarkModeAtom.reportRead();
    return super.useDarkMode;
  }

  @override
  set useDarkMode(bool value) {
    _$useDarkModeAtom.reportWrite(value, super.useDarkMode, () {
      super.useDarkMode = value;
    });
  }

  final _$showPerformanceOverlayAtom =
      Atom(name: '_SettingsStore.showPerformanceOverlay');

  @override
  bool get showPerformanceOverlay {
    _$showPerformanceOverlayAtom.reportRead();
    return super.showPerformanceOverlay;
  }

  @override
  set showPerformanceOverlay(bool value) {
    _$showPerformanceOverlayAtom
        .reportWrite(value, super.showPerformanceOverlay, () {
      super.showPerformanceOverlay = value;
    });
  }

  final _$colorAtom = Atom(name: '_SettingsStore.color');

  @override
  MaterialColor get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(MaterialColor value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$languageCodeAtom = Atom(name: '_SettingsStore.languageCode');

  @override
  String get languageCode {
    _$languageCodeAtom.reportRead();
    return super.languageCode;
  }

  @override
  set languageCode(String value) {
    _$languageCodeAtom.reportWrite(value, super.languageCode, () {
      super.languageCode = value;
    });
  }

  final _$setDarkModeAsyncAction = AsyncAction('_SettingsStore.setDarkMode');

  @override
  Future<void> setDarkMode({@required bool value}) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(value: value));
  }

  final _$setShowPerformanceOverlayAsyncAction =
      AsyncAction('_SettingsStore.setShowPerformanceOverlay');

  @override
  Future<void> setShowPerformanceOverlay({@required bool value}) {
    return _$setShowPerformanceOverlayAsyncAction
        .run(() => super.setShowPerformanceOverlay(value: value));
  }

  final _$setColorAsyncAction = AsyncAction('_SettingsStore.setColor');

  @override
  Future<void> setColor({@required MaterialColor value}) {
    return _$setColorAsyncAction.run(() => super.setColor(value: value));
  }

  final _$setLanguageCodeAsyncAction =
      AsyncAction('_SettingsStore.setLanguageCode');

  @override
  Future<void> setLanguageCode(String code) {
    return _$setLanguageCodeAsyncAction.run(() => super.setLanguageCode(code));
  }

  @override
  String toString() {
    return '''
useDarkMode: ${useDarkMode},
showPerformanceOverlay: ${showPerformanceOverlay},
color: ${color},
languageCode: ${languageCode}
    ''';
  }
}
