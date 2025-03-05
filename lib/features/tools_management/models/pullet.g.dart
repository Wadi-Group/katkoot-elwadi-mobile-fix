// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pullet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PulletAdapter extends TypeAdapter<Pullet> {
  @override
  final int typeId = 5;

  @override
  Pullet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pullet(
      broilersPerYear: fields[0] as String?,
      hen: fields[3] as String?,
      placedEggs: fields[1] as String?,
      broilersPerWeek: fields[4] as String?,
      hatchingEggs: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Pullet obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.broilersPerYear)
      ..writeByte(1)
      ..write(obj.placedEggs)
      ..writeByte(2)
      ..write(obj.hatchingEggs)
      ..writeByte(3)
      ..write(obj.hen)
      ..writeByte(4)
      ..write(obj.broilersPerWeek);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PulletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
