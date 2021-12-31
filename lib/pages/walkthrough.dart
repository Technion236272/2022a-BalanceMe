import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:balance_me/global/constants.dart' as gc;

class IntroWalkthrough extends StatefulWidget {
  const IntroWalkthrough({Key? key}) : super(key: key);

  @override
  _IntroWalkthroughState createState() => _IntroWalkthroughState();
}

OnbordingData _walkthroughScreen(
    String imagePath, String title, String description) {
  return OnbordingData(
    image: AssetImage(imagePath),
    titleText: Text(title),
    descText: Text(description),
  );
}

List<OnbordingData> _listOfWalkthroughScreens(BuildContext context) {
  final List<OnbordingData> list = [
    _walkthroughScreen(
        gc.welcomeWalkthrough,
        Languages.of(context)!.strWelcomeTitle,
        Languages.of(context)!.strWelcomeDescription),
    _walkthroughScreen(
        gc.loginWalkthrough,
        Languages.of(context)!.strLoginTitle,
        Languages.of(context)!.strLoginDescription),
    _walkthroughScreen(
        gc.settingsWalkthrough,
        Languages.of(context)!.strSettingsTitle,
        Languages.of(context)!.strSettingsDescription),
    _walkthroughScreen(
        gc.archivePageWalkthrough,
        Languages.of(context)!.strArchiveTitle,
        Languages.of(context)!.strArchiveDescription),
    //archive
    _walkthroughScreen(
        gc.balancePageWalkthrough,
        Languages.of(context)!.strBalanceTitle,
        Languages.of(context)!.strBalanceDescription),
  ];
  return list;
}

class _IntroWalkthroughState extends State<IntroWalkthrough> {
  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      onbordingDataList: _listOfWalkthroughScreens(context),
      colors: [
        gc.secondaryColor,
        gc.primaryColor,
      ],
      nextButton: Icon(gc.nextIcon, color: gc.nextColor),
      lastButton: Icon(
        gc.finishIcon,
        color: gc.doneColor,
      ),
      pageRoute: MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return HomePage();
        },
      ),
      skipButton: Text(
        Languages.of(context)!.strSkip,
        style: TextStyle(
          color: gc.linkColors,
        ),
      ),
      selectedDotColor: gc.alternativePrimary,
      unSelectdDotColor: gc.tabUnselectedLabelColor,
    );
  }
}
