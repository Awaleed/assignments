// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TasksStore on _TasksStore, Store {
  Computed<List<Task>> _$overdueTasksComputed;

  @override
  List<Task> get overdueTasks =>
      (_$overdueTasksComputed ??= Computed<List<Task>>(() => super.overdueTasks,
              name: '_TasksStore.overdueTasks'))
          .value;
  Computed<List<Task>> _$pendingTasksComputed;

  @override
  List<Task> get pendingTasks =>
      (_$pendingTasksComputed ??= Computed<List<Task>>(() => super.pendingTasks,
              name: '_TasksStore.pendingTasks'))
          .value;

  final _$coursesAtom = Atom(name: '_TasksStore.courses');

  @override
  ObservableList<Course> get courses {
    _$coursesAtom.reportRead();
    return super.courses;
  }

  @override
  set courses(ObservableList<Course> value) {
    _$coursesAtom.reportWrite(value, super.courses, () {
      super.courses = value;
    });
  }

  final _$tasksAtom = Atom(name: '_TasksStore.tasks');

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  final _$addCourseAsyncAction = AsyncAction('_TasksStore.addCourse');

  @override
  Future<void> addCourse(Course course) {
    return _$addCourseAsyncAction.run(() => super.addCourse(course));
  }

  final _$deleteCourseAsyncAction = AsyncAction('_TasksStore.deleteCourse');

  @override
  Future<void> deleteCourse(Course course) {
    return _$deleteCourseAsyncAction.run(() => super.deleteCourse(course));
  }

  final _$updateCourseAsyncAction = AsyncAction('_TasksStore.updateCourse');

  @override
  Future<void> updateCourse(Course course) {
    return _$updateCourseAsyncAction.run(() => super.updateCourse(course));
  }

  final _$addTaskAsyncAction = AsyncAction('_TasksStore.addTask');

  @override
  Future<void> addTask(Task task) {
    return _$addTaskAsyncAction.run(() => super.addTask(task));
  }

  final _$updateTaskAsyncAction = AsyncAction('_TasksStore.updateTask');

  @override
  Future<void> updateTask(Task task) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(task));
  }

  final _$deleteTaskAsyncAction = AsyncAction('_TasksStore.deleteTask');

  @override
  Future<void> deleteTask(Task task) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(task));
  }

  @override
  String toString() {
    return '''
courses: ${courses},
tasks: ${tasks},
overdueTasks: ${overdueTasks},
pendingTasks: ${pendingTasks}
    ''';
  }
}
