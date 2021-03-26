part of 'tasks_cubit.dart';

@freezed
abstract class TasksState with _$TasksState {
  const factory TasksState.initial() = _Initial;
  const factory TasksState.loading() = _Loading;
  const factory TasksState.created() = _Created;
  const factory TasksState.updated() = _Updated;
  const factory TasksState.loaded(List<TaskModel> values) = _Loaded;
  const factory TasksState.failure({String message}) = _Failure;
}
