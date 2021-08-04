import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/settings_model.dart';
import '../../repositories/settings_repository.dart';

@singleton
class SettingsCubit extends Cubit<SettingsModel> {
  SettingsCubit(this._settingsRepository) : super(SettingsModel()) {
    getSettings();
  }

  final ISettingsRepository _settingsRepository;

  void getSettings() {
    final value = _settingsRepository.getSettings();
    emit(value);
  }

  void setLanguageCode(String code) {
    final value = _settingsRepository.getSettings();
    value.languageCode = code;
    value.save();
    _settingsRepository.saveSettings(value);
    emit(value);
  }

  void setThemeIndex(int index) {
    final value = _settingsRepository.getSettings();
    value.themeIndex = index;
    value.save();
    _settingsRepository.saveSettings(value);
    emit(value);
  }
}
