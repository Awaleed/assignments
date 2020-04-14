import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/course_entity.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
abstract class CourseModel with _$CourseModel {
  factory CourseModel({
    @required String id,
    @required String name,
    @required int color,
  }) = _CourseModel;

  factory CourseModel.fromEntity(CourseEntity course) => _CourseModel(
        id: course.id ?? 'to_be_saved',
        name: course.name,
        color: course.color.value,
      );

  @late
  CourseEntity get entity => CourseEntity(
        id: this.id,
        name: this.name,
        color: Colors.primaries.firstWhere((c) => c.value == this.color),
      );

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
}
