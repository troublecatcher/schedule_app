import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/main.dart';
import 'package:schedule_app/router/router.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            SettingsItemContainer(
              child: CupertinoListTile(
                leading: SvgPicture.asset('assets/icons/repeat.svg'),
                title: const Text('Repeat the schedule every week'),
                trailing: GetBuilder(
                  init: scheduleController,
                  builder: (controller) => CupertinoSwitch(
                      value: scheduleController.isStatic,
                      onChanged: (value) =>
                          scheduleController.setScheduleMode(value)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.router.push(const TermsOfUseRoute()),
              child: SettingsItemContainer(
                child: CupertinoListTile(
                  leading: SvgPicture.asset('assets/icons/tou.svg'),
                  title: const Text('Terms of use'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded,
                      color: accentColor),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.router.push(const PrivacyPolicyRoute()),
              child: SettingsItemContainer(
                child: CupertinoListTile(
                  leading: SvgPicture.asset('assets/icons/pp.svg'),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded,
                      color: accentColor),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.router.push(const SupportRoute()),
              child: SettingsItemContainer(
                child: CupertinoListTile(
                  leading: SvgPicture.asset('assets/icons/support.svg'),
                  title: const Text('Support page'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded,
                      color: accentColor),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class SettingsItemContainer extends StatelessWidget {
  final Widget child;

  const SettingsItemContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: settingsItemColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child);
  }
}
