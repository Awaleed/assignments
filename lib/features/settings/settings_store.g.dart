// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on _SettingsStore, Store {
  final _$useDarkModeAtom = Atom(name: '_SettingsStore.useDarkMode');

  @override
  bool get useDarkMode {
    _$useDarkModeAtom.context.enforceReadPolicy(_$useDarkModeAtom);
    _$useDarkModeAtom.reportObserved();
    return super.useDarkMode;
  }

  @override
  set useDarkMode(bool value) {
    _$useDarkModeAtom.context.conditionallyRunInAction(() {
      super.useDarkMode = value;
      _$useDarkModeAtom.reportChanged();
    }, _$useDarkModeAtom, name: '${_$useDarkModeAtom.name}_set');
  }

  final _$showPerformanceOverlayAtom =
      Atom(name: '_SettingsStore.showPerformanceOverlay');

  @override
  bool get showPerformanceOverlay {
    _$showPerformanceOverlayAtom.context
        .enforceReadPolicy(_$showPerformanceOverlayAtom);
    _$showPerformanceOverlayAtom.reportObserved();
    return super.showPerformanceOverlay;
  }

  @override
  set showPerformanceOverlay(bool value) {
    _$showPerformanceOverlayAtom.context.conditionallyRunInAction(() {
      super.showPerformanceOverlay = value;
      _$showPerformanceOverlayAtom.reportChanged();
    }, _$showPerformanceOverlayAtom,
        name: '${_$showPerformanceOverlayAtom.name}_set');
  }

  final _$colorAtom = Atom(name: '_SettingsStore.color');

  @override
  MaterialColor get color {
    _$colorAtom.context.enforceReadPolicy(_$colorAtom);
    _$colorAtom.reportObserved();
    return super.color;
  }

  @override
  set color(MaterialColor value) {
    _$colorAtom.context.conditionallyRunInAction(() {
      super.color = value;
      _$colorAtom.reportChanged();
    }, _$colorAtom, name: '${_$colorAtom.name}_set');
  }

  final _$languageCodeAtom = Atom(name: '_SettingsStore.languageCode');

  @override
  String get languageCode {
    _$languageCodeAtom.context.enforceReadPolicy(_$languageCodeAtom);
    _$languageCodeAtom.reportObserved();
    return super.languageCode;
  }

  @override
  set languageCode(String value) {
    _$languageCodeAtom.context.conditionallyRunInAction(() {
      super.languageCode = value;
      _$languageCodeAtom.reportChanged();
    }, _$languageCodeAtom, name: '${_$languageCodeAtom.name}_set');
  }

  final _$setDarkModeAsyncAction = AsyncAction('setDarkMode');

  @override
  Future<void> setDarkMode({@required bool value}) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(value: value));
  }

  final _$setShowPerformanceOverlayAsyncAction =
      AsyncAction('setShowPerformanceOverlay');

  @override
  Future<void> setShowPerformanceOverlay({@required bool value}) {
    return _$setShowPerformanceOverlayAsyncAction
        .run(() => super.setShowPerformanceOverlay(value: value));
  }

  final _$setColorAsyncAction = AsyncAction('setColor');

  @override
  Future<void> setColor({@required MaterialColor value}) {
    return _$setColorAsyncAction.run(() => super.setColor(value: value));
  }

  final _$setLanguageCodeAsyncAction = AsyncAction('setLanguageCode');

  @override
  Future<void> setLanguageCode(String code) {
    return _$setLanguageCodeAsyncAction.run(() => super.setLanguageCode(code));
  }

  @override
  String toString() {
    final string =
        'useDarkMode: ${useDarkMode.toString()},showPerformanceOverlay: ${showPerformanceOverlay.toString()},color: ${color.toString()},languageCode: ${languageCode.toString()}';
    return '{$string}';
  }
}
