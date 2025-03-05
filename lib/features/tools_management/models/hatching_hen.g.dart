// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hatching_hen.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HatchingHenAdapter extends TypeAdapter<HatchingHen> {
  @override
  final int typeId = 12;

  @override
  HatchingHen read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HatchingHen(
      unit: fields[0] as String?,
      value: fields[4] as int?,
      maxValue: fields[3] as int?,
      minValue: fields[2] as int?,
      step: fields[5] as int?,
      title: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HatchingHen obj) {
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
      ..write(obj.value)
      ..writeByte(5)
      ..write(obj.step);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HatchingHenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
