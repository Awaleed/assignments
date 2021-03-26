import 'dart:async';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../models/course_model.dart';
import '../models/task_model.dart';

const String tasksBoxName = 'tasksBox';
const String currentTasksKey = 'currentTasks';
const String coursesBoxName = 'coursesBox';
const String currentCoursesKey = 'currentCourses';

abstract class ITasksLocalDataSource {
  Stream<List<TaskModel>> getTasks();
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(int taskId);

  Stream<List<CourseModel>> getCourses();
  Future<void> createCourse(CourseModel course);
  Future<void> updateCourse(CourseModel course);
  Future<void> deleteCourse(int courseId);
}

@prod
@Singleton(as: ITasksLocalDataSource)
class TasksLocalDataSource extends ITasksLocalDataSource {
  TasksLocalDataSource()
      : tasksBox = Hive.box<TaskModel>(tasksBoxName),
        coursesBox = Hive.box<CourseModel>(coursesBoxName) {
    coursesBox.watch().listen((event) {
      _coursesStream.add(coursesBox.values.toList());
    });
    tasksBox.watch().listen((event) {
      _tasksStream.add(tasksBox.values.toList());
    });
  }

  final Box tasksBox;
  final Box coursesBox;

  final _coursesStream =
      StreamController<List<CourseModel>>.broadcast(sync: true);
  final _tasksStream = StreamController<List<TaskModel>>.broadcast(sync: true);

  @override
  Stream<List<CourseModel>> getCourses() async* {
    yield coursesBox.values.toList();
    yield* _coursesStream.stream;
  }

  @override
  Stream<List<TaskModel>> getTasks() async* {
    yield tasksBox.values.toList();
    yield* _tasksStream.stream;
  }

  @override
  Future<void> createCourse(CourseModel coures) async {
    final id = await coursesBox.add(coures);
    coures.id = id;
    await updateCourse(coures);
  }

  @override
  Future<void> createTask(TaskModel task) async {
    final id = await tasksBox.add(task);
    task.id = id;
    await task.save();
  }

  @override
  Future<void> updateTask(TaskModel task) => tasksBox.put(task.id, task);

  @override
  Future<void> deleteCourse(int courseId) => coursesBox.delete(courseId);

  @override
  Future<void> deleteTask(int taskId) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateCourse(CourseModel course) =>
      coursesBox.put(course.id, course);
}

@test
@Singleton(as: ITasksLocalDataSource)
class TestTasksLocalDataSource extends ITasksLocalDataSource {
  @override
  Future<void> createTask(TaskModel task) {
    // TODO: implement saveTasks
    throw UnimplementedError();
  }

  @override
  Future<void> createCourse(CourseModel course) {
    // TODO: implement createCourse
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCourse(int courseId) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }

  @override
  Stream<List<TaskModel>> getTasks() {
    // TODO: implement getTasks
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(TaskModel task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

  @override
  Stream<List<CourseModel>> getCourses() {
    // TODO: implement getCourses
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(int taskId) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateCourse(CourseModel course) {
    // TODO: implement updateCourse
    throw UnimplementedError();
  }
}
