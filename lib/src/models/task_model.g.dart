// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeAdapter extends TypeAdapter<TaskType> {
  @override
  final int typeId = 3;

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
        return TaskType.homework;
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

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 4;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      type: fields[2] as TaskType?,
      title: fields[3] as String?,
      reminder: fields[4] as DateTime?,
      dueDate: fields[5] as DateTime?,
      notes: fields[6] as String?,
      progress: fields[7] as double?,
      course: fields[1] as CourseModel?,
      subtasks: (fields[8] as List?)?.cast<TaskModel>(),
      parentKey: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.course)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.reminder)
      ..writeByte(5)
      ..write(obj.dueDate)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.progress)
      ..writeByte(8)
      ..write(obj.subtasks)
      ..writeByte(9)
      ..write(obj.parentKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
