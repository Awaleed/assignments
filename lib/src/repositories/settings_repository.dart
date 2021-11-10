import 'package:injectable/injectable.dart';

import '../data/settings_datasource.dart';
import '../models/settings_model.dart';

abstract class ISettingsRepository {
  SettingsModel getSettings();
  Future<void> saveSettings(SettingsModel settings);
}

@Singleton(as: ISettingsRepository)
class SettingsRepositoryImpl implements ISettingsRepository {
  final ISettingsDataSource _localSource;

  SettingsRepositoryImpl(this._localSource);

  @override
  SettingsModel getSettings() => _localSource.getSettings();

  @override
  Future<void> saveSettings(SettingsModel settings) => _localSource.saveSettings(settings);
}
