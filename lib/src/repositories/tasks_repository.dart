import 'package:injectable/injectable.dart';

import '../data/tasks_datasource.dart';
import '../models/task_model.dart';

abstract class ITasksRepository {
  Stream<List<TaskModel>> getTasks();
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
<<<<<<< Updated upstream
  Future<void> deleteTask(TaskModel task);
=======
>>>>>>> Stashed changes
}

@Singleton(as: ITasksRepository)
class TasksRepositoryImpl implements ITasksRepository {
  TasksRepositoryImpl(this._localDataSource);

  final ITasksLocalDataSource _localDataSource;

  @override
<<<<<<< Updated upstream
  Stream<List<TaskModel>> getTasks() => _localDataSource.getTasks();

  @override
  Future<void> createTask(TaskModel task) => _localDataSource.createTask(task);

=======
  Future<void> createTask(TaskModel task) => _localDataSource.createTask(task);
>>>>>>> Stashed changes
  @override
  Future<void> updateTask(TaskModel task) => _localDataSource.updateTask(task);

  @override
<<<<<<< Updated upstream
  Future<void> deleteTask(TaskModel task) => _localDataSource.deleteTask(task);
=======
  Stream<List<TaskModel>> getTasks() => _localDataSource.getTasks();
>>>>>>> Stashed changes
}
