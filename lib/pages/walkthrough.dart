// ================= Walkthrough Page =================
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:balance_me/global/constants.dart' as gc;

class IntroWalkthrough extends StatefulWidget {
  const IntroWalkthrough({Key? key}) : super(key: key);

  @override
  _IntroWalkthroughState createState() => _IntroWalkthroughState();
}

class _IntroWalkthroughState extends State<IntroWalkthrough> {
  String get _getImagePathPrefix => "assets/images/walkthrough/${Languages.of(context)!.languageCode}/";

  void _closeWalkthrough({bool isLast = false}) {
    navigateBack(context);
    isLast ? GoogleAnalytics.instance.logWalkthroughFinished() : GoogleAnalytics.instance.logWalkthroughSkipped();
  }

  PageViewModel _setWalkthroughScreen(String imagePath, String title, String description) {
    return PageViewModel(
      image: SizedBox(
          width: MediaQuery.of(context).size.width/gc.imageWidthScale,
          height: MediaQuery.of(context).size.width*gc.imageHeightScale,
          child: Image.asset(imagePath)),
      title: title,
      bodyWidget: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Expanded(child: Text(description, style: Theme.of(context).textTheme.bodyText2,))],),
      decoration: PageDecoration(
        pageColor: Theme.of(context).backgroundColor,
        imageFlex: 3,
        imagePadding: gc.walkthroughPadding,
        titlePadding: gc.walkthroughPadding,
        bodyAlignment: Alignment.topLeft
      ),
    );
  }

  List<PageViewModel> _getListOfWalkthroughScreens() {
    return [
      _setWalkthroughScreen(
          gc.balanceImage,
          Languages.of(context)!.strWelcomeAboard,
          Languages.of(context)!.strWalkthroughDescription
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + gc.welcomeScreen,
          Languages.of(context)!.strWalkthroughWelcomeTitle,
          Languages.of(context)!.strWalkthroughWelcomeDescription
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + gc.loginScreen,
          Languages.of(context)!.strWalkthroughLoginTitle,
          Languages.of(context)!.strWalkthroughLoginDescription
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + gc.summaryScreen,
          Languages.of(context)!.strBalanceSummary,
          Languages.of(context)!.strWalkthroughSummaryDescription
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + gc.balanceScreen,
          Languages.of(context)!.strWalkthroughBalanceTitle,
          Languages.of(context)!.strWalkthroughBalanceDescription
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + gc.addCategoryScreen,
          Languages.of(context)!.strAddCategory,
          Languages.of(context)!.strWalkthroughAddCategoryDescription
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + gc.addTransactionScreen,
          Languages.of(context)!.strAddTransaction,
          Languages.of(context)!.strWalkthroughAddTransactionDescription
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + gc.workspacesScreen,
          Languages.of(context)!.strManageWorkspaces,
          Languages.of(context)!.strWorkspaceExplanation,
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + gc.workspacesScreen,
          Languages.of(context)!.strManageWorkspaces,
          Languages.of(context)!.strWorkspaceTooltip,
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + gc.archiveScreen,
          Languages.of(context)!.strArchive,
          Languages.of(context)!.strWalkthroughArchiveDescription
      ),
      _setWalkthroughScreen(
          _getImagePathPrefix + gc.settingsScreen,
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
    return IntroductionScreen(
      pages: _getListOfWalkthroughScreens(),
      onDone: () => _closeWalkthrough(isLast: true),
      onSkip: () =>_closeWalkthrough(isLast: false),
      showSkipButton: true,
      skip: Text(Languages.of(context)!.strSkip),
      next: Text(Languages.of(context)!.strNext),
      done: Text(Languages.of(context)!.strFinish),
      dotsFlex: 2,
      skipColor: gc.expenseEntryColor,
      controlsPadding: EdgeInsets.fromLTRB(5, 16, 5, 16),
      dotsDecorator: DotsDecorator(
          size: const Size.square(gc.unselectedDotSize),
          activeSize: const Size(gc.selectedDotSize, gc.unselectedDotSize),
          activeColor: Theme.of(context).toggleableActiveColor,
          color: Colors.black26,
          spacing: gc.dotsSpacing,
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(gc.unselectedDotSize)
          )
      ),
    );
  }
}
