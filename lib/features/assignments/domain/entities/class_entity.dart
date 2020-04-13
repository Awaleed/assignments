import 'package:assignments/features/assignments/domain/entities/assignment_entity.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'class_entity.freezed.dart';

@freezed
abstract class ClassEntity with _$ClassEntity {
  const factory ClassEntity({
    @nullable String id,
    @required String name,
    @required MaterialColor color,
    @required List<AssignmentEntity> assignments,
  }) = _ClassEntity;
}
