// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeekDataAdapter extends TypeAdapter<WeekData> {
  @override
  final int typeId = 22;

  @override
  WeekData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeekData(
      id: fields[0] as int?,
      duration: fields[1] as int?,
      value: fields[2] as Value?,
    );
  }

  @override
  void write(BinaryWriter writer, WeekData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
