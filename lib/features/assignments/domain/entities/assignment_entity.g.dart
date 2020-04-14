// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_entity.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AssignmentEntity on _AssignmentEntity, Store {
  final _$typeAtom = Atom(name: '_AssignmentEntity.type');

  @override
  AssignmentType get type {
    _$typeAtom.context.enforceReadPolicy(_$typeAtom);
    _$typeAtom.reportObserved();
    return super.type;
  }

  @override
  set type(AssignmentType value) {
    _$typeAtom.context.conditionallyRunInAction(() {
      super.type = value;
      _$typeAtom.reportChanged();
    }, _$typeAtom, name: '${_$typeAtom.name}_set');
  }

  final _$nameAtom = Atom(name: '_AssignmentEntity.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$dueDateAtom = Atom(name: '_AssignmentEntity.dueDate');

  @override
  DateTime get dueDate {
    _$dueDateAtom.context.enforceReadPolicy(_$dueDateAtom);
    _$dueDateAtom.reportObserved();
    return super.dueDate;
  }

  @override
  set dueDate(DateTime value) {
    _$dueDateAtom.context.conditionallyRunInAction(() {
      super.dueDate = value;
      _$dueDateAtom.reportChanged();
    }, _$dueDateAtom, name: '${_$dueDateAtom.name}_set');
  }

  final _$notesAtom = Atom(name: '_AssignmentEntity.notes');

  @override
  String get notes {
    _$notesAtom.context.enforceReadPolicy(_$notesAtom);
    _$notesAtom.reportObserved();
    return super.notes;
  }

  @override
  set notes(String value) {
    _$notesAtom.context.conditionallyRunInAction(() {
      super.notes = value;
      _$notesAtom.reportChanged();
    }, _$notesAtom, name: '${_$notesAtom.name}_set');
  }

  final _$completedAtom = Atom(name: '_AssignmentEntity.completed');

  @override
  bool get completed {
    _$completedAtom.context.enforceReadPolicy(_$completedAtom);
    _$completedAtom.reportObserved();
    return super.completed;
  }

  @override
  set completed(bool value) {
    _$completedAtom.context.conditionallyRunInAction(() {
      super.completed = value;
      _$completedAtom.reportChanged();
    }, _$completedAtom, name: '${_$completedAtom.name}_set');
  }

  @override
  String toString() {
    final string =
        'type: ${type.toString()},name: ${name.toString()},dueDate: ${dueDate.toString()},notes: ${notes.toString()},completed: ${completed.toString()}';
    return '{$string}';
  }
}
