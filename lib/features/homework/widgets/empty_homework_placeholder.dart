import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedule_app/const.dart';
import 'package:schedule_app/router/router.dart';

class EmptyHomeworkPlaceholder extends StatelessWidget {
  const EmptyHomeworkPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('Add your first homework'),
        const SizedBox(height: 12),
        SvgPicture.asset(
          'assets/arrow.svg',
          height: MediaQuery.of(context).size.height / 3.5,
        ),
        const SizedBox(height: 37),
        CupertinoButton(
            color: accentColor,
            child: const Text('Add a new homework'),
            onPressed: () => context.router.push(const NewHomeworkRoute())),
        const SizedBox(height: 16),
      ],
    );
  }
}
