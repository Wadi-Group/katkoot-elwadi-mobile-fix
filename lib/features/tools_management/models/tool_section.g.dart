// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool_section.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToolSectionAdapter extends TypeAdapter<ToolSection> {
  @override
  final int typeId = 20;

  @override
  ToolSection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToolSection(
      sectionName: fields[0] as String?,
      columns: fields[1] as Column?,
      data: (fields[2] as List?)?.cast<Column>(),
      showColumnTitle: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ToolSection obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sectionName)
      ..writeByte(1)
      ..write(obj.columns)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.showColumnTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToolSectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
