// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcr.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FcrAdapter extends TypeAdapter<Fcr> {
  @override
  final int typeId = 6;

  @override
  Fcr read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Fcr(
      fcr: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Fcr obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.fcr);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FcrAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
