// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'src/cubits/courses_cubit/courses_cubit.dart';
import 'src/repositories/courses_repository.dart';
import 'src/data/settings_datasource.dart';
import 'src/repositories/settings_repository.dart';
import 'src/data/tasks_datasource.dart';
import 'src/repositories/tasks_repository.dart';
import 'src/data/user_datasource.dart';
import 'src/repositories/user_repository.dart';
import 'src/cubits/settings_cubit/settings_cubit.dart';
import 'src/cubits/splash_cubit/splash_cubit.dart';
import 'src/cubits/tasks_cubit/tasks_cubit.dart';

/// Environment names
const _prod = 'prod';
const _test = 'test';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<SplashCubit>(
      () => SplashCubit(get<ISettingsRepository>(), get<IUserRepository>()));
  gh.factory<TasksCubit>(() => TasksCubit(get<ITasksRepository>()));
  gh.factory<CoursesCubit>(() => CoursesCubit(get<ICoursesRepository>()));

  // Eager singletons must be registered in the right order
  gh.singleton<ISettingsDataSource>(SettingsLocalDataSource());
  gh.singleton<ISettingsRepository>(
      SettingsRepositoryImpl(get<ISettingsDataSource>()));
  gh.singleton<ITasksLocalDataSource>(TasksLocalDataSource(),
      registerFor: {_prod});
  gh.singleton<ITasksLocalDataSource>(TestTasksLocalDataSource(),
      registerFor: {_test});
  gh.singleton<ITasksRepository>(
      TasksRepositoryImpl(get<ITasksLocalDataSource>()));
  gh.singleton<IUserLocalDataSource>(UserLocalDataSource());
  gh.singleton<IUserRepository>(
      UserRepositoryImpl(get<IUserLocalDataSource>()));
  gh.singleton<SettingsCubit>(SettingsCubit(get<ISettingsRepository>()));
  gh.singleton<ICoursesRepository>(
      CoursesRepositoryImpl(get<ITasksLocalDataSource>()));
  return get;
}
