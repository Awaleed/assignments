import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'course_entity.g.dart';

// abstract class CourseEntity with _$CourseEntity {
//   const factory  = _CourseEntity;
// }

class CourseEntity extends _CourseEntity with _$CourseEntity {
  CourseEntity({
    String id,
    @required String name,
    @required MaterialColor color,
  }) : super(id, name, color);
}

abstract class _CourseEntity with Store {
  _CourseEntity(this.id, this.name, this.color);

  final String id;

  @observable
  String name;

  @observable
  MaterialColor color;
}
