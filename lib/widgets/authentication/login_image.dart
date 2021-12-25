import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/localization/resources/resources.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        gc.wallet,
        height: MediaQuery.of(context).size.height / gc.walletScale,
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(gc.padStackLeft, gc.padStackTop,
            gc.padStackRight, gc.padStackBottom),
        child: Text(
          Languages.of(context)!.strAppName,
          style: TextStyle(color: gc.secondaryColor, fontSize: gc.fontSizeLoginImage),
        ),
      )
    ]);

  }
}

