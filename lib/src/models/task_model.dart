<<<<<<< Updated upstream
=======
import 'package:flutter/cupertino.dart';
>>>>>>> Stashed changes
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../generated/l10n.dart';
import 'course_model.dart';

part 'task_model.g.dart';

@HiveType(typeId: 3)
enum TaskType {
  @HiveField(0)
  homework,
  @HiveField(1)
  project,
  @HiveField(2)
  quiz,
  @HiveField(3)
  test,
}

@HiveType(typeId: 4)
<<<<<<< Updated upstream
class TaskModel extends HiveObject {
  TaskModel({
=======
class TaskModel extends HiveObject with ChangeNotifier {
  TaskModel({
    this.id,
    this.isSubTask = false,
>>>>>>> Stashed changes
    this.type,
    this.title,
    this.reminder,
    this.dueDate,
    this.notes,
<<<<<<< Updated upstream
    this.progress = 0,
    this.course,
    this.subtasks,
    this.parentKey,
    this.parent,
  });

  @HiveField(1)
  CourseModel? course;
  @HiveField(2)
  TaskType? type;
  @HiveField(3)
  String? title;
  @HiveField(4)
  DateTime? reminder;
  @HiveField(5)
  DateTime? dueDate;
  @HiveField(6)
  String? notes;
  @HiveField(7)
  double? progress;
  @HiveField(8)
  List<TaskModel>? subtasks;
  @HiveField(9)
  int? parentKey;
  TaskModel? parent;

  bool get isDue => dueDate!.isBefore(DateTime.now());

  bool get isSubTask => parentKey != null;

  static String getLabel(TaskType? type) {
=======
    double progress = 0,
    this.course,
    this.subtasks,
  }) : _progress = progress {
    _listenable = ValueNotifier(this);
  }

  @HiveField(0)
  int id;
  @HiveField(1)
  CourseModel course;
  @HiveField(2)
  TaskType type;
  @HiveField(3)
  String title;
  @HiveField(4)
  DateTime reminder;
  @HiveField(5)
  DateTime dueDate;
  @HiveField(6)
  String notes;
  @HiveField(7)
  double _progress;
  @HiveField(8)
  List<TaskModel> subtasks;
  @HiveField(9)
  bool isSubTask;

  bool get isDue => dueDate.isBefore(DateTime.now());

  set progress(double value) {
    _progress = value;
    notifyListeners();
  }

  double get progress => _progress;

  @override
  void notifyListeners() {
    listenable.notifyListeners();
    super.notifyListeners();
  }

  ValueNotifier<TaskModel> get listenable => _listenable;

  ValueNotifier<TaskModel> _listenable;

  static String getLabel(TaskType type) {
>>>>>>> Stashed changes
    switch (type) {
      case TaskType.homework:
        return S.current.homework;
      case TaskType.project:
        return S.current.project;
      case TaskType.quiz:
        return S.current.quiz;
      case TaskType.test:
        return S.current.test;
      default:
        throw UnimplementedError();
    }
  }
<<<<<<< Updated upstream

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode {
    return course.hashCode ^
        type.hashCode ^
        title.hashCode ^
        reminder.hashCode ^
        dueDate.hashCode ^
        notes.hashCode ^
        progress.hashCode ^
        subtasks.hashCode ^
        parentKey.hashCode ^
        parent.hashCode;
  }
=======
>>>>>>> Stashed changes
}
