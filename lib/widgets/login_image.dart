import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/localization/resources/resources.dart';
Stack loginImage(BuildContext context) {
  return Stack(children: [
    Image.asset(
      gc.wallet,
      height: MediaQuery.of(context).size.height / gc.walletScale,
    ),
    Padding(
      padding: EdgeInsets.fromLTRB(gc.padStackLeft, gc.padStackTop,
          gc.padStackRight, gc.padStackBottom),
      child: Text(
        Languages.of(context)!.appName,
        style: TextStyle(color: gc.secondaryColor, fontSize: gc.fontSizeLoginImage),
      ),
    )
  ]);
}
