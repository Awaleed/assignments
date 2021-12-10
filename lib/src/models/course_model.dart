<<<<<<< Updated upstream
import 'package:flutter/foundation.dart';
=======
>>>>>>> Stashed changes
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'task_model.dart';

part 'course_model.g.dart';

@HiveType(typeId: 2)
class CourseModel extends HiveObject {
  CourseModel({
<<<<<<< Updated upstream
=======
    this.id,
>>>>>>> Stashed changes
    this.title,
    this.colorValue,
    this.tasks,
  });

<<<<<<< Updated upstream
  @HiveField(1)
  String? title;
  @HiveField(2)
  int? colorValue;
  @HiveField(3)
  List<TaskModel>? tasks;

  Color? get color {
    if (colorValue != null) return Color(colorValue!);
=======
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
>>>>>>> Stashed changes
    return null;
  }

  @override
<<<<<<< Updated upstream
  String toString() => 'CourseModel(title: $title, colorValue: $colorValue, tasks: $tasks)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseModel &&
        other.title == title &&
        other.colorValue == colorValue &&
        listEquals(other.tasks, tasks);
  }

  @override
  int get hashCode => title.hashCode ^ colorValue.hashCode ^ tasks.hashCode;
=======
  String toString() => 'CourseModel(id: $id, title: $title, colorValue: $colorValue, tasks: $tasks)';
>>>>>>> Stashed changes
}
