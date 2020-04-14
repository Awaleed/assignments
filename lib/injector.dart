import 'package:assignments/features/settings/preferences_service.dart';
import 'package:assignments/features/settings/settings_store.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/assignments/data/repositories/assignments_repository_impl.dart';
import 'features/assignments/domain/repositories/assignments_repository.dart';
import 'features/assignments/presentation/store/assignments.dart';

Future<void> injector() async {
  kiwi.Container container = kiwi.Container();

  container.registerSingleton((c) => AssignmentsStore());
  container.registerInstance<AssignmentsRepository, AssignmentsRepositoryImpl>(
    AssignmentsRepositoryImpl(),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  final preferencesService = PreferencesService(sharedPreferences);
  final settingsStore = SettingsStore(preferencesService);
  container.registerInstance(settingsStore);
}
