import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/course_model.dart';
import '../../repositories/courses_repository.dart';

part 'courses_cubit.freezed.dart';
part 'courses_state.dart';

@injectable
class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit(this._coursesRepository) : super(const CoursesState.initial());
  final ICoursesRepository _coursesRepository;

  StreamSubscription<List<CourseModel>> _coursesStream;

  @override
  Future<void> close() async {
    _coursesStream?.cancel();
    super.close();
  }

  Future<void> getAllCourses() async {
    emit(const CoursesState.loading());
    try {
      _coursesStream?.cancel();
      _coursesStream =
          _coursesRepository.getCourses().distinct().listen((values) {
        emit(CoursesState.loaded(values));
      });
    } catch (e) {
      emit(CoursesState.failure(message: '$e'));
      addError(e);
    }
  }

  Future<void> createCourse(CourseModel course) async {
    emit(const CoursesState.loading());
    try {
      await _coursesRepository.createCourse(course);
      emit(const CoursesState.created());
    } catch (e) {
      emit(CoursesState.failure(message: '$e'));
      addError(e);
    }
  }

  Future<void> updateCourse(CourseModel course) async {
    emit(const CoursesState.loading());
    try {
      await _coursesRepository.updateCourse(course);
      emit(const CoursesState.updated());
    } catch (e) {
      emit(CoursesState.failure(message: '$e'));
      addError(e);
    }
  }

  Future<void> deleteCourse(int courseId) async {
    emit(const CoursesState.loading());
    try {
      await _coursesRepository.deleteCourse(courseId);
      emit(const CoursesState.deleted());
    } catch (e) {
      emit(CoursesState.failure(message: '$e'));
      addError(e);
    }
  }
}
