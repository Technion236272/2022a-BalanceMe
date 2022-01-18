// ================= Walkthrough Page =================
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

class _IntroWalkthroughState extends State<IntroWalkthrough> {  // TODO- add GA!
  String get _getImagePathPrefix => "assets/images/walkthrough/${Languages.of(context)!.languageCode}/";

  void _closeWalkthrough() {
    navigateBack(context);
  }

  OnbordingData _setWalkthroughScreen(String imagePath, String title, String description) {
    return OnbordingData(
      fit: BoxFit.fitHeight,
      image: AssetImage(imagePath),
      titleText: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
      descText: Text(
        description,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  List<OnbordingData> _getListOfWalkthroughScreens() {
    return [
      _setWalkthroughScreen(
          gc.balanceImage,
          Languages.of(context)!.strWelcomeAboard,
          Languages.of(context)!.strWalkthroughDescription
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + "",  // TODO- example
          Languages.of(context)!.strWalkthroughWelcomeTitle,
          Languages.of(context)!.strWalkthroughWelcomeDescription
      ),
      _setWalkthroughScreen(
          "",
          Languages.of(context)!.strWalkthroughLoginTitle,
          Languages.of(context)!.strWalkthroughLoginDescription
      ),
      _setWalkthroughScreen(
          "",
          Languages.of(context)!.strBalanceSummary,
          Languages.of(context)!.strWalkthroughSummaryDescription
      ),
      _setWalkthroughScreen(
          "",
          Languages.of(context)!.strWalkthroughBalanceTitle,
          Languages.of(context)!.strWalkthroughBalanceDescription
      ),
      _setWalkthroughScreen(
          "",
          Languages.of(context)!.strAddCategory,
          Languages.of(context)!.strWalkthroughAddCategoryDescription
      ),
      _setWalkthroughScreen(
          "",
          Languages.of(context)!.strAddTransaction,
          Languages.of(context)!.strWalkthroughAddTransactionDescription
      ),
      _setWalkthroughScreen(
          "",
          Languages.of(context)!.strManageWorkspaces,
          Languages.of(context)!.strWorkspaceExplanation,
      ),
      _setWalkthroughScreen(
          "",  // TODO- Same as before
          Languages.of(context)!.strManageWorkspaces,
          Languages.of(context)!.strWorkspaceTooltip,
      ),
      _setWalkthroughScreen(
          "",
          Languages.of(context)!.strArchive,
          Languages.of(context)!.strWalkthroughArchiveDescription
      ),
      _setWalkthroughScreen(
          "",
          Languages.of(context)!.strSettings,
          Languages.of(context)!.strWalkthroughSettingsDescription
      ),
      _setWalkthroughScreen(
          gc.balanceImage,
          Languages.of(context)!.strWalkthroughFinalTitle,
          Languages.of(context)!.strWalkthroughFinalDescription
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroScreen(
        onbordingDataList: _getListOfWalkthroughScreens(),
        colors: [
          gc.secondaryColor,
          gc.primaryColor,
        ],
        nextButton: Text(Languages.of(context)!.strNext),
        lastButton: TextButton(
          onPressed: _closeWalkthrough,
          child: Text(Languages.of(context)!.strFinish),
        ),
        skipButton: TextButton(
          onPressed: _closeWalkthrough,
          child: Text(
            Languages.of(context)!.strSkip,
            style: TextStyle(color: gc.linkColors, fontSize: gc.skipSize),
          ),
        ),
        selectedDotColor: gc.alternativePrimary,
        unSelectdDotColor: gc.tabUnselectedLabelColor,
      ),
    );
  }
}
