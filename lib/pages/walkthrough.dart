import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/home.dart';
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
    titleText: Text(title,style: TextStyle(fontSize: gc.titleSize,fontWeight: FontWeight.w600),),
    descText: Text(description,style: TextStyle(fontSize: gc.descriptionSize),),
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

final List<Color> _imageColor = [
  gc.secondaryColor,
  gc.primaryColor,
];

class _IntroWalkthroughState extends State<IntroWalkthrough> {
  @override
  Widget build(BuildContext context) {
    return IntroScreen(
      onbordingDataList: _listOfWalkthroughScreens(context),
      colors: _imageColor,
      nextButton: Icon(gc.nextIcon, color: gc.nextColor),
      lastButton: Icon(gc.finishIcon, color: gc.doneColor,),
      pageRoute: MaterialPageRoute<void>(builder: (BuildContext context) {return HomePage();},),
      skipButton: Text(
        Languages.of(context)!.strSkip,
        style: TextStyle(color: gc.linkColors, fontSize: gc.skipSize),
      ),
      selectedDotColor: gc.alternativePrimary,
      unSelectdDotColor: gc.tabUnselectedLabelColor,
    );
  }
}
