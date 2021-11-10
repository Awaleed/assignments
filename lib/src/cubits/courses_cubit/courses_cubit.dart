import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/course_model.dart';
import '../../repositories/courses_repository.dart';

@singleton
class CoursesCubit extends Cubit<List<CourseModel>> {
  CoursesCubit(this._coursesRepository) : super([]);
  final ICoursesRepository _coursesRepository;

  StreamSubscription<List<CourseModel>>? _coursesStream;

  @override
  Future<void> close() async {
    _coursesStream?.cancel();
    super.close();
  }

  void getAllCourses() {
    _coursesStream?.cancel();
    _coursesStream = _coursesRepository.getCourses().distinct().listen((values) => emit(values));
  }

  Future<void> createCourse(CourseModel course) => _coursesRepository.createCourse(course);

  Future<void> updateCourse(CourseModel course) => _coursesRepository.updateCourse(course);

  Future<void> deleteCourse(CourseModel course) => _coursesRepository.deleteCourse(course);
}
