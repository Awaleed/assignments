part of 'settings_cubit.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _Initial;
  const factory SettingsState.loaded(SettingsModel value) = _Success;
  const factory SettingsState.failure({String message}) = _Failure;
}
