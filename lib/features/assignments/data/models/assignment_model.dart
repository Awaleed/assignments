import 'package:assignments/core/custom_types/custom_types.dart';
import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

part 'assignment_model.freezed.dart';
part 'assignment_model.g.dart';

@freezed
abstract class AssignmentModel with _$AssignmentModel {
  factory AssignmentModel({
    @required String id,
    @required int type,
    @required String name,
    @required int dueDate,
    @required String notes,
    @required bool completed,
  }) = _AssignmentModel;

  factory AssignmentModel.fromEntity(AssignmentEntity entity) =>
      AssignmentModel(
        id: entity.id,
        type: entity.type.index,
        name: entity.name,
        dueDate: entity.dueDate.millisecondsSinceEpoch,
        notes: entity.notes,
        completed: entity.completed,
      );

  @late
  AssignmentEntity get entity => AssignmentEntity(
        id: this.id,
        type: AssignmentType.values[this.type],
        name: this.name,
        dueDate: DateTime.fromMillisecondsSinceEpoch(this.dueDate),
        notes: this.notes,
        completed: this.completed,
        classEntity: null,
      );

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);
}
