import 'package:flutter/cupertino.dart';
import 'package:schedule_app/const.dart';

class RoundIcon extends StatelessWidget {
  final IconData icondata;
  final Color color;

  const RoundIcon({
    super.key,
    required this.icondata,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
        ),
        child: Icon(
          icondata,
          color: whiteColor,
          size: 36,
        ));
  }
}
