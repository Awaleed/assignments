import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/task_model.dart';
import '../../repositories/tasks_repository.dart';

part 'tasks_cubit.freezed.dart';
part 'tasks_state.dart';

@injectable
class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._tasksRepository) : super(const TasksState.initial());
  final ITasksRepository _tasksRepository;

  StreamSubscription<List<TaskModel>> _tasksStream;

  @override
  Future<void> close() async {
    _tasksStream?.cancel();
    super.close();
  }

  @override
  void onChange(Change change) {
    _tasksStream?.pause();
    super.onChange(change);
  }

  Future<void> getAllTasks() async {
    emit(const TasksState.loading());
    try {
      _tasksStream?.cancel();
      _tasksStream = _tasksRepository.getTasks().distinct().listen((values) {
        emit(TasksState.loaded(values));
      });
    } catch (e) {
      emit(TasksState.failure(message: '$e'));
      addError(e);
    }
  }

  Future<void> getCourseTasks(int courseId) async {
    emit(const TasksState.loading());
    try {
      _tasksStream?.cancel();
      _tasksStream = _tasksRepository
          .getTasks()
          .distinct()
          .map((tasksList) => tasksList
              .where(
                (task) => task.course.id == courseId,
              )
              .toList())
          .listen((values) {
        emit(TasksState.loaded(values));
      });
    } catch (e) {
      emit(TasksState.failure(message: '$e'));
      addError(e);
    }
  }

  Future<void> createTask(TaskModel task) async {
    emit(const TasksState.loading());
    try {
      await _tasksRepository.createTask(task);
      emit(const TasksState.created());
    } catch (e) {
      emit(TasksState.failure(message: '$e'));
      addError(e);
    }
  }

  Future<void> updateTask(TaskModel task) async {
    emit(const TasksState.loading());
    try {
      await _tasksRepository.updateTask(task);
      emit(const TasksState.updated());
    } catch (e) {
      emit(TasksState.failure(message: '$e'));
      addError(e);
    }
  }
}
