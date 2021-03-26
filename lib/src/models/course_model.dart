import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'task_model.dart';

part 'course_model.g.dart';

@HiveType(typeId: 2)
class CourseModel extends HiveObject {
  CourseModel({
    this.id,
    this.title,
    this.colorValue,
    this.tasks,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  int colorValue;
  @HiveField(3)
  List<TaskModel> tasks;

  Color get color {
    if (colorValue != null) return Color(colorValue);
    return null;
  }

  @override
  String toString() => 'CourseModel(id: $id, title: $title, colorValue: $colorValue, tasks: $tasks)';
}
