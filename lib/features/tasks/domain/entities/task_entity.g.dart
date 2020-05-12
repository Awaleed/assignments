// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  Task read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[0] as int,
      isSubTask: fields[9] as bool,
      type: fields[2] as TaskType,
      title: fields[3] as String,
      reminder: fields[4] as DateTime,
      dueDate: fields[5] as DateTime,
      notes: fields[6] as String,
      progress: fields[7] as double,
      course: fields[1] as Course,
      subtasks: (fields[8] as List)?.cast<Task>(),
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
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
      ..write(obj.isSubTask);
  }
}
