import '../entities/course_entity.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class TaskUseCases {
  final TasksRepository repo;

  const TaskUseCases(this.repo);

  //! CRUD - Courses
  Future<void> addCourse(Course course) => repo.addCourse(course);
  List<Course> getCourses() => repo.getCourses();
  Future<void> updateCourse(Course course) => repo.updateCourse(course);
  Future<void> deleteCourse(Course course) => repo.deleteCourse(course);

  //! CRUD - Tasks
  Future<void> addTask(Task task) => repo.addTask(task);
  List<Task> getTasks() => repo.getTasks();
  Future<void> updateTask(Task task) => repo.updateTask(task);
  Future<void> deleteTask(Task task) => repo.deleteTask(task);
}
