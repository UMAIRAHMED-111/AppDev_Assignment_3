// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 1;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      category: fields[3] as NoteCategory,
      isPinned: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.isPinned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteCategoryAdapter extends TypeAdapter<NoteCategory> {
  @override
  final int typeId = 0;

  @override
  NoteCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteCategory.Work;
      case 1:
        return NoteCategory.Personal;
      case 2:
        return NoteCategory.Study;
      default:
        return NoteCategory.Work;
    }
  }

  @override
  void write(BinaryWriter writer, NoteCategory obj) {
    switch (obj) {
      case NoteCategory.Work:
        writer.writeByte(0);
        break;
      case NoteCategory.Personal:
        writer.writeByte(1);
        break;
      case NoteCategory.Study:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
