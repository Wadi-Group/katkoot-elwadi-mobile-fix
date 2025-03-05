// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToolAdapter extends TypeAdapter<Tool> {
  @override
  final int typeId = 0;

  @override
  Tool read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tool(
      id: fields[0] as int?,
      title: fields[1] as String?,
      type: fields[2] as String?,
      parentCategoryTitle: fields[5] as String?,
      category: fields[7] as Category?,
      duration: fields[3] as String?,
      durationRange: fields[4] as String?,
      equation: fields[6] as Equation?,
      toolData: (fields[8] as List?)?.cast<ToolData>(),
      sliderData: fields[9] as SliderData?,
      relatedTool: fields[10] as Tool?,
    );
  }

  @override
  void write(BinaryWriter writer, Tool obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.durationRange)
      ..writeByte(5)
      ..write(obj.parentCategoryTitle)
      ..writeByte(6)
      ..write(obj.equation)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.toolData)
      ..writeByte(9)
      ..write(obj.sliderData)
      ..writeByte(10)
      ..write(obj.relatedTool);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToolAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
