import 'package:meta/meta.dart';

import '../../domain/entities/assignment_entity.dart';
import '../../domain/entities/class_entity.dart';
import '../../domain/repositories/assignments_repository.dart';
import '../datasources/local_datasource.dart';
import '../models/assignment_model.dart';
import '../models/class_model.dart';

class AssignmentsRepositoryImpl extends AssignmentsRepository {
  final LocalDataSource localDataSource = LocalDataSourceImpl();

  // AssignmentsRepositoryImpl({@required this.localDataSource})
  //     : assert(localDataSource != null);
  @override
  Future<void> addClass(ClassEntity newClass) async {
    try {
      final newModel = ClassModel.fromEntity(newClass);
      final res = await localDataSource.addClass(newModel);
      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<ClassEntity>> getClasses() async {
    try {
      final classModelList = await localDataSource.getClasses();
      final classEntityList = classModelList.map((c) => c.entity).toList();
      return classEntityList;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> updateClass(ClassEntity updatedClass) async {
    try {
      final res = await localDataSource
          .updateClass(ClassModel.fromEntity(updatedClass));
      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteClass(ClassEntity deletedClass) async {
    try {
      final res = await localDataSource
          .deleteClass(ClassModel.fromEntity(deletedClass));
      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> addAssignment(AssignmentEntity newAssignment) async {
    try {
      final classModel =
          await localDataSource.getClass(newAssignment.classEntity.id);
      final assignmentModel = AssignmentModel.fromEntity(newAssignment);
      classModel.assignments.add(assignmentModel.toJson());

      final res = await localDataSource.updateClass(classModel);
      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<AssignmentEntity>> getAssignments() async {
    List<AssignmentEntity> assignmentList = [];
    try {
      final classList = await localDataSource.getClasses();
      classList.forEach((c) {
        final assignments = c.assignments
            .map((a) => AssignmentModel.fromJson(a).entity)
            .toList();
        assignmentList.addAll(assignments);
      });
    } catch (e) {
      print(e);
    }
    return assignmentList;
  }

  @override
  Future<void> updateAssignment(AssignmentEntity updatedAssignment) async {
    try {
      final classModel =
          await localDataSource.getClass(updatedAssignment.classEntity.id);
      classModel.assignments.removeWhere((a) {
        print(a['id']);
        print(updatedAssignment.id);
        return a['id'] == updatedAssignment.id;
      });

      classModel.assignments
          .add(AssignmentModel.fromEntity(updatedAssignment).toJson());

      final res = await localDataSource.updateClass(classModel);
      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> compleateAssignment(
      AssignmentEntity compleatedAssignment) async {
    final newState = !compleatedAssignment.completed;
    updateAssignment(compleatedAssignment.copyWith(completed: newState));
  }

  @override
  Future<void> deleteAssignment(AssignmentEntity deletedAssignment) async {
    try {
      final classModel =
          await localDataSource.getClass(deletedAssignment.classEntity.id);
      classModel.assignments
          .removeWhere((a) => a['id'] == deletedAssignment.id);

      final res = await localDataSource.updateClass(classModel);
      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteCompleatedAssignments() async {
    try {
      final res = await localDataSource.deleteCompleatedAssignments();
      return res;
    } catch (e) {
      print(e);
    }
  }
}
