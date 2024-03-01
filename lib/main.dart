import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/db/boxes.dart';
import 'package:schedule_app/db/models/dynamic_lesson.dart';
import 'package:schedule_app/db/models/homework.dart';
import 'package:schedule_app/db/models/static_lesson.dart';
import 'package:schedule_app/db/models/lessontype.dart';
import 'package:schedule_app/db/models/weekday.dart';
import 'package:schedule_app/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

late ScheduleController scheduleController;
late HomeworkController homeworkController;
final locator = GetIt.instance;
late bool firstRun;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  firstRun = await IsFirstRun.isFirstRun();

  await Hive.initFlutter();
  Hive.registerAdapter(HomeworkAdapter());
  Hive.registerAdapter(LessonTypeAdapter());
  Hive.registerAdapter(WeekdayAdapter());
  Hive.registerAdapter(StaticLessonAdapter());
  Hive.registerAdapter(DynamicLessonAdapter());

  staticLessonsBox = await Hive.openBox<StaticLesson>('staticLessons');
  dynamicLessonsBox = await Hive.openBox<DynamicLesson>('dynamicLessons');
  homeworkBox = await Hive.openBox<Homework>('homework');

  scheduleController = ScheduleController();
  homeworkController = HomeworkController();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        _appRouter,
      ),
      theme: ThemeData(
          primaryColor: accentColor,
          useMaterial3: false,
          splashColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            foregroundColor: Colors.black,
            elevation: 3,
          )),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ScheduleController extends GetxController {
  var isStatic;

  setScheduleMode(bool value) {
    isStatic = value;
    update();
    updateSharedPreferences(isStatic);
  }

  initScheduleMode() {
    isStatic = locator<SharedPreferences>().getBool('isDynamic');
  }

  createDynamicLesson(String key, DynamicLesson lesson) {
    dynamicLessonsBox.put(key, lesson);
    update();
  }

  deleteDynamicLesson(int index) {
    dynamicLessonsBox.deleteAt(index);
    update();
  }

  createStaticLesson(String key, StaticLesson lesson) {
    staticLessonsBox.put(key, lesson);
    update();
  }

  deleteStaticLesson(String key) {
    staticLessonsBox.delete(key);
    update();
  }

  updateSharedPreferences(value) async =>
      await locator<SharedPreferences>().setBool('isDynamic', value);
}

class HomeworkController extends GetxController {
  createHomework(String key, Homework homework) {
    homeworkBox.put(key, homework);
    update();
  }

  deleteHomework(String key) {
    homeworkBox.delete(key);
    update();
  }
}
