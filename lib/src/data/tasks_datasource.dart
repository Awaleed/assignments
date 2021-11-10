import 'dart:async';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../models/course_model.dart';
import '../models/task_model.dart';

const String tasksBoxName = 'tasksBox';
const String coursesBoxName = 'coursesBox';

abstract class ITasksLocalDataSource {
  Stream<List<TaskModel>> getTasks();
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(TaskModel task);

  Stream<List<CourseModel>> getCourses();
  Future<void> createCourse(CourseModel course);
  Future<void> updateCourse(CourseModel course);
  Future<void> deleteCourse(CourseModel course);
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
      _tasksStream.add(_pupulateSubTasks(tasksBox.values.toList()));
    });
  }

  final Box<TaskModel> tasksBox;
  final Box<CourseModel> coursesBox;

  final _coursesStream = StreamController<List<CourseModel>>.broadcast(sync: true);
  final _tasksStream = StreamController<List<TaskModel>>.broadcast(sync: true);

  @override
  Stream<List<TaskModel>> getTasks() async* {
    yield _pupulateSubTasks(tasksBox.values.toList());
    yield* _tasksStream.stream;
  }

  @override
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
  }
}
