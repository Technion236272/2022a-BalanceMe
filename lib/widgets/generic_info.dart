// ================= Generic Info =================
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericInfo extends StatelessWidget {
  const GenericInfo(this._title, this._topInfo, this._bottomInfo, {Key? key}) : super(key: key);

  final String? _title;
  final String? _topInfo;
  final String? _bottomInfo;

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
      _title == null ? Container()
      : Positioned(
        top: gc.welcomeTop,
        left: gc.textLeft,
        child: Text(
          _title!,
          style: const TextStyle(fontSize: gc.infoTitleFontSize),
        ),
      ),
      _topInfo == null ? Container()
      : Positioned(
        top: gc.balanceInfoTop,
        left: gc.textLeft,
        child: Text(
          _topInfo!,
          style: const TextStyle(fontSize: gc.infoFontSize),
        ),
      ),
      _bottomInfo == null ? Container()
      : Positioned(
        top: gc.startedInfoTop,
        left: gc.textLeft,
        child: Text(
          _bottomInfo!,
          style: const TextStyle(fontSize: gc.infoFontSize),
        ),
      ),
    ]);
  }
}
