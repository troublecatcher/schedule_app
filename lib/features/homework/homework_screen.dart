import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app/db/boxes.dart';
import 'package:schedule_app/features/homework/widgets/done_homework_widget.dart';
import 'package:schedule_app/features/homework/widgets/empty_homework_placeholder.dart';
import 'package:schedule_app/features/homework/widgets/undone_homework_widget.dart';
import 'package:schedule_app/main.dart';
import 'package:schedule_app/router/router.dart';

import '../../const.dart';

@RoutePage()
class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework'),
        actions: [
          GetBuilder(
              init: homeworkController,
              builder: (_) {
                if (homeworkBox.isNotEmpty) {
                  return CupertinoButton(
                      onPressed: () =>
                          context.router.push(const NewHomeworkRoute()),
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
            init: homeworkController,
            builder: (controller) {
              if (homeworkBox.isEmpty) {
                return const EmptyHomeworkPlaceholder();
              } else {
                List homeworkList = homeworkBox.values.toList();
                List doneHomework =
                    homeworkList.where((element) => element.isDone).toList();
                List undoneHomework =
                    homeworkList.where((element) => !element.isDone).toList();

                return ListView.builder(
                  itemCount: undoneHomework.length + doneHomework.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      if (undoneHomework.isNotEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(
                              top: 32, right: 8, left: 8, bottom: 8),
                          child: Text(
                            'To perform',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: accentColor,
                              fontSize: 16,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else if (index <= undoneHomework.length) {
                      return UndoneHomeworkWidget(
                          homework: undoneHomework[index - 1],
                          index: index - 1);
                    } else if (index == undoneHomework.length + 1) {
                      if (doneHomework.isNotEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Completed Tasks',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: accentColor,
                              fontSize: 16,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else {
                      return DoneHomeworkWidget(
                          homework:
                              doneHomework[index - undoneHomework.length - 2],
                          index: index - undoneHomework.length - 2);
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
