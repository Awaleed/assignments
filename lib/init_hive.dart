import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/data/settings_datasource.dart';
import 'src/data/tasks_datasource.dart';
import 'src/models/course_model.dart';
import 'src/models/settings_model.dart';
import 'src/models/task_model.dart';

Future<void> initHive() async {
  if (kIsWeb) {
    Hive.init('hive_data');
  } else {
    await Hive.initFlutter();
  }

  Hive.registerAdapter<SettingsModel>(SettingsModelAdapter());
  await Hive.openBox<SettingsModel>(settingsBoxName);

  Hive.registerAdapter<CourseModel>(CourseModelAdapter());
  await Hive.openBox<CourseModel>(coursesBoxName);

  Hive.registerAdapter<TaskType>(TaskTypeAdapter());
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  await Hive.openBox<TaskModel>(tasksBoxName);
}
