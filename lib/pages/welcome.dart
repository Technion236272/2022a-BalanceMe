// ================= Welcome Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/constants.dart' as gc;

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(Languages.of(context)!.welcome),
        Text(Languages.of(context)!.balanceInfo),
        Text(Languages.of(context)!.toGetStartedInfo),
      ],
    );
  }
}
