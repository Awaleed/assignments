// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClassModel _$_$_ClassModelFromJson(Map<String, dynamic> json) {
  return _$_ClassModel(
    id: json['id'] as String,
    name: json['name'] as String,
    color: json['color'] as int,
    assignments: (json['assignments'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_ClassModelToJson(_$_ClassModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'assignments': instance.assignments,
    };
