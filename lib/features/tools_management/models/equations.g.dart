// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EquationsAdapter extends TypeAdapter<Equations> {
  @override
  final int typeId = 3;

  @override
  Equations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Equations(
      broiler: fields[0] as Broiler?,
      pullet: fields[1] as Pullet?,
      fcr: fields[2] as Fcr?,
      pef: fields[3] as Pef?,
    );
  }

  @override
  void write(BinaryWriter writer, Equations obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.broiler)
      ..writeByte(1)
      ..write(obj.pullet)
      ..writeByte(2)
      ..write(obj.fcr)
      ..writeByte(3)
      ..write(obj.pef);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
