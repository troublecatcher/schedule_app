// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_lesson.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StaticLessonAdapter extends TypeAdapter<StaticLesson> {
  @override
  final int typeId = 4;

  @override
  StaticLesson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StaticLesson(
      name: fields[0] as String,
      place: fields[1] as String,
      beginning: fields[2] as DateTime,
      end: fields[3] as DateTime,
      remind: fields[4] as bool,
      lessonType: fields[5] as LessonType,
      educator: fields[6] as String,
      weekday: fields[7] as Weekday,
    );
  }

  @override
  void write(BinaryWriter writer, StaticLesson obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.place)
      ..writeByte(2)
      ..write(obj.beginning)
      ..writeByte(3)
      ..write(obj.end)
      ..writeByte(4)
      ..write(obj.remind)
      ..writeByte(5)
      ..write(obj.lessonType)
      ..writeByte(6)
      ..write(obj.educator)
      ..writeByte(7)
      ..write(obj.weekday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StaticLessonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
