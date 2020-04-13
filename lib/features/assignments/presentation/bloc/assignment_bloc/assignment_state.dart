part of 'assignment_bloc.dart';

@freezed
abstract class AssignmentsState with _$AssignmentsState {
  factory AssignmentsState.loading() = _ClassLoading;
  factory AssignmentsState.loaded(List<ClassEntity> classList) = _ClassLoaded;
}
