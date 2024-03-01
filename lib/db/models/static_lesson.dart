import 'package:schedule_app/db/models/lessontype.dart';
import 'package:hive/hive.dart';
import 'package:schedule_app/db/models/weekday.dart';

part 'static_lesson.g.dart';

@HiveType(typeId: 4)
class StaticLesson {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String place;
  @HiveField(2)
  final DateTime beginning;
  @HiveField(3)
  final DateTime end;
  @HiveField(4)
  final bool remind;
  @HiveField(5)
  final LessonType lessonType;
  @HiveField(6)
  final String educator;
  @HiveField(7)
  final Weekday weekday;

  StaticLesson(
      {required this.name,
      required this.place,
      required this.beginning,
      required this.end,
      required this.remind,
      required this.lessonType,
      required this.educator,
      required this.weekday});
}
