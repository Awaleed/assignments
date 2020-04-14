// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignments.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AssignmentsStore on _AssignmentsStore, Store {
  Computed<ObservableList<AssignmentEntity>> _$pendingAssignmentsComputed;

  @override
  ObservableList<AssignmentEntity> get pendingAssignments =>
      (_$pendingAssignmentsComputed ??=
              Computed<ObservableList<AssignmentEntity>>(
                  () => super.pendingAssignments))
          .value;
  Computed<ObservableList<AssignmentEntity>> _$completedAssignmentsComputed;

  @override
  ObservableList<AssignmentEntity> get completedAssignments =>
      (_$completedAssignmentsComputed ??=
              Computed<ObservableList<AssignmentEntity>>(
                  () => super.completedAssignments))
          .value;

  final _$coursesAtom = Atom(name: '_AssignmentsStore.courses');

  @override
  ObservableList<CourseEntity> get courses {
    _$coursesAtom.context.enforceReadPolicy(_$coursesAtom);
    _$coursesAtom.reportObserved();
    return super.courses;
  }

  @override
  set courses(ObservableList<CourseEntity> value) {
    _$coursesAtom.context.conditionallyRunInAction(() {
      super.courses = value;
      _$coursesAtom.reportChanged();
    }, _$coursesAtom, name: '${_$coursesAtom.name}_set');
  }

  final _$assignmentsAtom = Atom(name: '_AssignmentsStore.assignments');

  @override
  ObservableList<AssignmentEntity> get assignments {
    _$assignmentsAtom.context.enforceReadPolicy(_$assignmentsAtom);
    _$assignmentsAtom.reportObserved();
    return super.assignments;
  }

  @override
  set assignments(ObservableList<AssignmentEntity> value) {
    _$assignmentsAtom.context.conditionallyRunInAction(() {
      super.assignments = value;
      _$assignmentsAtom.reportChanged();
    }, _$assignmentsAtom, name: '${_$assignmentsAtom.name}_set');
  }

  final _$_AssignmentsStoreActionController =
      ActionController(name: '_AssignmentsStore');

  @override
  void addCourse(CourseEntity course) {
    final _$actionInfo = _$_AssignmentsStoreActionController.startAction();
    try {
      return super.addCourse(course);
    } finally {
      _$_AssignmentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteCourse(CourseEntity course) {
    final _$actionInfo = _$_AssignmentsStoreActionController.startAction();
    try {
      return super.deleteCourse(course);
    } finally {
      _$_AssignmentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCourse(CourseEntity course) {
    final _$actionInfo = _$_AssignmentsStoreActionController.startAction();
    try {
      return super.updateCourse(course);
    } finally {
      _$_AssignmentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAssignment(AssignmentEntity assignment) {
    final _$actionInfo = _$_AssignmentsStoreActionController.startAction();
    try {
      return super.addAssignment(assignment);
    } finally {
      _$_AssignmentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateAssignment(AssignmentEntity assignment) {
    final _$actionInfo = _$_AssignmentsStoreActionController.startAction();
    try {
      return super.updateAssignment(assignment);
    } finally {
      _$_AssignmentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAssignment(AssignmentEntity assignment) {
    final _$actionInfo = _$_AssignmentsStoreActionController.startAction();
    try {
      return super.toggleAssignment(assignment);
    } finally {
      _$_AssignmentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteAssignment(AssignmentEntity assignment) {
    final _$actionInfo = _$_AssignmentsStoreActionController.startAction();
    try {
      return super.deleteAssignment(assignment);
    } finally {
      _$_AssignmentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteCompletedAssignments() {
    final _$actionInfo = _$_AssignmentsStoreActionController.startAction();
    try {
      return super.deleteCompletedAssignments();
    } finally {
      _$_AssignmentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'courses: ${courses.toString()},assignments: ${assignments.toString()},pendingAssignments: ${pendingAssignments.toString()},completedAssignments: ${completedAssignments.toString()}';
    return '{$string}';
  }
}
