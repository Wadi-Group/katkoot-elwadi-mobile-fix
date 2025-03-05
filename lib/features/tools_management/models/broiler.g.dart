// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broiler.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BroilerAdapter extends TypeAdapter<Broiler> {
  @override
  final int typeId = 4;

  @override
  Broiler read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Broiler(
      broilersPerYear: fields[0] as String?,
      chickenPlacedBeforeDeath: fields[1] as String?,
      placedEggs: fields[2] as String?,
      hen: fields[3] as String?,
      pullets: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Broiler obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.broilersPerYear)
      ..writeByte(1)
      ..write(obj.chickenPlacedBeforeDeath)
      ..writeByte(2)
      ..write(obj.placedEggs)
      ..writeByte(3)
      ..write(obj.hen)
      ..writeByte(4)
      ..write(obj.pullets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BroilerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
