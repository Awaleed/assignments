import '../entities/assignment_entity.dart';
import '../entities/course_entity.dart';
import 'package:assignments/features/assignments/domain/repositories/assignments_repository.dart';

class AssignmentUseCases {
  final AssignmentsRepository repo;

  const AssignmentUseCases(this.repo);

  //! CRUD - Courses
  void addCourse(CourseEntity course) => repo.addCourse(course);
  Future<List<CourseEntity>> getCourses() => repo.getCourses();
  void updateCourse(CourseEntity course) => repo.updateCourse(course);
  void deleteCourse(CourseEntity course) => repo.deleteCourse(course);

  //! CRUD - Assignments
  void addAssignment(AssignmentEntity assignment) =>
      repo.addAssignment(assignment);
  Future<List<AssignmentEntity>> getAssignments() => repo.getAssignments();
  void updateAssignment(AssignmentEntity assignment) =>
      repo.updateAssignment(assignment);
  void deleteAssignment(AssignmentEntity assignment) =>
      repo.deleteAssignment(assignment);

  //! Additional Use Cases for Assignments
  void deleteCompletedAssignments() => repo.deleteCompletedAssignments();
}
