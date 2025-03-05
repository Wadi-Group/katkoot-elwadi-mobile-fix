// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pullets.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PulletsAdapter extends TypeAdapter<Pullets> {
  @override
  final int typeId = 11;

  @override
  Pullets read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pullets(
      unit: fields[0] as String?,
      defaultValue: fields[3] as int?,
      maxValue: fields[2] as int?,
      minValue: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Pullets obj) {
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
      other is PulletsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
