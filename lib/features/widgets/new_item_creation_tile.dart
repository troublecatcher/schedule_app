import 'package:flutter/cupertino.dart';
import 'package:schedule_app/const.dart';

class NewItemCreationTile extends StatelessWidget {
  final Widget child;

  const NewItemCreationTile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 4),
      color: surfaceColor,
      child: child,
    );
  }
}
