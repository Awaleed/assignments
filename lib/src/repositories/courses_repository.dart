import 'package:injectable/injectable.dart';

import '../data/tasks_datasource.dart';
import '../models/course_model.dart';

abstract class ICoursesRepository {
  Stream<List<CourseModel>> getCourses();
  Future<void> createCourse(CourseModel course);
  Future<void> updateCourse(CourseModel course);
  Future<void> deleteCourse(CourseModel course);
}

@Singleton(as: ICoursesRepository)
class CoursesRepositoryImpl implements ICoursesRepository {
  CoursesRepositoryImpl(this._localDataSource);

  final ITasksLocalDataSource _localDataSource;

  @override
  Stream<List<CourseModel>> getCourses() => _localDataSource.getCourses();

  @override
  Future<void> createCourse(CourseModel course) => _localDataSource.createCourse(course);

  @override
  Future<void> updateCourse(CourseModel course) => _localDataSource.updateCourse(course);

  @override
  Future<void> deleteCourse(CourseModel course) => _localDataSource.deleteCourse(course);
}
