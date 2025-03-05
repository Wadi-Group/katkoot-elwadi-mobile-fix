// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'defaults.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DefaultsAdapter extends TypeAdapter<Defaults> {
  @override
  final int typeId = 8;

  @override
  Defaults read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Defaults(
      feedWeight: fields[0] as double?,
      broilerLivability: fields[6] as BroilerLivability?,
      broilerPerWeek: fields[2] as BroilerPerWeek?,
      pullets: fields[3] as Pullets?,
      hatch: fields[5] as Hatch?,
      hatchedHen: fields[4] as HatchingHen?,
      pulletLivabilityToCap: fields[1] as PulletLivabilityToCap?,
    );
  }

  @override
  void write(BinaryWriter writer, Defaults obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.feedWeight)
      ..writeByte(1)
      ..write(obj.pulletLivabilityToCap)
      ..writeByte(2)
      ..write(obj.broilerPerWeek)
      ..writeByte(3)
      ..write(obj.pullets)
      ..writeByte(4)
      ..write(obj.hatchedHen)
      ..writeByte(5)
      ..write(obj.hatch)
      ..writeByte(6)
      ..write(obj.broilerLivability);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefaultsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
