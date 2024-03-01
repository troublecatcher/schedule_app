import 'package:hive/hive.dart';

part 'lessontype.g.dart';

@HiveType(typeId: 3)
enum LessonType {
  @HiveField(0)
  Lecture,
  @HiveField(1)
  Practice,
  @HiveField(2)
  Seminar,
}
