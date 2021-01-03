import '../../domain/entities/course_entity.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../datasources/local_datasource.dart';

class TasksRepositoryImpl extends TasksRepository {
  final LocalDataSource localDataSource = LocalDataSourceImpl();

  @override
  Future<void> addCourse(Course course) async {
    return localDataSource.addCourse(course);
  }

  @override
  List<Course> getCourses() {
    return localDataSource.getCourses();
  }

  @override
  Future<void> updateCourse(Course course) {
    return localDataSource.updateCourse(course);
  }

  @override
  Future<void> deleteCourse(Course course) {
    return localDataSource.deleteCourse(course);
  }

  @override
  Future<void> addTask(Task task) {
    return localDataSource.addTask(task);
  }

  @override
  List<Task> getTasks() {
    return localDataSource.getTasks();
  }

  @override
  Future<void> updateTask(Task task) {
    return localDataSource.updateTask(task);
  }

  @override
  Future<void> deleteTask(Task task) {
    return localDataSource.deleteTask(task);
  }
}
