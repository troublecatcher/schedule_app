import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app/main.dart';

import '../features/homework/homework_screen.dart';
import '../features/homework/new_homework_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/schedule/lessons/new_lesson_screen.dart';
import '../features/schedule/schedule/schedule_screen.dart';
import '../features/settings/privacy_policy_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/settings/support_screen.dart';
import '../features/settings/terms_of_use_screen.dart';
import 'tabs_router.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, initial: !firstRun, children: [
          AutoRoute(page: ScheduleRoute.page, initial: true),
          AutoRoute(page: HomeworkRoute.page),
          AutoRoute(page: SettingsRoute.page),
        ]),
        AutoRoute(page: OnboardingRoute.page, initial: firstRun),
        AutoRoute(page: TermsOfUseRoute.page),
        AutoRoute(page: PrivacyPolicyRoute.page),
        AutoRoute(page: SupportRoute.page),
        AutoRoute(page: NewLessonRoute.page),
        AutoRoute(page: NewHomeworkRoute.page),
      ];
}
