// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignments.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClassList on _ClassList, Store {
  final _$classesAtom = Atom(name: '_ClassList.classes');

  @override
  ObservableList<ClassEntity> get classes {
    _$classesAtom.context.enforceReadPolicy(_$classesAtom);
    _$classesAtom.reportObserved();
    return super.classes;
  }

  @override
  set classes(ObservableList<ClassEntity> value) {
    _$classesAtom.context.conditionallyRunInAction(() {
      super.classes = value;
      _$classesAtom.reportChanged();
    }, _$classesAtom, name: '${_$classesAtom.name}_set');
  }

  final _$_ClassListActionController = ActionController(name: '_ClassList');

  @override
  void addClass(ClassEntity entity) {
    final _$actionInfo = _$_ClassListActionController.startAction();
    try {
      return super.addClass(entity);
    } finally {
      _$_ClassListActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'classes: ${classes.toString()}';
    return '{$string}';
  }
}
