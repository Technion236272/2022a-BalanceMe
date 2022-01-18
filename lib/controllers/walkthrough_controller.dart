// ================= Walkthrough Controller =================
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:balance_me/pages/walkthrough.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';

class WalkthroughController {
  static String walkthroughKey = "walkthroughShown";

  static void setupWalkthrough() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!await _wasWalkthroughSeen(prefs)) {
      _setWalkthroughSeen(prefs);

      if (globalNavigatorKey.currentContext == null) {
        return;
      }
      BuildContext context = globalNavigatorKey.currentContext!;

      navigateToPage(context, IntroWalkthrough(), AppPages.Walkthrough);
    }
  }

  static Future<bool> _wasWalkthroughSeen(SharedPreferences prefs) async {
    bool? wasWalkthroughSeen = prefs.getBool(walkthroughKey);
    return prefs.containsKey(walkthroughKey) && wasWalkthroughSeen != null && wasWalkthroughSeen;
  }

  static void _setWalkthroughSeen(SharedPreferences prefs) {
    prefs.setBool(walkthroughKey, true);
  }
}
