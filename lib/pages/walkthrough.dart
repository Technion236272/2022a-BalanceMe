import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
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
  //TODO: check locale language, and fix descriptions
  return [
    _walkthroughScreen(
        gc.welcomeWalkthrough,
        Languages.of(context)!.strWelcomeTitle,
        Languages.of(context)!.strWelcomeDescription),
    _walkthroughScreen(
        gc.loginHebrewWalkthrough,
        Languages.of(context)!.strLoginTitle,
        Languages.of(context)!.strLoginDescription),
    //balance
    _walkthroughScreen(
        gc.balanceExpensesHebrewWalkthrough,
        Languages.of(context)!.strBalanceTitle,
        Languages.of(context)!.strBalanceDescription),
    _walkthroughScreen(
        gc.balanceIncomesHebrewWalkthrough,
        Languages.of(context)!.strBalanceTitle,
        Languages.of(context)!.strBalanceDescription),
    _walkthroughScreen(
        gc.balanceAddCategoryHebrewWalkthrough,
        Languages.of(context)!.strBalanceTitle,
        Languages.of(context)!.strBalanceDescription),
    _walkthroughScreen(
        gc.balanceAddTransactionHebrewWalkthrough,
        Languages.of(context)!.strBalanceTitle,
        Languages.of(context)!.strBalanceDescription),
    _walkthroughScreen(
        gc.SummaryHebrewWalkthrough,
        Languages.of(context)!.strBalanceTitle,
        Languages.of(context)!.strBalanceDescription),
    //archive
    _walkthroughScreen(
        gc.archiveHebrewWalkthrough,
        Languages.of(context)!.strArchiveTitle,
        Languages.of(context)!.strArchiveDescription),
    //workspace
    _walkthroughScreen(
        gc.WorkspacePageHebrewWalkthrough,
        Languages.of(context)!.strArchiveTitle,
        Languages.of(context)!.strArchiveDescription),
    _walkthroughScreen(
        gc.InviteHebrewWalkthrough,
        Languages.of(context)!.strArchiveTitle,
        Languages.of(context)!.strArchiveDescription),
    //settings
    _walkthroughScreen(
        gc.settingsHebrewWalkthrough,
        Languages.of(context)!.strSettingsTitle,
        Languages.of(context)!.strSettingsDescription),
    _walkthroughScreen(
        gc.settingsProfileHebrewWalkthrough,
        Languages.of(context)!.strSettingsTitle,
        Languages.of(context)!.strSettingsDescription),
  ];
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
      lastButton: IconButton(
        color: gc.doneColor,
        icon: Icon(gc.finishIcon),
        onPressed: () {
          navigateBack(context);
        },
      ),
      skipButton: TextButton(
        onPressed: () {
          navigateBack(context);
        },
        child: Text(
          Languages.of(context)!.strSkip,
          style: TextStyle(color: gc.linkColors, fontSize: gc.skipSize),
        ),
      ),
      selectedDotColor: gc.alternativePrimary,
      unSelectdDotColor: gc.tabUnselectedLabelColor,
    );
  }
}
