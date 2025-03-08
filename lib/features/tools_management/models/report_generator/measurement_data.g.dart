// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeasurementDataAdapter extends TypeAdapter<MeasurementData> {
  @override
  final int typeId = 27;

  @override
  MeasurementData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeasurementData(
      unit: fields[0] as String?,
      value: fields[1] as double?,
      standard: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, MeasurementData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.unit)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.standard);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasurementDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
