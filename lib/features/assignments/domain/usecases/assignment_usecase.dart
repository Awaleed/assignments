import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:assignments/features/assignments/domain/entities/class_entity.dart';
import 'package:assignments/features/assignments/domain/repositories/assignments_repository.dart';

class AssignmentUseCases {
  final AssignmentsRepository repo;

  const AssignmentUseCases(this.repo);

  Future<List<ClassEntity>> getData() => repo.getClasses();

  Future<void> addClass(ClassEntity newClass) => repo.addClass(newClass);

  Future<void> deleteClass(ClassEntity deletedClass) =>
      repo.deleteClass(deletedClass);

  Future<void> updateClass(ClassEntity updatedClass) =>
      repo.updateClass(updatedClass);

  Future<void> addAssignment(AssignmentEntity newAssignment) =>
      repo.addAssignment(newAssignment);

  Future<void> toggleAssignment(AssignmentEntity compleatedAssignment) =>
      repo.compleateAssignment(compleatedAssignment);

  Future<void> deleteAssignment(AssignmentEntity deletedAssignment) =>
      repo.deleteAssignment(deletedAssignment);

  Future<void> updateAssignment(AssignmentEntity updatedAssignment) =>
      repo.updateAssignment(updatedAssignment);

  Future<void> deleteCompleatedAssignments() =>
      repo.deleteCompleatedAssignments();
}
