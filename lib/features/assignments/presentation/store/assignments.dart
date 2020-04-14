import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:mobx/mobx.dart';

import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/assignments_repository.dart';
import '../../domain/usecases/assignment_usecase.dart';

part 'assignments.g.dart';

// enum VisibilityFilter { all, pending, completed }

class AssignmentsStore extends _AssignmentsStore with _$AssignmentsStore {}

abstract class _AssignmentsStore with Store {
  AssignmentUseCases useCases = AssignmentUseCases(
    kiwi.Container().resolve<AssignmentsRepository>(),
  );

  @observable
  ObservableList<CourseEntity> courses = ObservableList<CourseEntity>();
  @observable
  ObservableList<AssignmentEntity> assignments =
      ObservableList<AssignmentEntity>();

  _AssignmentsStore() {
    _getData();
  }

  void _getData() async {
    courses.addAll(await useCases.getCourses());
    assignments.addAll(
      (await useCases.getAssignments()).map(
        (a) {
          a.course = courses.firstWhere((c) => c.id == a.courseId);
          return a;
        },
      ),
    );
  }

  @computed
  ObservableList<AssignmentEntity> get pendingAssignments {
    return ObservableList.of(assignments.where((a) => !a.completed));
  }

  @computed
  ObservableList<AssignmentEntity> get completedAssignments {
    return ObservableList.of(assignments.where((a) => a.completed));
  }

  @action
  void addCourse(CourseEntity course) {
    courses.add(course);
    _sortCourses();
    useCases.addCourse(course);
  }

  @action
  void deleteCourse(CourseEntity course) {
    courses.remove(course);
    assignments.removeWhere((a) => a.courseId == course.id);
    useCases.deleteCourse(course);
  }

  @action
  void updateCourse(CourseEntity course) {
    final foundCourse = courses.firstWhere((c) => c.id == course.id);
    foundCourse.name = course.name;
    foundCourse.color = course.color;

    _sortCourses();
    useCases.updateCourse(course);
  }

  @action
  void addAssignment(AssignmentEntity assignment) {
    assignments.add(assignment);
    _sortAssignments();
    useCases.addAssignment(assignment);
  }

  @action
  void updateAssignment(AssignmentEntity assignment) {
    final foundAssignment =
        assignments.firstWhere((a) => a.id == assignment.id);

    foundAssignment.name = assignment.name;
    foundAssignment.completed = assignment.completed;
    foundAssignment.dueDate = assignment.dueDate;
    foundAssignment.notes = assignment.notes;
    foundAssignment.type = assignment.type;

    _sortAssignments();
    useCases.updateAssignment(assignment);
  }

  @action
  void toggleAssignment(AssignmentEntity assignment) {
    final foundAssignment =
        assignments.firstWhere((a) => a.id == assignment.id);
    foundAssignment.completed = !assignment.completed;
    useCases.updateAssignment(assignment);
  }

  @action
  void deleteAssignment(AssignmentEntity assignment) {
    assignments.removeWhere((a) => a.id == assignment.id);
    useCases.deleteAssignment(assignment);
  }

  @action
  void deleteCompletedAssignments() {
    assignments.removeWhere((a) => a.completed);
    useCases.deleteCompletedAssignments();
  }

  void _sortCourses() => courses.sort((a, b) => a.name.compareTo(b.name));

  void _sortAssignments() =>
      assignments.sort((a, b) => a.dueDate.compareTo(b.creationDate));
}
