// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 16;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      id: fields[0] as int?,
      title: fields[1] as String?,
      subTitle: fields[2] as String?,
      description: fields[3] as String?,
      imageUrl: fields[4] as String?,
      categoryId: fields[5] as int?,
      haveTools: fields[6] as bool?,
      haveGuides: fields[7] as bool?,
      haveFaqs: fields[8] as bool?,
      haveVideos: fields[9] as bool?,
      videosList: (fields[10] as List?)?.cast<Video>(),
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subTitle)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.categoryId)
      ..writeByte(6)
      ..write(obj.haveTools)
      ..writeByte(7)
      ..write(obj.haveGuides)
      ..writeByte(8)
      ..write(obj.haveFaqs)
      ..writeByte(9)
      ..write(obj.haveVideos)
      ..writeByte(10)
      ..write(obj.videosList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
