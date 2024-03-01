// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessontype.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonTypeAdapter extends TypeAdapter<LessonType> {
  @override
  final int typeId = 3;

  @override
  LessonType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LessonType.Lecture;
      case 1:
        return LessonType.Practice;
      case 2:
        return LessonType.Seminar;
      default:
        return LessonType.Lecture;
    }
  }

  @override
  void write(BinaryWriter writer, LessonType obj) {
    switch (obj) {
      case LessonType.Lecture:
        writer.writeByte(0);
        break;
      case LessonType.Practice:
        writer.writeByte(1);
        break;
      case LessonType.Seminar:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
