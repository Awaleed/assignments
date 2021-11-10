// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'src/cubits/course_cubit/course_cubit.dart' as _i7;
import 'src/cubits/courses_cubit/courses_cubit.dart' as _i14;
import 'src/cubits/settings_cubit/settings_cubit.dart' as _i13;
import 'src/cubits/task_cubit/task_cubit.dart' as _i3;
import 'src/cubits/tasks_cubit/tasks_cubit.dart' as _i6;
import 'src/data/settings_datasource.dart' as _i10;
import 'src/data/tasks_datasource.dart' as _i12;
import 'src/models/course_model.dart' as _i8;
import 'src/models/task_model.dart' as _i4;
import 'src/repositories/courses_repository.dart' as _i9;
import 'src/repositories/settings_repository.dart' as _i11;
import 'src/repositories/tasks_repository.dart' as _i5;

const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factoryParam<_i3.TaskCubit, _i4.TaskModel?, dynamic>(
      (task, _) => _i3.TaskCubit(task, get<_i5.ITasksRepository>()));
  gh.factory<_i6.TasksCubit>(() => _i6.TasksCubit(get<_i5.ITasksRepository>()));
  gh.factoryParam<_i7.CourseCubit, _i8.CourseModel?, dynamic>(
      (course, _) => _i7.CourseCubit(course, get<_i9.ICoursesRepository>()));
  gh.singleton<_i10.ISettingsDataSource>(_i10.SettingsLocalDataSource());
  gh.singleton<_i11.ISettingsRepository>(
      _i11.SettingsRepositoryImpl(get<_i10.ISettingsDataSource>()));
  gh.singleton<_i12.ITasksLocalDataSource>(_i12.TasksLocalDataSource(),
      registerFor: {_prod});
  gh.singleton<_i5.ITasksRepository>(
      _i5.TasksRepositoryImpl(get<_i12.ITasksLocalDataSource>()));
  gh.singleton<_i13.SettingsCubit>(
      _i13.SettingsCubit(get<_i11.ISettingsRepository>()));
  gh.singleton<_i9.ICoursesRepository>(
      _i9.CoursesRepositoryImpl(get<_i12.ITasksLocalDataSource>()));
  gh.singleton<_i14.CoursesCubit>(
      _i14.CoursesCubit(get<_i9.ICoursesRepository>()));
  return get;
}
