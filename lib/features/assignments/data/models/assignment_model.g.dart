// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AssignmentModel _$_$_AssignmentModelFromJson(Map<String, dynamic> json) {
  return _$_AssignmentModel(
    id: json['id'] as String,
    type: json['type'] as int,
    name: json['name'] as String,
    dueDate: json['dueDate'] as int,
    notes: json['notes'] as String,
    completed: json['completed'] as bool,
  );
}

Map<String, dynamic> _$_$_AssignmentModelToJson(_$_AssignmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'dueDate': instance.dueDate,
      'notes': instance.notes,
      'completed': instance.completed,
    };
