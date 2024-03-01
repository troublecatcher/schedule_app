import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/db/models/homework.dart';
import 'package:schedule_app/db/models/weekday.dart';
import 'package:schedule_app/features/widgets/round_icon.dart';
import 'package:schedule_app/main.dart';

class UndoneHomeworkWidget extends StatelessWidget {
  const UndoneHomeworkWidget({
    super.key,
    required this.homework,
    required this.index,
  });

  final Homework homework;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
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
      secondaryBackground: Container(
        color: Colors.green,
        margin: const EdgeInsets.only(bottom: 4),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RoundIcon(icondata: Icons.check_rounded, color: Colors.green),
            SizedBox(width: 20),
          ],
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          homeworkController.deleteHomework(
              '${homework.title}${homework.lesson}${DateFormat('dMMM').format(homework.dueTo)}');
        }
        if (direction == DismissDirection.endToStart) {
          homeworkController.createHomework(
              '${homework.title}${homework.lesson}${DateFormat('dMMM').format(homework.dueTo)}',
              homework.copyWith(isDone: true));
        }
      },
      key: UniqueKey(),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: surfaceColor,
        margin: const EdgeInsets.only(bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homework.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    homework.lesson,
                    style: const TextStyle(color: secondaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    homework.note,
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    '${Weekday.values[homework.dueTo.weekday - 1].name.capitalize}, ${DateFormat('dd/MM').format(homework.dueTo)}',
                    style: const TextStyle(color: accentColor),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
