// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hatch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HatchAdapter extends TypeAdapter<Hatch> {
  @override
  final int typeId = 13;

  @override
  Hatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hatch(
      unit: fields[0] as String?,
      defaultValue: fields[4] as int?,
      maxValue: fields[3] as int?,
      minValue: fields[2] as int?,
      step: fields[5] as int?,
      title: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Hatch obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.unit)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.minValue)
      ..writeByte(3)
      ..write(obj.maxValue)
      ..writeByte(4)
      ..write(obj.defaultValue)
      ..writeByte(5)
      ..write(obj.step);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
