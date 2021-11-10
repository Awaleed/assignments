import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/course_model.dart';
import '../../repositories/courses_repository.dart';

@injectable
class CourseCubit extends Cubit<CourseModel> {
  CourseCubit(@factoryParam CourseModel? course, this._coursesRepository) : super(course!) {
    getCourse();
  }
  final ICoursesRepository _coursesRepository;

  StreamSubscription<CourseModel>? _coursesStream;

  @override
  Future<void> close() async {
    _coursesStream?.cancel();
    super.close();
  }

  void getCourse() {
    _coursesStream?.cancel();
    _coursesStream = _coursesRepository
        .getCourses()
        .distinct()
        .map((coursesList) => coursesList.firstWhere(
              (course) => course.key == state.key,
              orElse: () => state,
            ))
        .listen((values) => emit(values));
  }
}
