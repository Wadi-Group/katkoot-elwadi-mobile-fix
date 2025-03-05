// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EquationAdapter extends TypeAdapter<Equation> {
  @override
  final int typeId = 1;

  @override
  Equation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Equation(
      parameters: (fields[0] as List?)?.cast<String>(),
      equations: fields[1] as Equations?,
      defaults: fields[2] as Defaults?,
      resultTitle: fields[3] as EquationsResultTitle?,
    );
  }

  @override
  void write(BinaryWriter writer, Equation obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.parameters)
      ..writeByte(1)
      ..write(obj.equations)
      ..writeByte(2)
      ..write(obj.defaults)
      ..writeByte(3)
      ..write(obj.resultTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
