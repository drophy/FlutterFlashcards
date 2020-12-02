// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FolderAdapter extends TypeAdapter<FolderObject> {
  @override
  final int typeId = 1;

  @override
  FolderObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FolderObject()
      .._id = fields[1] as int
      .._name = fields[2] as String
      .._parentName = fields[3] as String
      ..base64image = fields[4] as String
      .._folders = (fields[5] as List)?.cast<int>()
      .._decks = (fields[6] as List)?.cast<int>();
  }

  @override
  void write(BinaryWriter writer, FolderObject obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj._id)
      ..writeByte(2)
      ..write(obj._name)
      ..writeByte(3)
      ..write(obj._parentName)
      ..writeByte(4)
      ..write(obj.base64image)
      ..writeByte(5)
      ..write(obj._folders)
      ..writeByte(6)
      ..write(obj._decks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
