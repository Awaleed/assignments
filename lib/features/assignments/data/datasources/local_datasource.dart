import 'package:assignments/core/data_base/app_database.dart';
import 'package:assignments/features/assignments/data/models/assignment_model.dart';
import 'package:sembast/sembast.dart';

const COURSES_STORE = 'COURSES_STORE';
const ASSIGNMENT_STORE = 'ASSIGNMENT_STORE';

abstract class LocalDataSource {
  void addCourse(Map<String, dynamic> course);
  Future<List<Map<String, dynamic>>> getCourses();
  void updateCourse(Map<String, dynamic> course);
  void deleteCourse(Map<String, dynamic> course);

  void addAssignment(Map<String, dynamic> assignment);
  Future<List<Map<String, dynamic>>> getAssignments();
  void updateAssignment(Map<String, dynamic> assignment);
  void deleteAssignment(Map<String, dynamic> assignment);

  void deleteCompletedAssignments();
}

class LocalDataSourceImpl extends LocalDataSource {
  final _coursesStore = stringMapStoreFactory.store(COURSES_STORE);
  final _assignmentsStore = stringMapStoreFactory.store(ASSIGNMENT_STORE);

  Future<Database> get _db async => await AppDatabase.instance.database;

  void clearAll() async {
    _coursesStore.drop(await _db);
    _assignmentsStore.drop(await _db);
    print('DB: Rested');
  }

  @override
  void addCourse(Map<String, dynamic> course) async {
    _coursesStore.add(await _db, course);
  }

  Future<List<Map<String, dynamic>>> getCourses() async {
    final recordSnapshots = await _coursesStore.find(await _db);
    final List<Map<String, dynamic>> coursesJson = [];
    recordSnapshots.forEach(
      (snapshot) {
        final Map<String, dynamic> courseJson = {};
        snapshot.value.forEach((key, value) => courseJson[key] = value);
        courseJson['id'] = snapshot.key;
        coursesJson.add(courseJson);
      },
    );

    return coursesJson;
  }

  @override
  void updateCourse(Map<String, dynamic> course) async {
    _coursesStore.record(course['id']).update(await _db, course);
  }

  @override
  void deleteCourse(Map<String, dynamic> course) async {
    _coursesStore.record(course['id']).delete(await _db);
    _deleteAssignments(Finder(filter: Filter.equals('courseId', course['id'])));
  }

  @override
  void addAssignment(Map<String, dynamic> assignment) async {
    await _assignmentsStore.add(await _db, assignment);
  }

  @override
  Future<List<Map<String, dynamic>>> getAssignments() async {
    final recordSnapshots = await _assignmentsStore.find(await _db);
    final List<Map<String, dynamic>> assignmentsJson = [];
    recordSnapshots.forEach(
      (snapshot) {
        final Map<String, dynamic> assignmentJson = {};
        snapshot.value.forEach((key, value) => assignmentJson[key] = value);
        assignmentJson['id'] = snapshot.key;
        assignmentsJson.add(assignmentJson);
      },
    );

    return assignmentsJson;
  }

  @override
  void updateAssignment(Map<String, dynamic> assignment) async {
    _assignmentsStore.record(assignment['id']).update(await _db, assignment);
  }

  @override
  void deleteAssignment(Map<String, dynamic> assignment) async {
    _assignmentsStore.record(assignment['id']).delete(await _db);
  }

  @override
  void deleteCompletedAssignments() {
    _deleteAssignments(Finder(filter: Filter.equals('completed', true)));
  }

  void _deleteAssignments(Finder finder) async {
    _assignmentsStore.delete(await _db, finder: finder);
  }
}
