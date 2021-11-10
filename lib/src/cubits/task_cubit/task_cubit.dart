import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/task_model.dart';
import '../../repositories/tasks_repository.dart';

@injectable
class TaskCubit extends Cubit<TaskModel> {
  TaskCubit(@factoryParam TaskModel? task, this._tasksRepository) : super(task!) {
    getTask();
  }
  final ITasksRepository _tasksRepository;

  StreamSubscription<TaskModel>? _tasksStream;

  @override
  Future<void> close() async {
    _tasksStream?.cancel();
    super.close();
  }

  void getTask() {
    _tasksStream?.cancel();
    _tasksStream = _tasksRepository.getTasks().distinct().map((tasksList) {
      print('_tasksStream ${DateTime.now()}');
      return tasksList.firstWhere(
        (task) => task.key == state.key,
        orElse: () => state,
      );
    }).listen((value) => emit(value));
  }

  Future<void> createTask(TaskModel task) => _tasksRepository.createTask(task);
  Future<void> updateTask(TaskModel task) => _tasksRepository.updateTask(task);
  Future<void> deleteTask(TaskModel task) => _tasksRepository.deleteTask(task);
}
