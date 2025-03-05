// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToolDataAdapter extends TypeAdapter<ToolData> {
  @override
  final int typeId = 19;

  @override
  ToolData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToolData(
      durationFrom: fields[0] as int?,
      durationTo: fields[1] as int?,
      sections: (fields[2] as List?)?.cast<ToolSection>(),
    );
  }

  @override
  void write(BinaryWriter writer, ToolData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.durationFrom)
      ..writeByte(1)
      ..write(obj.durationTo)
      ..writeByte(2)
      ..write(obj.sections);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToolDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
