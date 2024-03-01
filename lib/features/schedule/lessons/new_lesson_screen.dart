import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/db/models/dynamic_lesson.dart';
import 'package:schedule_app/db/models/lessontype.dart';
import 'package:schedule_app/db/models/static_lesson.dart';
import 'package:schedule_app/db/models/weekday.dart';
import 'package:schedule_app/features/schedule/schedule/schedule_screen.dart';
import 'package:schedule_app/features/widgets/new_item_creation_tile.dart';
import 'package:schedule_app/main.dart';

late TextEditingController nameController;
late TextEditingController placeController;
late DateTime beginningDatetime;
late DateTime endDatetime;
late bool remind;
late LessonType lessonType;
late TextEditingController educatorController;

enum NewLessonMode { dynamic, static }

@RoutePage()
class NewLessonScreen extends StatefulWidget {
  final NewLessonMode mode;
  final int? weekday;

  const NewLessonScreen({super.key, required this.mode, this.weekday});

  @override
  State<NewLessonScreen> createState() => _NewLessonScreenState();
}

class _NewLessonScreenState extends State<NewLessonScreen> {
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    placeController = TextEditingController();
    beginningDatetime =
        setToCurrentWeek().add(const Duration(hours: 8, minutes: 30));
    endDatetime = beginningDatetime.add(const Duration(minutes: 80));
    remind = true;
    lessonType = LessonType.Lecture;
    educatorController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'New Lesson${widget.mode == NewLessonMode.static ? ' – ${Weekday.values[widget.weekday! - 1].name.capitalize}' : ''}')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              NewItemCreationTile(
                child: CupertinoTextField(
                  placeholder: 'Name',
                  controller: nameController,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              NewItemCreationTile(
                child: CupertinoTextField(
                  placeholder: 'Place',
                  controller: placeController,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                          color: whiteColor,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: CupertinoDatePicker(
                              minimumDate: widget.mode == NewLessonMode.dynamic
                                  ? setToCurrentWeek().add(
                                      const Duration(hours: 8, minutes: 30))
                                  : null,
                              initialDateTime: beginningDatetime,
                              use24hFormat: true,
                              onDateTimeChanged: (DateTime newTime) {
                                if (newTime.weekday != 7) {
                                  setState(() {
                                    beginningDatetime = newTime;
                                    endDatetime = beginningDatetime
                                        .add(const Duration(minutes: 80));
                                  });
                                }
                              },
                              mode: widget.mode == NewLessonMode.dynamic
                                  ? CupertinoDatePickerMode.dateAndTime
                                  : CupertinoDatePickerMode.time),
                        )),
                child: NewItemCreationTile(
                    child: CupertinoListTile(
                  padding: EdgeInsets.zero,
                  title: const Text('Beginning'),
                  trailing: Text(
                      DateFormat(widget.mode == NewLessonMode.dynamic
                              ? 'EEEE, HH:mm'
                              : 'HH:mm')
                          .format(beginningDatetime),
                      style: const TextStyle(color: accentColor)),
                )),
              ),
              GestureDetector(
                onTap: () => showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                          color: whiteColor,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: CupertinoDatePicker(
                            initialDateTime: endDatetime,
                            use24hFormat: true,
                            onDateTimeChanged: (DateTime newTime) {
                              setState(() {
                                if (newTime.isAfter(beginningDatetime)) {
                                  endDatetime = newTime;
                                } else {
                                  endDatetime = beginningDatetime
                                      .add(const Duration(minutes: 80));
                                }
                              });
                            },
                            mode: CupertinoDatePickerMode.time,
                          ),
                        )),
                child: NewItemCreationTile(
                    child: CupertinoListTile(
                  padding: EdgeInsets.zero,
                  title: const Text('End'),
                  trailing: Text(DateFormat('HH:mm').format(endDatetime),
                      style: const TextStyle(color: accentColor)),
                )),
              ),
              const SizedBox(height: 32),
              NewItemCreationTile(
                  child: CupertinoListTile(
                padding: EdgeInsets.zero,
                title: const Text('Reminder'),
                trailing: CupertinoSwitch(
                    value: remind,
                    onChanged: (value) => setState(() => remind = value)),
              )),
              GestureDetector(
                onTap: () => showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                          actions: List.generate(
                              LessonType.values.length,
                              (index) => CupertinoActionSheetAction(
                                  onPressed: () => setState(() {
                                        lessonType = LessonType.values[index];
                                        context.router.pop();
                                      }),
                                  child: Text(LessonType.values[index].name))),
                        )),
                child: NewItemCreationTile(
                    child: CupertinoListTile(
                  padding: EdgeInsets.zero,
                  title: const Text('Type'),
                  additionalInfo: Text(lessonType.name),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded,
                      color: accentColor),
                )),
              ),
              NewItemCreationTile(
                child: CupertinoTextField(
                  placeholder: 'Educator',
                  controller: educatorController,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              CupertinoButton(
                  color: accentColor,
                  child: const Text('Add lesson'),
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        placeController.text.isNotEmpty &&
                        educatorController.text.isNotEmpty) {
                      switch (widget.mode) {
                        case NewLessonMode.dynamic:
                          scheduleController.createDynamicLesson(
                              beginningDatetime.toIso8601String(),
                              DynamicLesson(
                                  name: nameController.text,
                                  place: placeController.text,
                                  beginning: beginningDatetime,
                                  end: endDatetime,
                                  remind: remind,
                                  lessonType: lessonType,
                                  educator: educatorController.text));
                          context.router.pop();
                          break;
                        case NewLessonMode.static:
                          scheduleController.createStaticLesson(
                              '${Weekday.values[widget.weekday! - 1].name}${DateFormat('HH:mm').format(beginningDatetime)}',
                              StaticLesson(
                                  name: nameController.text,
                                  place: placeController.text,
                                  beginning: beginningDatetime,
                                  end: endDatetime,
                                  remind: remind,
                                  lessonType: lessonType,
                                  educator: educatorController.text,
                                  weekday:
                                      Weekday.values[widget.weekday! - 1]));
                          context.router.pop();
                          break;
                        default:
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
