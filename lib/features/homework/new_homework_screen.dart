import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedule_app/db/models/homework.dart';
import 'package:schedule_app/main.dart';

import '../../const.dart';
import '../widgets/new_item_creation_tile.dart';

late TextEditingController titleController;
late TextEditingController lessonController;
late DateTime dueTo;
late bool remind;
late bool isDone;
late TextEditingController noteController;

@RoutePage()
class NewHomeworkScreen extends StatefulWidget {
  const NewHomeworkScreen({super.key});

  @override
  State<NewHomeworkScreen> createState() => _NewHomeworkScreenState();
}

class _NewHomeworkScreenState extends State<NewHomeworkScreen> {
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    lessonController = TextEditingController();
    dueTo = DateTime.now();
    remind = true;
    isDone = false;
    noteController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Homework')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              NewItemCreationTile(
                child: CupertinoTextField(
                  placeholder: 'Title',
                  controller: titleController,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              NewItemCreationTile(
                child: CupertinoTextField(
                  placeholder: 'Lesson',
                  controller: lessonController,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                          color: whiteColor,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              use24hFormat: true,
                              onDateTimeChanged: (DateTime newTime) {
                                if (newTime.weekday != 7) {
                                  setState(() {
                                    dueTo = newTime;
                                  });
                                }
                              },
                              mode: CupertinoDatePickerMode.date),
                        )),
                child: NewItemCreationTile(
                    child: CupertinoListTile(
                  padding: EdgeInsets.zero,
                  title: const Text('Due to'),
                  trailing: Text(DateFormat('d MMM').format(dueTo),
                      style: const TextStyle(color: accentColor)),
                )),
              ),
              NewItemCreationTile(
                  child: CupertinoListTile(
                padding: EdgeInsets.zero,
                title: const Text('Reminder'),
                trailing: CupertinoSwitch(
                    value: remind,
                    onChanged: (value) => setState(() => remind = value)),
              )),
              NewItemCreationTile(
                  child: CupertinoListTile(
                padding: EdgeInsets.zero,
                title: const Text('Done'),
                trailing: CupertinoSwitch(
                    value: isDone,
                    onChanged: (value) => setState(() => isDone = value)),
              )),
              const SizedBox(height: 32),
              NewItemCreationTile(
                child: CupertinoTextField(
                  placeholder: 'Note',
                  controller: noteController,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              CupertinoButton(
                  color: accentColor,
                  child: const Text('Add homework'),
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        lessonController.text.isNotEmpty) {
                      homeworkController.createHomework(
                          '${titleController.text}${lessonController.text}${DateFormat('dMMM').format(dueTo)}',
                          Homework(
                              title: titleController.text,
                              lesson: lessonController.text,
                              dueTo: dueTo,
                              remind: remind,
                              isDone: isDone,
                              note: noteController.text));
                    }
                    context.router.pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
