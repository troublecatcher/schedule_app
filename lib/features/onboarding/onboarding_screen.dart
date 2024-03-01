import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/main.dart';
import 'package:schedule_app/router/router.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60),
                Text('Does the schedule repeat itself?',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 24)),
                Text('Choose one of two options',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CupertinoButton(
                          color: accentColor,
                          child: const Text('Repeats'),
                          onPressed: () {
                            scheduleController.setScheduleMode(true);
                            context.router.replace(const MainRoute());
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CupertinoButton(
                          color: accentColor,
                          child: const Text('New schedule every week'),
                          onPressed: () {
                            scheduleController.setScheduleMode(false);
                            context.router.replace(const MainRoute());
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
