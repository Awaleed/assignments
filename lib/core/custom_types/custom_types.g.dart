// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeAdapter extends TypeAdapter<TaskType> {
  @override
  final int typeId = 2;

  @override
  TaskType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskType.homework;
      case 1:
        return TaskType.project;
      case 2:
        return TaskType.quiz;
      case 3:
        return TaskType.test;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, TaskType obj) {
    switch (obj) {
      case TaskType.homework:
        writer.writeByte(0);
        break;
      case TaskType.project:
        writer.writeByte(1);
        break;
      case TaskType.quiz:
        writer.writeByte(2);
        break;
      case TaskType.test:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
