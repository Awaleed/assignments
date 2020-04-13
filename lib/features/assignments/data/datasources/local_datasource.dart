import 'package:assignments/core/data_base/app_database.dart';
import 'package:assignments/features/assignments/data/models/class_model.dart';
import 'package:sembast/sembast.dart';

const CLASS_LIST_LOCAL = 'CLASS_LIST_LOCAL';
const ASSIGNMENT_LIST_LOCAL = 'ASSIGNMENT_LIST_LOCAL';

abstract class LocalDataSource {
  Future<void> addClass(ClassModel newClass);
  Future<List<ClassModel>> getClasses();
  Future<ClassModel> getClass(String classId);
  Future<void> updateClass(ClassModel updatedClass);
  Future<void> deleteClass(ClassModel deletedClass);
  Future<void> deleteCompleatedAssignments();
}

class LocalDataSourceImpl extends LocalDataSource {
  final _classListStore = stringMapStoreFactory.store(CLASS_LIST_LOCAL);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<dynamic> clearAll() async => _classListStore.drop(await _db);

  @override
  Future<void> addClass(ClassModel newClass) async {
    await _classListStore.add(await _db, newClass.toJson());
  }

  @override
  Future<List<ClassModel>> getClasses() async {
    final recordSnapshots = await _classListStore.find(await _db);
    final classModelList = recordSnapshots
        .map(
          (snapshot) =>
              ClassModel.fromJson(snapshot.value).copyWith(id: snapshot.key),
        )
        .toList();
    return classModelList;
  }

  @override
  Future<ClassModel> getClass(String classId) async {
    final classSnapshot = await _classListStore.record(classId).get(await _db);
    // final classSnapshots = await _classListStore.record(classId;
    final classModel = ClassModel.fromJson(classSnapshot).copyWith(id: classId);
    return classModel;
  }

  @override
  Future<void> updateClass(ClassModel updatedClass) async {
    await _classListStore
        .record(updatedClass.id)
        .update(await _db, updatedClass.toJson());
  }

  @override
  Future<void> deleteClass(ClassModel deletedClass) async {
    await _classListStore.record(deletedClass.id).delete(await _db);
  }

  @override
  Future<void> deleteCompleatedAssignments() async {
    final allClasses = await getClasses();

    allClasses.forEach((classE) {
      classE.assignments.removeWhere((a) => a['completed']);
    });

    final result = await _classListStore
        .records(allClasses.map((c) => c.id).toList())
        .update(await _db, allClasses.map((c) => c.toJson()).toList());
  }
}
