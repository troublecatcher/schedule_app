import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/db/boxes.dart';
import 'package:schedule_app/db/models/dynamic_lesson.dart';
import 'package:schedule_app/features/schedule/lessons/new_lesson_screen.dart';
import 'package:schedule_app/features/schedule/schedule/widgets/dynamic_schedule_date_header.dart';
import 'package:schedule_app/features/schedule/schedule/widgets/dynamic_schedule_tile.dart';
import 'package:schedule_app/features/schedule/schedule/widgets/empty_dynamic_schedule_placeholder.dart';
import 'package:schedule_app/features/schedule/schedule/widgets/static_schedule_tile.dart';
import 'package:schedule_app/main.dart';
import 'package:schedule_app/router/router.dart';

@RoutePage()
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    scheduleController.initScheduleMode();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        actions: [
          GetBuilder(
              init: scheduleController,
              builder: (_) {
                if (dynamicLessonsBox.isNotEmpty &&
                    !scheduleController.isStatic) {
                  return CupertinoButton(
                      onPressed: () => context.router
                          .push(NewLessonRoute(mode: NewLessonMode.dynamic)),
                      child: const Icon(Icons.add_rounded, color: accentColor));
                } else {
                  return const SizedBox.shrink();
                }
              })
        ],
      ),
      body: SafeArea(
        child: Center(
          child: GetBuilder(
            init: scheduleController,
            builder: (controller) {
              if (!scheduleController.isStatic) {
                if (dynamicLessonsBox.isEmpty) {
                  return const EmptyDynamicSchedulePlaceholder();
                } else {
                  return ListView.builder(
                      itemCount: dynamicLessonsBox.length,
                      itemBuilder: (context, index) {
                        List dynamicLessons = dynamicLessonsBox.values.toList();
                        DynamicLesson dynamicLesson = dynamicLessons[index];
                        bool isSameDateAsPrevious = index > 0 &&
                            dynamicLesson.beginning.day ==
                                dynamicLessons[index - 1].beginning.day;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index == 0) const SizedBox(height: 32),
                            if (!isSameDateAsPrevious)
                              DynamicScheduleDateHeader(
                                  dynamicLesson: dynamicLesson),
                            DynamicScheduleTile(
                                dynamicLesson: dynamicLesson, index: index),
                          ],
                        );
                      });
                }
              } else {
                return ListView(
                  children:
                      List.generate(6, (index) => StaticScheduleTile(index)),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

DateTime setToCurrentWeek() {
  DateTime now = DateTime.now();
  int currentWeekday = now.weekday;
  Duration offset = Duration(days: currentWeekday - DateTime.monday);
  DateTime monday = now.subtract(offset);
  return DateTime(monday.year, monday.month, monday.day, 0, 0, 0, 0, 0);
}
