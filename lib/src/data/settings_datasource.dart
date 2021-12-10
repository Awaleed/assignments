import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../models/settings_model.dart';

const String settingsBoxName = 'settingsBox';
const String currentSettingsKey = 'currentSettings';

abstract class ISettingsDataSource {
  SettingsModel getSettings();
  Future<void> saveSettings(SettingsModel settings);
}

@Singleton(as: ISettingsDataSource)
class SettingsLocalDataSource implements ISettingsDataSource {
  SettingsLocalDataSource() : box = Hive.box<SettingsModel>(settingsBoxName);

<<<<<<< Updated upstream
  final Box<SettingsModel> box;

  @override
  SettingsModel getSettings() => box.get(currentSettingsKey) ?? SettingsModel();

  @override
  Future<void> saveSettings(SettingsModel settings) => box.put(currentSettingsKey, settings);
=======
  final Box box;

  @override
  SettingsModel getSettings() {
    return box.get(currentSettingsKey) ?? SettingsModel();
  }

  @override
  Future<void> saveSettings(SettingsModel settings) =>
      box.put(currentSettingsKey, settings);
>>>>>>> Stashed changes
}
