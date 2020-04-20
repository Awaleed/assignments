import '../entities/course_entity.dart';
import '../entities/task_entity.dart';

abstract class TasksRepository {
  Future<void> addCourse(Course course);
  List<Course> getCourses();
  Future<void> updateCourse(Course course);
  Future<void> deleteCourse(Course course);

  Future<void> addTask(Task task);
  List<Task> getTasks();
  Future<void> updateTask(Task task);
  Future<void> deleteTask(Task task);
}
