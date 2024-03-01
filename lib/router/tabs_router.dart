import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_app/const.dart';

import 'router.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      transitionBuilder: (context, child, animation) => child,
      routes: const [
        ScheduleRoute(),
        HomeworkRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(2, 4),
                  blurRadius: 30,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
              child: BottomNavigationBar(
                selectedItemColor: accentColor,
                type: BottomNavigationBarType.fixed,
                iconSize: 50,
                currentIndex: tabsRouter.activeIndex,
                onTap: (value) {
                  tabsRouter.setActiveIndex(value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/schedule_off.svg'),
                    activeIcon:
                        SvgPicture.asset('assets/icons/schedule_on.svg'),
                    label: 'Schedule',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/homework_off.svg'),
                    activeIcon:
                        SvgPicture.asset('assets/icons/homework_on.svg'),
                    label: 'Homework',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/settings_off.svg'),
                    activeIcon:
                        SvgPicture.asset('assets/icons/settings_on.svg'),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
