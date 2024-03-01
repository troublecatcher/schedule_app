import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/db/models/dynamic_lesson.dart';

class DynamicScheduleDateHeader extends StatelessWidget {
  const DynamicScheduleDateHeader({
    super.key,
    required this.dynamicLesson,
  });

  final DynamicLesson dynamicLesson;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        DateFormat('EEEE, d MMM').format(dynamicLesson.beginning),
        style: const TextStyle(
            fontWeight: FontWeight.w500, color: accentColor, fontSize: 16),
      ),
    );
  }
}
