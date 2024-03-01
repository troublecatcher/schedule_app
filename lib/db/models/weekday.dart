import 'package:hive/hive.dart';

part 'weekday.g.dart';

@HiveType(typeId: 5)
enum Weekday {
  @HiveField(0)
  monday,
  @HiveField(1)
  tuesday,
  @HiveField(2)
  wednesday,
  @HiveField(3)
  thursday,
  @HiveField(4)
  friday,
  @HiveField(5)
  saturday,
}
