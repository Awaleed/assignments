import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/custom_types/custom_types.dart';
import '../../domain/entities/assignment_entity.dart';

part 'assignment_model.freezed.dart';
part 'assignment_model.g.dart';

@freezed
abstract class AssignmentModel with _$AssignmentModel {
  factory AssignmentModel({
    @required String id,
    @required String course,
    @required int type,
    @required String name,
    @required int dueDate,
    @required int creationDate,
    @required String notes,
    @required bool completed,
  }) = _AssignmentModel;

  factory AssignmentModel.fromEntity(AssignmentEntity entity) =>
      AssignmentModel(
        id: entity.id,
        course: entity.courseId,
        type: entity.type.index,
        name: entity.name,
        dueDate: entity.dueDate.millisecondsSinceEpoch,
        creationDate: entity.creationDate.millisecondsSinceEpoch,
        notes: entity.notes,
        completed: entity.completed,
      );

  @late
  AssignmentEntity get entity => AssignmentEntity(
        id: this.id,
        courseId: this.course,
        course: null,
        type: AssignmentType.values[this.type],
        name: this.name,
        dueDate: DateTime.fromMillisecondsSinceEpoch(this.dueDate),
        creationDate: DateTime.fromMillisecondsSinceEpoch(this.creationDate),
        notes: this.notes,
        completed: this.completed,
      );

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);
}
