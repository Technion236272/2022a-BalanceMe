// ================= Generic Info =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericInfo extends StatelessWidget {
  const GenericInfo({this.title, this.topInfo, this.bottomInfo, Key? key}) : super(key: key);

  final String? title;
  final String? topInfo;
  final String? bottomInfo;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: gc.leftCircleTop,
          left: gc.circleLeftOrRight,
          child: CircleAvatar(
            radius: gc.circleRadius,
            backgroundColor: gc.backgroundDesignColor,
          )
      ),
      Positioned(
          top: gc.rightCircleTop,
          right: gc.circleLeftOrRight,
          child: CircleAvatar(
            radius: gc.circleRadius,
            backgroundColor: gc.backgroundDesignColor,
          )
      ),
      title == null ? Container()
      : Positioned(
        top: gc.welcomeTop,
        left: gc.textLeft,
        child: Text(
          title!,
          style: const TextStyle(fontSize: gc.infoTitleFontSize),
        ),
      ),
      topInfo == null ? Container()
      : Positioned(
        top: gc.balanceInfoTop,
        left: gc.textLeft,
        child: Text(
          topInfo!,
          style: const TextStyle(fontSize: gc.infoFontSize),
        ),
      ),
      bottomInfo == null ? Container()
      : Positioned(
        top: gc.startedInfoTop,
        left: gc.textLeft,
        child: Text(
          bottomInfo!,
          style: const TextStyle(fontSize: gc.infoFontSize),
        ),
      ),
    ]);
  }
}
