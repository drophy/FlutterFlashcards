// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardAdapter extends TypeAdapter<CardObject> {
  @override
  final int typeId = 2;

  @override
  CardObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardObject(
      question: fields[1] as String,
      answer: fields[2] as String,
    ).._group = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, CardObject obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj._group);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
