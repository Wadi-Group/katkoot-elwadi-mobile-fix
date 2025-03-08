// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_data_value.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ValueAdapter extends TypeAdapter<Value> {
  @override
  final int typeId = 24;

  @override
  Value read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Value(
      params: fields[0] as Params?,
      previewData: fields[1] as PreviewData?,
    );
  }

  @override
  void write(BinaryWriter writer, Value obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.params)
      ..writeByte(1)
      ..write(obj.previewData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
