// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_preview_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreviewDataAdapter extends TypeAdapter<PreviewData> {
  @override
  final int typeId = 26;

  @override
  PreviewData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreviewData(
      cumulativeFemaleMortPercentage: fields[0] as MeasurementData?,
      cumulativeUtilize: fields[1] as MeasurementData?,
      eggMass: fields[2] as MeasurementData?,
      eggWeight: fields[3] as MeasurementData?,
      femaleFeed: fields[4] as MeasurementData?,
      femaleWeight: fields[5] as MeasurementData?,
      hatchedEggPerHatchedHen: fields[6] as MeasurementData?,
      hatchedHenPercentage: fields[7] as MeasurementData?,
      hatchedPercentage: fields[8] as MeasurementData?,
      hatchedWeightPercentage: fields[9] as MeasurementData?,
      lightingProgram: fields[10] as MeasurementData?,
      maleFeed: fields[11] as MeasurementData?,
      maleWeight: fields[12] as MeasurementData?,
      totalEggPerHatchedHen: fields[13] as MeasurementData?,
      utilize: fields[14] as MeasurementData?,
    );
  }

  @override
  void write(BinaryWriter writer, PreviewData obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.cumulativeFemaleMortPercentage)
      ..writeByte(1)
      ..write(obj.cumulativeUtilize)
      ..writeByte(2)
      ..write(obj.eggMass)
      ..writeByte(3)
      ..write(obj.eggWeight)
      ..writeByte(4)
      ..write(obj.femaleFeed)
      ..writeByte(5)
      ..write(obj.femaleWeight)
      ..writeByte(6)
      ..write(obj.hatchedEggPerHatchedHen)
      ..writeByte(7)
      ..write(obj.hatchedHenPercentage)
      ..writeByte(8)
      ..write(obj.hatchedPercentage)
      ..writeByte(9)
      ..write(obj.hatchedWeightPercentage)
      ..writeByte(10)
      ..write(obj.lightingProgram)
      ..writeByte(11)
      ..write(obj.maleFeed)
      ..writeByte(12)
      ..write(obj.maleWeight)
      ..writeByte(13)
      ..write(obj.totalEggPerHatchedHen)
      ..writeByte(14)
      ..write(obj.utilize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreviewDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
