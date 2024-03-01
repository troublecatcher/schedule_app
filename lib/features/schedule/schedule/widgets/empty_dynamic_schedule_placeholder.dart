import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/features/schedule/lessons/new_lesson_screen.dart';
import 'package:schedule_app/router/router.dart';

class EmptyDynamicSchedulePlaceholder extends StatelessWidget {
  const EmptyDynamicSchedulePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('Add your first lesson'),
        const SizedBox(height: 12),
        SvgPicture.asset(
          'assets/arrow.svg',
          height: MediaQuery.of(context).size.height / 3.5,
        ),
        const SizedBox(height: 37),
        CupertinoButton(
            color: accentColor,
            child: const Text('Add a new lesson'),
            onPressed: () => context.router
                .push(NewLessonRoute(mode: NewLessonMode.dynamic))),
        const SizedBox(height: 16),
      ],
    );
  }
}
