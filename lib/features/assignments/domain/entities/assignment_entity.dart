import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/custom_types/custom_types.dart';
import 'course_entity.dart';

part 'assignment_entity.g.dart';

class AssignmentEntity extends _AssignmentEntity with _$AssignmentEntity {
  AssignmentEntity({
    String id,
    @required String courseId,
    @required AssignmentType type,
    @required String name,
    CourseEntity course,
    @required DateTime dueDate,
    @required DateTime creationDate,
    @required String notes,
    @required bool completed,
  }) : super(
          id,
          courseId,
          type,
          name,
          course,
          dueDate,
          creationDate,
          notes,
          completed,
        );
}

abstract class _AssignmentEntity with Store {
  _AssignmentEntity(
    this.id,
    this.courseId,
    this.type,
    this.name,
    this.course,
    this.dueDate,
    this.creationDate,
    this.notes,
    this.completed,
  );

  final String id;
  final DateTime creationDate;
  final String courseId;
  CourseEntity course;

  @observable
  AssignmentType type;
  @observable
  String name;
  @observable
  DateTime dueDate;
  @observable
  String notes;
  @observable
  bool completed;
}
