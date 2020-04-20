// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TasksStore on _TasksStore, Store {
  Computed<List<Task>> _$overdueTasksComputed;

  @override
  List<Task> get overdueTasks => (_$overdueTasksComputed ??=
          Computed<List<Task>>(() => super.overdueTasks))
      .value;
  Computed<List<Task>> _$pendingTasksComputed;

  @override
  List<Task> get pendingTasks => (_$pendingTasksComputed ??=
          Computed<List<Task>>(() => super.pendingTasks))
      .value;

  final _$coursesAtom = Atom(name: '_TasksStore.courses');

  @override
  ObservableList<Course> get courses {
    _$coursesAtom.context.enforceReadPolicy(_$coursesAtom);
    _$coursesAtom.reportObserved();
    return super.courses;
  }

  @override
  set courses(ObservableList<Course> value) {
    _$coursesAtom.context.conditionallyRunInAction(() {
      super.courses = value;
      _$coursesAtom.reportChanged();
    }, _$coursesAtom, name: '${_$coursesAtom.name}_set');
  }

  final _$tasksAtom = Atom(name: '_TasksStore.tasks');

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.context.enforceReadPolicy(_$tasksAtom);
    _$tasksAtom.reportObserved();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.context.conditionallyRunInAction(() {
      super.tasks = value;
      _$tasksAtom.reportChanged();
    }, _$tasksAtom, name: '${_$tasksAtom.name}_set');
  }

  final _$addCourseAsyncAction = AsyncAction('addCourse');

  @override
  Future<void> addCourse(Course course) {
    return _$addCourseAsyncAction.run(() => super.addCourse(course));
  }

  final _$deleteCourseAsyncAction = AsyncAction('deleteCourse');

  @override
  Future<void> deleteCourse(Course course) {
    return _$deleteCourseAsyncAction.run(() => super.deleteCourse(course));
  }

  final _$updateCourseAsyncAction = AsyncAction('updateCourse');

  @override
  Future<void> updateCourse(Course course) {
    return _$updateCourseAsyncAction.run(() => super.updateCourse(course));
  }

  final _$addTaskAsyncAction = AsyncAction('addTask');

  @override
  Future<void> addTask(Task task) {
    return _$addTaskAsyncAction.run(() => super.addTask(task));
  }

  final _$updateTaskAsyncAction = AsyncAction('updateTask');

  @override
  Future<void> updateTask(Task task) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(task));
  }

  final _$deleteTaskAsyncAction = AsyncAction('deleteTask');

  @override
  Future<void> deleteTask(Task task) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(task));
  }

  @override
  String toString() {
    final string =
        'courses: ${courses.toString()},tasks: ${tasks.toString()},overdueTasks: ${overdueTasks.toString()},pendingTasks: ${pendingTasks.toString()}';
    return '{$string}';
  }
}
