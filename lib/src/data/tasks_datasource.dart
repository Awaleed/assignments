import 'dart:async';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../models/course_model.dart';
import '../models/task_model.dart';

const String tasksBoxName = 'tasksBox';
<<<<<<< Updated upstream
const String coursesBoxName = 'coursesBox';
=======
const String currentTasksKey = 'currentTasks';
const String coursesBoxName = 'coursesBox';
const String currentCoursesKey = 'currentCourses';
>>>>>>> Stashed changes

abstract class ITasksLocalDataSource {
  Stream<List<TaskModel>> getTasks();
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
<<<<<<< Updated upstream
  Future<void> deleteTask(TaskModel task);
=======
  Future<void> deleteTask(int taskId);
>>>>>>> Stashed changes

  Stream<List<CourseModel>> getCourses();
  Future<void> createCourse(CourseModel course);
  Future<void> updateCourse(CourseModel course);
<<<<<<< Updated upstream
  Future<void> deleteCourse(CourseModel course);
=======
  Future<void> deleteCourse(int courseId);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
      _tasksStream.add(_pupulateSubTasks(tasksBox.values.toList()));
    });
  }

  final Box<TaskModel> tasksBox;
  final Box<CourseModel> coursesBox;
=======
      _tasksStream.add(tasksBox.values.toList());
    });
  }

  final Box tasksBox;
  final Box coursesBox;
>>>>>>> Stashed changes

  final _coursesStream = StreamController<List<CourseModel>>.broadcast(sync: true);
  final _tasksStream = StreamController<List<TaskModel>>.broadcast(sync: true);

  @override
<<<<<<< Updated upstream
  Stream<List<TaskModel>> getTasks() async* {
    yield _pupulateSubTasks(tasksBox.values.toList());
=======
  Stream<List<CourseModel>> getCourses() async* {
    yield coursesBox.values.toList();
    yield* _coursesStream.stream;
  }

  @override
  Stream<List<TaskModel>> getTasks() async* {
    yield tasksBox.values.toList();
>>>>>>> Stashed changes
    yield* _tasksStream.stream;
  }

  @override
<<<<<<< Updated upstream
  Future<void> createTask(TaskModel task) => tasksBox.add(task);

  @override
  Future<void> updateTask(TaskModel task) => task.save();
  @override
  Future<void> deleteTask(TaskModel task) async {
    await tasksBox.deleteAll(task.subtasks?.map((e) => e.key) ?? []);
    return task.delete();
  }

  @override
  Stream<List<CourseModel>> getCourses() async* {
    yield coursesBox.values.toList();
    yield* _coursesStream.stream;
  }

  @override
  Future<void> createCourse(CourseModel courses) => coursesBox.add(courses);

  @override
  Future<void> updateCourse(CourseModel course) => course.save();

  @override
  Future<void> deleteCourse(CourseModel course) async {
    final ids = [];
    for (final task in tasksBox.values) {
      if (task.course?.key == course.key) {
        await tasksBox.deleteAll(task.subtasks?.map((e) => e.key) ?? []);
        ids.add(task.key);
      }
    }
    await tasksBox.deleteAll(ids);
    return course.delete();
  }

  List<TaskModel> _pupulateSubTasks(List<TaskModel> tasks) {
    for (final task in tasks) {
      task.subtasks = [];
      task.subtasks?.addAll(
        tasks.where((element) => element.parentKey == task.key),
      );
      if (task.parentKey != null) {
        final index = tasks.indexWhere((element) => element.key == task.parentKey);
        if (index != -1) task.parent = tasks[index];
      }
    }
    return tasks;
=======
  Future<void> createCourse(CourseModel courses) async {
    final id = await coursesBox.add(courses);
    courses.id = id;
    await updateCourse(courses);
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
  Future<void> updateCourse(CourseModel course) => coursesBox.put(course.id, course);
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
>>>>>>> Stashed changes
  }
}
