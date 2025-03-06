// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CycleAdapter extends TypeAdapter<Cycle> {
  @override
  final int typeId = 21;

  @override
  Cycle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cycle(
      id: fields[0] as int?,
      name: fields[1] as String?,
      farmName: fields[2] as String?,
      arrivalDate: fields[3] as String?,
      location: fields[4] as String?,
      male: fields[5] as int?,
      female: fields[6] as int?,
      weeksList: (fields[8] as List?)?.cast<WeekData>(),
      durations: (fields[7] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cycle obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.farmName)
      ..writeByte(3)
      ..write(obj.arrivalDate)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.male)
      ..writeByte(6)
      ..write(obj.female)
      ..writeByte(7)
      ..write(obj.durations)
      ..writeByte(8)
      ..write(obj.weeksList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CycleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
