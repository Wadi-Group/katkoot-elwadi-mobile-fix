// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equations_result_title.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EquationsResultTitleAdapter extends TypeAdapter<EquationsResultTitle> {
  @override
  final int typeId = 15;

  @override
  EquationsResultTitle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EquationsResultTitle(
      broilersPerYear: fields[0] as String?,
      placedEggs: fields[1] as String?,
      hatchingEggs: fields[2] as String?,
      hen: fields[3] as String?,
      broilersPerWeek: fields[4] as String?,
      chickenPlacedBeforeDeath: fields[5] as String?,
      pullets: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EquationsResultTitle obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.broilersPerYear)
      ..writeByte(1)
      ..write(obj.placedEggs)
      ..writeByte(2)
      ..write(obj.hatchingEggs)
      ..writeByte(3)
      ..write(obj.hen)
      ..writeByte(4)
      ..write(obj.broilersPerWeek)
      ..writeByte(5)
      ..write(obj.chickenPlacedBeforeDeath)
      ..writeByte(6)
      ..write(obj.pullets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquationsResultTitleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
