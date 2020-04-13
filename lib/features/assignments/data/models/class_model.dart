import 'package:assignments/features/assignments/data/models/assignment_model.dart';
import 'package:assignments/features/assignments/domain/entities/class_entity.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'class_model.freezed.dart';
part 'class_model.g.dart';

@freezed
abstract class ClassModel with _$ClassModel {
  factory ClassModel({
    @required String id,
    @required String name,
    @required int color,
    @nullable List<Map<String, dynamic>> assignments,
  }) = _ClassModel;

  factory ClassModel.fromEntity(ClassEntity entity) => _ClassModel(
        id: entity.id ?? '-1',
        name: entity.name,
        color: entity.color.value,
        assignments: entity.assignments
            .map((e) => AssignmentModel.fromEntity(e).toJson())
            .toList(),
      );

  @late
  ClassEntity get entity => ClassEntity(
        id: this.id,
        name: this.name,
        color: Colors.primaries.firstWhere((c) => c.value == this.color),
        assignments: this
            .assignments
            .map(
              (a) => AssignmentModel.fromJson(a)
                  .entity
                  .copyWith(classEntity: this.entity),
            )
            .toList(),
      );

  factory ClassModel.fromJson(Map<String, dynamic> json) =>
      _$ClassModelFromJson(json);
}
