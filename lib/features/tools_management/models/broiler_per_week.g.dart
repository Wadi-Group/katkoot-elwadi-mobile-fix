// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broiler_per_week.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BroilerPerWeekAdapter extends TypeAdapter<BroilerPerWeek> {
  @override
  final int typeId = 10;

  @override
  BroilerPerWeek read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BroilerPerWeek(
      unit: fields[0] as String?,
      defaultValue: fields[3] as int?,
      maxValue: fields[2] as int?,
      minValue: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BroilerPerWeek obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.unit)
      ..writeByte(1)
      ..write(obj.minValue)
      ..writeByte(2)
      ..write(obj.maxValue)
      ..writeByte(3)
      ..write(obj.defaultValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroilerPerWeekAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
