import '../entities/assignment_entity.dart';
import '../entities/course_entity.dart';

abstract class AssignmentsRepository {
  void addCourse(CourseEntity course);
  Future<List<CourseEntity>> getCourses();
  void updateCourse(CourseEntity course);
  void deleteCourse(CourseEntity course);

  void addAssignment(AssignmentEntity assignment);
  Future<List<AssignmentEntity>> getAssignments();
  void updateAssignment(AssignmentEntity assignment);
  void deleteAssignment(AssignmentEntity assignment);

  void deleteCompletedAssignments();
}
