// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_data_value_params.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParamsAdapter extends TypeAdapter<Params> {
  @override
  final int typeId = 25;

  @override
  Params read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Params(
      femaleFeed: fields[0] as int?,
      maleFeed: fields[1] as int?,
      cycleFemale: fields[2] as int?,
      cycleMale: fields[3] as int?,
      femaleWeight: fields[4] as int?,
      maleWeight: fields[5] as int?,
      femaleMort: fields[6] as int?,
      maleMort: fields[7] as int?,
      sexErrors: fields[8] as int?,
      culls: fields[9] as int?,
      lightingProg: fields[10] as int?,
      totalEgg: fields[11] as int?,
      hatchedEgg: fields[12] as int?,
      eggWeight: fields[29] as double?,
      lastWeekCumulativeLoses: fields[13] as int?,
      lastWeekCumulativeFemaleMort: fields[14] as int?,
      lastWeekCumulativeMaleMort: fields[15] as int?,
      lastWeekFemaleBalance: fields[16] as int?,
      lastWeekMaleBalance: fields[17] as int?,
      lastWeekCumulativeTotalEggs: fields[18] as int?,
      lastWeekCumulativeHatchedEgg: fields[19] as int?,
      loses: fields[20] as int?,
      cumulativeLoses: fields[21] as int?,
      cumulativeFemaleMort: fields[22] as int?,
      cumulativeMaleMort: fields[23] as int?,
      cumulativeTotalEggs: fields[24] as int?,
      cumulativeHatchedEgg: fields[25] as int?,
      femaleBalance: fields[26] as int?,
      cumulativeFemaleMortPercentage: fields[27] as double?,
      utilize: fields[28] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Params obj) {
    writer
      ..writeByte(30)
      ..writeByte(0)
      ..write(obj.femaleFeed)
      ..writeByte(1)
      ..write(obj.maleFeed)
      ..writeByte(2)
      ..write(obj.cycleFemale)
      ..writeByte(3)
      ..write(obj.cycleMale)
      ..writeByte(4)
      ..write(obj.femaleWeight)
      ..writeByte(5)
      ..write(obj.maleWeight)
      ..writeByte(6)
      ..write(obj.femaleMort)
      ..writeByte(7)
      ..write(obj.maleMort)
      ..writeByte(8)
      ..write(obj.sexErrors)
      ..writeByte(9)
      ..write(obj.culls)
      ..writeByte(10)
      ..write(obj.lightingProg)
      ..writeByte(11)
      ..write(obj.totalEgg)
      ..writeByte(12)
      ..write(obj.hatchedEgg)
      ..writeByte(13)
      ..write(obj.lastWeekCumulativeLoses)
      ..writeByte(14)
      ..write(obj.lastWeekCumulativeFemaleMort)
      ..writeByte(15)
      ..write(obj.lastWeekCumulativeMaleMort)
      ..writeByte(16)
      ..write(obj.lastWeekFemaleBalance)
      ..writeByte(17)
      ..write(obj.lastWeekMaleBalance)
      ..writeByte(18)
      ..write(obj.lastWeekCumulativeTotalEggs)
      ..writeByte(19)
      ..write(obj.lastWeekCumulativeHatchedEgg)
      ..writeByte(20)
      ..write(obj.loses)
      ..writeByte(21)
      ..write(obj.cumulativeLoses)
      ..writeByte(22)
      ..write(obj.cumulativeFemaleMort)
      ..writeByte(23)
      ..write(obj.cumulativeMaleMort)
      ..writeByte(24)
      ..write(obj.cumulativeTotalEggs)
      ..writeByte(25)
      ..write(obj.cumulativeHatchedEgg)
      ..writeByte(26)
      ..write(obj.femaleBalance)
      ..writeByte(27)
      ..write(obj.cumulativeFemaleMortPercentage)
      ..writeByte(28)
      ..write(obj.utilize)
      ..writeByte(29)
      ..write(obj.eggWeight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParamsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
