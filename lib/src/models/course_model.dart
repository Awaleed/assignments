import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'task_model.dart';

part 'course_model.g.dart';

@HiveType(typeId: 2)
class CourseModel extends HiveObject {
  CourseModel({
    this.title,
    this.colorValue,
    this.tasks,
  });

  @HiveField(1)
  String? title;
  @HiveField(2)
  int? colorValue;
  @HiveField(3)
  List<TaskModel>? tasks;

  Color? get color {
    if (colorValue != null) return Color(colorValue!);
    return null;
  }

  @override
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
}
