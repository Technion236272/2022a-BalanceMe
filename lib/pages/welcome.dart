// ================= Welcome Page =================
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/generic_info.dart';
import 'package:balance_me/global/constants.dart' as gc;

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: MediaQuery.of(context).size.width / 3,
        top: gc.imageTop,
        child: Image.asset(
          gc.balance,
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 3,
        ),
      ),
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
      GenericInfo(
        Languages.of(context)!.welcome,
        Languages.of(context)!.balanceInfo,
        Languages.of(context)!.toGetStartedInfo,
      ),
    ]);
  }
}
