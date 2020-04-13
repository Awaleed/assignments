import 'dart:async';
import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:assignments/features/assignments/domain/repositories/assignments_repository.dart';
import '../../../domain/usecases/assignment_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:assignments/features/assignments/domain/entities/class_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

part 'assignment_event.dart';
part 'assignment_state.dart';
part 'assignment_bloc.freezed.dart';

class AssignmentsBloc extends Bloc<AssignmentsEvent, AssignmentsState> {
  AssignmentUseCases useCases =
      AssignmentUseCases(kiwi.Container().resolve<AssignmentsRepository>());

  @override
  AssignmentsState get initialState => AssignmentsState.loading();

  @override
  Stream<AssignmentsState> mapEventToState(
    AssignmentsEvent event,
  ) async* {
    yield* event.when(
      getData: _getData,
      getAssignmentsByClass: _filterAssignmentsByClass,
      addClass: _addClass,
      updateClass: _updateClass,
      deleteClass: _deleteClass,
      addAssignment: _addAssignment,
      deleteAssignment: _deleteAssignment,
      toggoleAssignment: _compleatedAssignment,
      updateAssignment: _updateAssignment,
      deleteCompleatedAssignments: _deleteCompleatedAssignments,
    );
  }

  Stream<AssignmentsState> _getData() async* {
    final data = await useCases.getData();
    yield* _dataLoaded(data);
  }

  Stream<AssignmentsState> _filterAssignmentsByClass(String classId) async* {
    final data = await useCases.getData();
    final filterd = data.where((entity) => entity.id == classId).toList();
    yield* _dataLoaded(filterd.isNotEmpty ? filterd : data);
  }

  Stream<AssignmentsState> _addClass(newClass) async* {
    await useCases.addClass(newClass);
    yield* _getData();
  }

  Stream<AssignmentsState> _updateClass(updatedClass) async* {
    await useCases.updateClass(updatedClass);
    yield* _getData();
  }

  Stream<AssignmentsState> _updateAssignment(updatedAssignment) async* {
    await useCases.updateAssignment(updatedAssignment);
    yield* _getData();
  }

  Stream<AssignmentsState> _compleatedAssignment(compleatedAssignment) async* {
    await useCases.toggleAssignment(compleatedAssignment);
    yield* _getData();
  }

  Stream<AssignmentsState> _deleteAssignment(deletedAssignment) async* {
    await useCases.deleteAssignment(deletedAssignment);
    yield* _getData();
  }

  Stream<AssignmentsState> _addAssignment(newAssignment) async* {
    await useCases.addAssignment(newAssignment);
    yield* _getData();
  }

  Stream<AssignmentsState> _deleteClass(deletedClass) async* {
    await useCases.deleteClass(deletedClass);
    yield* _getData();
  }

  Stream<AssignmentsState> _deleteCompleatedAssignments() async* {
    await useCases.deleteCompleatedAssignments();
    yield* _getData();
  }

  Stream<AssignmentsState> _dataLoaded(List<ClassEntity> data) async* {
    yield AssignmentsState.loaded(data);
  }
}
