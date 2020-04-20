import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'course_entity.g.dart';

// abstract class Course with _$Course {
//   const factory  = _Course;
// }
@HiveType(typeId: 0)
class Course extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  int colorIndex;

  Color get color => Colors.primaries[colorIndex];

  Course({
    this.id,
    this.title,
    this.colorIndex,
  });
}
