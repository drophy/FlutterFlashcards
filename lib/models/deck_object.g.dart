// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeckAdapter extends TypeAdapter<DeckObject> {
  @override
  final int typeId = 3;

  @override
  DeckObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeckObject()
      .._id = fields[1] as int
      .._name = fields[2] as String
      .._cards = (fields[3] as List)?.cast<CardObject>()
      .._currentCard = fields[4] as CardObject;
  }

  @override
  void write(BinaryWriter writer, DeckObject obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj._id)
      ..writeByte(2)
      ..write(obj._name)
      ..writeByte(3)
      ..write(obj._cards)
      ..writeByte(4)
      ..write(obj._currentCard);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeckAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
