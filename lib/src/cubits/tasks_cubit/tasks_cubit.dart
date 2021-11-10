import 'dart:async';

import 'package:assignments/src/models/course_model.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/task_model.dart';
import '../../repositories/tasks_repository.dart';

@injectable
class TasksCubit extends Cubit<List<TaskModel>> {
  TasksCubit(this._tasksRepository) : super([]);
  final ITasksRepository _tasksRepository;

  StreamSubscription<List<TaskModel>>? _tasksStream;

  @override
  Future<void> close() async {
    await _tasksStream?.cancel();
    super.close();
  }

  Future<void> getAllTasks() async {
    await _tasksStream?.cancel();
    _tasksStream = _tasksRepository
        .getTasks()
        .distinct()
        .map((tasksList) => tasksList.where((element) => !element.isSubTask).toList())
        .listen((values) => emit(values));
  }

  Future<void> getCourseTasks(CourseModel course) async {
    await _tasksStream?.cancel();
    _tasksStream = _tasksRepository
        .getTasks()
        .distinct()
        .map((tasksList) => tasksList.where((task) => task.course?.key == course.key).toList())
        .listen((values) => emit(values));
  }
}
