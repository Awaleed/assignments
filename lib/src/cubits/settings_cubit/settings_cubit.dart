import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../helpers/helper.dart';
import '../../models/settings_model.dart';
import '../../repositories/settings_repository.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

@singleton
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository)
      : super(const SettingsState.initial());

  final ISettingsRepository _settingsRepository;

  void getSettings() {
    try {
      final value = _settingsRepository.getSettings();
      emit(SettingsState.loaded(value));
    } catch (e) {
      emit(SettingsState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  Future<void> setLanguageCode(String code) async {
    try {
      final value = _settingsRepository.getSettings();
      value.languageCode = code;
      value.save();
      _settingsRepository.saveSettings(value);
      emit(SettingsState.loaded(value));
    } catch (e) {
      emit(SettingsState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }

  Future<void> setThemeIndex(int index) async {
    try {
      final value = _settingsRepository.getSettings();
      value.themeIndex = index;
      value.save();
      _settingsRepository.saveSettings(value);
      emit(SettingsState.loaded(value));
    } catch (e) {
      emit(SettingsState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }
}
