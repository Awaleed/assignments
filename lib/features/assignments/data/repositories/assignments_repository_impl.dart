import 'package:assignments/features/assignments/data/models/assignment_model.dart';
import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';

import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/assignments_repository.dart';
import '../datasources/local_datasource.dart';
import '../models/course_model.dart';

class AssignmentsRepositoryImpl extends AssignmentsRepository {
  final LocalDataSource localDataSource = LocalDataSourceImpl();

  @override
  void addCourse(CourseEntity course) {
    final courseJson = CourseModel.fromEntity(course).toJson();
    localDataSource.addCourse(courseJson);
    print('addCourse(CourseEntity): $course');
  }

  @override
  Future<List<CourseEntity>> getCourses() async {
    final coursesJson = await localDataSource.getCourses();
    final courses =
        coursesJson.map((json) => CourseModel.fromJson(json).entity).toList();
    print('getCourses(): $courses');
    return courses;
  }

  @override
  void updateCourse(CourseEntity course) {
    localDataSource.updateCourse(CourseModel.fromEntity(course).toJson());
    print('updateCourse(CourseEntity): $course');
  }

  @override
  void deleteCourse(CourseEntity course) {
    localDataSource.deleteCourse(CourseModel.fromEntity(course).toJson());
    print('deleteCourse(CourseEntity): $course');
  }

  @override
  void addAssignment(AssignmentEntity assignment) {
    final assignmentJson = AssignmentModel.fromEntity(assignment).toJson();
    localDataSource.addAssignment(assignmentJson);
    print('addAssignment(AssignmentEntity): $assignment');
  }

  @override
  Future<List<AssignmentEntity>> getAssignments() async {
    final assignmentsJson = await localDataSource.getAssignments();
    final assignments = assignmentsJson
        .map((json) => AssignmentModel.fromJson(json).entity)
        .toList();
    print('getAssignments(): $assignments');
    return assignments;
  }

  @override
  void updateAssignment(AssignmentEntity assignment) {
    localDataSource
        .updateAssignment(AssignmentModel.fromEntity(assignment).toJson());
    print('updateAssignment(AssignmentEntity): $assignment');
  }

  @override
  void deleteAssignment(AssignmentEntity assignment) {
    localDataSource.deleteAssignment(
      AssignmentModel.fromEntity(assignment).toJson(),
    );
    print('deleteCourse(CourseEntity): $assignment');
  }

  @override
  void deleteCompletedAssignments() {
    localDataSource.deleteCompletedAssignments();
    print('deleteCompletedAssignments(): ');
  }

  // @override
  // Future<void> addAssignment(AssignmentEntity newAssignment) async {
  //   try {
  //     final classModel =
  //         await localDataSource.getClass(newAssignment.classEntity.id);
  //     final assignmentModel = AssignmentModel.fromEntity(newAssignment);
  //     classModel.assignments.add(assignmentModel.toJson());

  //     final res = await localDataSource.updateClass(classModel);
  //     print('addAssignment(AssignmentEntity): $newAssignment');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // Future<List<AssignmentEntity>> getAssignments() async {
  //   List<AssignmentEntity> assignmentList = [];
  //   try {
  //     final classList = await localDataSource.getClasses();
  //     classList.forEach((c) {
  //       final assignments = c.assignments
  //           .map((a) => AssignmentModel.fromJson(a).entity)
  //           .toList();
  //       assignmentList.addAll(assignments);
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  //   return assignmentList;
  // }

  // @override
  // Future<void> updateAssignment(AssignmentEntity updatedAssignment) async {
  //   try {
  //     final classModel =
  //         await localDataSource.getClass(updatedAssignment.classEntity.id);
  //     classModel.assignments.removeWhere((a) {
  //       return a['id'] == updatedAssignment.id;
  //     });

  //     classModel.assignments
  //         .add(AssignmentModel.fromEntity(updatedAssignment).toJson());

  //     final res = await localDataSource.updateClass(classModel);
  //     return res;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // Future<void> completeAssignment(AssignmentEntity completedAssignment) async {
  //   final newState = !completedAssignment.completed;
  //   updateAssignment(completedAssignment.copyWith(completed: newState));
  // }

  // @override
  // Future<void> deleteAssignment(AssignmentEntity deletedAssignment) async {
  //   try {
  //     final classModel =
  //         await localDataSource.getClass(deletedAssignment.classEntity.id);
  //     classModel.assignments
  //         .removeWhere((a) => a['id'] == deletedAssignment.id);

  //     final res = await localDataSource.updateClass(classModel);
  //     return res;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // Future<void> deleteCompletedAssignments() async {
  //   try {
  //     final res = await localDataSource.deleteCompletedAssignments();
  //     return res;
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
