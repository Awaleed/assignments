import '../entities/assignment_entity.dart';
import '../entities/class_entity.dart';

abstract class AssignmentsRepository {
  Future<void> addClass(ClassEntity newClass);
  Future<List<ClassEntity>> getClasses();
  Future<void> updateClass(ClassEntity updatedClass);
  Future<void> deleteClass(ClassEntity deletedClass);

  Future<void> addAssignment(AssignmentEntity newAssignment);
  Future<List<AssignmentEntity>> getAssignments();
  Future<void> updateAssignment(AssignmentEntity updatedAssignment);
  Future<void> compleateAssignment(AssignmentEntity compleatedAssignment);
  Future<void> deleteAssignment(AssignmentEntity deletedAssignment);

  Future<void> deleteCompleatedAssignments();
}
