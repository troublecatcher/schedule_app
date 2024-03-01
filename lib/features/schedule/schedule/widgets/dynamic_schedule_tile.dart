import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/db/models/dynamic_lesson.dart';
import 'package:schedule_app/features/widgets/round_icon.dart';
import 'package:schedule_app/main.dart';

class DynamicScheduleTile extends StatelessWidget {
  const DynamicScheduleTile({
    super.key,
    required this.dynamicLesson,
    required this.index,
  });

  final DynamicLesson dynamicLesson;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        margin: const EdgeInsets.only(bottom: 4),
        color: surfaceColor,
        child: const Row(
          children: [
            SizedBox(width: 20),
            RoundIcon(icondata: Icons.remove_rounded, color: Colors.red),
          ],
        ),
      ),
      secondaryBackground: Container(color: Colors.transparent),
      onDismissed: (_) {
        scheduleController.deleteDynamicLesson(index);
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
                        DateFormat('HH:mm').format(dynamicLesson.beginning),
                      ),
                      Text(
                        DateFormat('HH:mm').format(dynamicLesson.end),
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
                    Text(dynamicLesson.name),
                    Text(
                        '${dynamicLesson.place} – ${dynamicLesson.lessonType.name}'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dynamicLesson.educator,
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
  }
}
