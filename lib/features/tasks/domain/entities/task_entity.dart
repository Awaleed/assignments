import 'package:hive/hive.dart';

import '../../../../core/custom_types/custom_types.dart';
import 'course_entity.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  Task({
    this.id,
    this.isSubTask = false,
    this.type,
    this.title,
    this.reminder,
    this.dueDate,
    this.notes,
    this.progress,
    this.course,
    this.subtasks,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  Course course;
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
  double progress;
  @HiveField(8)
  List<Task> subtasks;
  @HiveField(9)
  final bool isSubTask;
}
