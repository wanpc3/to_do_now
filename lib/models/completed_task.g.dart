// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompletedTaskAdapter extends TypeAdapter<CompletedTask> {
  @override
  final int typeId = 1;

  @override
  CompletedTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedTask(
      title: fields[0] as String,
      createdAt: fields[1] as DateTime,
      lastUpdated: fields[2] as DateTime,
      isCompleted: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedTask obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.lastUpdated)
      ..writeByte(3)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletedTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
