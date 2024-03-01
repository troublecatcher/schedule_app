import 'package:hive/hive.dart';

part 'homework.g.dart';

@HiveType(typeId: 2)
class Homework {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String lesson;
  @HiveField(2)
  final DateTime dueTo;
  @HiveField(3)
  final bool remind;
  @HiveField(4)
  final bool isDone;
  @HiveField(5)
  final String note;

  Homework(
      {required this.title,
      required this.lesson,
      required this.dueTo,
      required this.remind,
      required this.isDone,
      required this.note});

  Homework copyWith({
    String? title,
    String? lesson,
    DateTime? dueTo,
    bool? remind,
    bool? isDone,
    String? note,
  }) {
    return Homework(
      title: title ?? this.title,
      lesson: lesson ?? this.lesson,
      dueTo: dueTo ?? this.dueTo,
      remind: remind ?? this.remind,
      isDone: isDone ?? this.isDone,
      note: note ?? this.note,
    );
  }
}
