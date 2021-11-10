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

  Future<void> setLanguageCode(String code) async {
    final value = _settingsRepository.getSettings();
    value.languageCode = code;
    await value.save();
    await _settingsRepository.saveSettings(value);
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
