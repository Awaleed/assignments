import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/custom_types/custom_types.dart';
import 'class_entity.dart';

part 'assignment_entity.freezed.dart';

@freezed
abstract class AssignmentEntity with _$AssignmentEntity {
  const factory AssignmentEntity({
    @required String id,
    @required AssignmentType type,
    @required String name,
    @nullable ClassEntity classEntity,
    @required DateTime dueDate,
    @required String notes,
    @required bool completed,
  }) = _AssignmentEntity;
}
