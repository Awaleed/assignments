part of 'courses_cubit.dart';

@freezed
abstract class CoursesState with _$CoursesState {
  const factory CoursesState.initial() = _Initial;
  const factory CoursesState.loading() = _Loading;
  const factory CoursesState.created() = _Created;
  const factory CoursesState.updated() = _Updated;
  const factory CoursesState.deleted() = _Deleted;
  const factory CoursesState.loaded(List<CourseModel> values) = _Loaded;
  const factory CoursesState.failure({String message}) = _Failure;
}
