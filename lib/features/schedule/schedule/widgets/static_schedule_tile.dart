import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/db/boxes.dart';
import 'package:schedule_app/db/models/static_lesson.dart';
import 'package:schedule_app/db/models/weekday.dart';
import 'package:schedule_app/features/schedule/lessons/new_lesson_screen.dart';
import 'package:schedule_app/features/schedule/schedule/schedule_screen.dart';
import 'package:schedule_app/features/widgets/round_icon.dart';
import 'package:schedule_app/main.dart';
import 'package:schedule_app/router/router.dart';

class StaticScheduleTile extends StatelessWidget {
  final int index;
  const StaticScheduleTile(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime day = setToCurrentWeek().add(Duration(days: index));
    String dayString = DateFormat('EEEE, d MMM').format(day);
    List staticLessons = staticLessonsBox.values.toList();
    List currentWeekdayLessons = staticLessons
        .where((element) => element.weekday == Weekday.values[index])
        .toList();
    return Column(
      children: [
        if (index == 0) const SizedBox(height: 32),
        Row(
          children: [
            const SizedBox(width: 16),
            Text(dayString),
          ],
        ),
        if (currentWeekdayLessons.isNotEmpty)
          ...List.generate(
            currentWeekdayLessons.length,
            (idx) {
              StaticLesson currentWeekdayLesson = currentWeekdayLessons[idx];
              return Dismissible(
                direction: DismissDirection.startToEnd,
                background: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  color: surfaceColor,
                  child: const Row(
                    children: [
                      SizedBox(width: 20),
                      RoundIcon(
                          icondata: Icons.remove_rounded, color: Colors.red),
                    ],
                  ),
                ),
                secondaryBackground: Container(color: Colors.transparent),
                onDismissed: (_) {
                  scheduleController.deleteStaticLesson(
                      '${Weekday.values[index].name}${DateFormat('HH:mm').format(currentWeekdayLesson.beginning)}');
                },
                key: UniqueKey(),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: surfaceColor,
                  margin: const EdgeInsets.only(bottom: 4),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('HH:mm')
                                      .format(currentWeekdayLesson.beginning),
                                ),
                                Text(
                                  DateFormat('HH:mm')
                                      .format(currentWeekdayLesson.end),
                                ),
                              ],
                            ),
                          ],
                        )),
                        const VerticalDivider(
                          color: accentColor,
                          thickness: 2,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentWeekdayLesson.name),
                              Text(
                                  '${currentWeekdayLesson.place} – ${currentWeekdayLesson.lessonType.name}'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                currentWeekdayLesson.educator,
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => context.router.push(NewLessonRoute(
                    mode: NewLessonMode.static, weekday: index + 1)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  color: surfaceColor,
                  child: const Row(
                    children: [
                      RoundIcon(
                          icondata: Icons.add_rounded, color: accentColor),
                      SizedBox(width: 8),
                      Text('Add new'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
