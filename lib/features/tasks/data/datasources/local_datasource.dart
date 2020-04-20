import 'package:hive/hive.dart';

import '../../domain/entities/course_entity.dart';
import '../../domain/entities/task_entity.dart';

const coursesStore = 'COURSES_STORE';
const tasksStore = 'TASK_STORE';

abstract class LocalDataSource {
  Future<void> addCourse(Course course);
  List<Course> getCourses();
  Future<void> updateCourse(Course course);
  Future<void> deleteCourse(Course course);

  Future<void> addTask(Task task);
  List<Task> getTasks();
  Future<void> updateTask(Task task);
  Future<void> deleteTask(Task task);
}

class LocalDataSourceImpl extends LocalDataSource {
  final Box<Task> tasksBox = Hive.box('tasks');
  final Box<Course> coursesBox = Hive.box('courses');

  @override
  Future<void> addTask(Task task) async {
    task.id = await tasksBox.add(task);
    return task.save();
  }

  @override
  Future<void> addCourse(Course course) async {
    course.id = await coursesBox.add(course);
    return course.save();
  }

  @override
  Future<void> deleteTask(Task task) async {
    return task.delete();
  }

  @override
  Future<void> deleteCourse(Course course) async {
    for (final task in getTasks()) {
      if (task.course.id == course.id) {
        await deleteTask(task);
      }
    }
    return course.delete();
  }

  @override
  List<Task> getTasks() {
    return tasksBox.values.toList();
    // for (final task in tasks) {
    //   task.course = getCourses().firstWhere((c) => c.id == task.courseId);
    // }
    // return tasks;
  }

  @override
  List<Course> getCourses() {
    return coursesBox.values.toList();
  }

  @override
  Future<void> updateTask(Task task) async {
    return task.save();
  }

  @override
  Future<void> updateCourse(Course course) async {
    return course.save();
  }
}
