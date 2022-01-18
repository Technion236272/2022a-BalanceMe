// ================= Home Page =================
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/pages/walkthrough.dart';
import 'package:flutter/material.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:balance_me/pages/connection_lost.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/widgets/bottom_navigation.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/pages/balance/balance_manager.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/pages/settings.dart';
import 'package:balance_me/pages/archive.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = gc.defaultPage;

  @override
  void initState() {
    super.initState();
    _setupWalkthrough();
  }

  void _updateSelectedPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
  bool _wasWalkthroughSeen(SharedPreferences prefs) {
    return prefs.containsKey(gc.walkthroughShown) &&
        prefs.getBool(gc.walkthroughShown) != null &&
        prefs.getBool(gc.walkthroughShown)!;
  }

  void _setWalkthroughSeen(SharedPreferences prefs) {
    prefs.setBool(gc.walkthroughShown, true);
  }

  void _setupWalkthrough() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!_wasWalkthroughSeen(prefs)) {
      _setWalkthroughSeen(prefs);
      navigateToPage(context, IntroWalkthrough(), AppPages.Walkthrough);
    }
  }

  Widget _getCurrentPage(AuthRepository authRepository, UserStorage userStorage) {
    if (_selectedPage == AppPages.Settings.index) {  // Settings
      GoogleAnalytics.instance.logPageOpened(AppPages.Settings);
      return Settings(authRepository, userStorage);
    }
    if (_selectedPage == AppPages.Archive.index) {  // Statistics
      GoogleAnalytics.instance.logPageOpened(AppPages.Archive);
      return Archive(authRepository, userStorage);
    }  // Statistics
    return BalanceManager(authRepository, userStorage);  // default: Balance
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthRepository, UserStorage>(
        builder: (context, authRepository, userStorage, child) {
          return ConnectivityBuilder(
            builder: (context, isConnected, status) {
              return (isConnected != null && !!isConnected) ? Scaffold(
                appBar: MainAppBar(authRepository, userStorage, _selectedPage),
                body: _getCurrentPage(authRepository, userStorage),
                bottomNavigationBar: BottomNavigation(_selectedPage, _updateSelectedPage),
              ) : ConnectionLostPage();
            }
          );
        }
    );
  }
}
