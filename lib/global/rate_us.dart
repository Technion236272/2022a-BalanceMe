// ================= Rate Us Widget =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class RateUs extends StatelessWidget {
  const RateUs({Key? key}) : super(key: key);

  void _onCancel() {
    GoogleAnalytics.instance.logRateUsCancel();
  }

  void _onSubmit(RatingDialogResponse response) {
    if (globalNavigatorKey.currentContext == null) {
      return;
    }
    BuildContext context = globalNavigatorKey.currentContext!;

    Provider.of<UserStorage>(context, listen: false).sendReview(response.rating, response.comment);
    GoogleAnalytics.instance.logRateUsSubmit();
    displaySnackBar(context, Languages.of(context)!.strRateRecorded);
  }

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      initialRating: gc.defaultInitialRating,
      title: Text(
        Languages.of(context)!.strAppName,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: gc.rateUsAppNameFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: Text(
        Languages.of(context)!.strRateUsExplanation,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: gc.rateUsExplanationFontSize),
      ),
      image: Image.asset(gc.balanceImage),
      submitButtonText: Languages.of(context)!.strSubmit,
      commentHint: Languages.of(context)!.strCommentHint,
      onCancelled: _onCancel,
      onSubmitted: _onSubmit,
    );
  }
}
