import 'package:hive/hive.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/custom_types/custom_types.dart';
import 'features/settings/preferences_service.dart';
import 'features/settings/settings_store.dart';
import 'features/tasks/data/repositories/tasks_repository_impl.dart';
import 'features/tasks/domain/entities/course_entity.dart';
import 'features/tasks/domain/entities/task_entity.dart';
import 'features/tasks/domain/repositories/tasks_repository.dart';
import 'features/tasks/presentation/store/tasks.dart';

Future<void> injector() async {
  Hive.init((await path_provider.getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('tasks');
  await Hive.openBox<Course>('courses');

  final container = kiwi.Container();
  container.registerSingleton((c) => TasksStore());
  container.registerInstance<TasksRepository, TasksRepositoryImpl>(
    TasksRepositoryImpl(),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  final preferencesService = PreferencesService(sharedPreferences);
  final settingsStore = SettingsStore(preferencesService);
  container.registerInstance(settingsStore);
}
