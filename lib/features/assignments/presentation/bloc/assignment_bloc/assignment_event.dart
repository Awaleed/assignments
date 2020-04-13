part of 'assignment_bloc.dart';

@freezed
abstract class AssignmentsEvent with _$AssignmentsEvent {
  factory AssignmentsEvent.getData() = _GetData;
  factory AssignmentsEvent.getAssignmentsByClass(String classId) =
      _GetAssignments;

  factory AssignmentsEvent.addClass(ClassEntity newClass) = _AddClass;
  factory AssignmentsEvent.updateClass(ClassEntity updatedClass) = _UpdateClass;
  factory AssignmentsEvent.deleteClass(ClassEntity deletedClass) = _DeleteClass;

  factory AssignmentsEvent.addAssignment(AssignmentEntity newAssignment) =
      _AddAssignment;
  factory AssignmentsEvent.updateAssignment(
      AssignmentEntity updatedAssignment) = _UpdateAssignment;

  factory AssignmentsEvent.toggoleAssignment(
      AssignmentEntity compleatedAssignment) = _ToggoleAssignment;
  factory AssignmentsEvent.deleteAssignment(
      AssignmentEntity deletedAssignment) = _DeleteAssignment;
  factory AssignmentsEvent.deleteCompleatedAssignments() = _DeleteCompleatedAssignments;
}
