// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateCycleAdapter extends TypeAdapter<CreateCycle> {
  @override
  final int typeId = 23;

  @override
  CreateCycle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreateCycle(
      farmName: fields[0] as String,
      location: fields[1] as String,
      arrivalDate: fields[2] as String,
      male: fields[3] as String,
      female: fields[4] as String,
      toolId: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CreateCycle obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.farmName)
      ..writeByte(1)
      ..write(obj.location)
      ..writeByte(2)
      ..write(obj.arrivalDate)
      ..writeByte(3)
      ..write(obj.male)
      ..writeByte(4)
      ..write(obj.female)
      ..writeByte(5)
      ..write(obj.toolId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateCycleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
