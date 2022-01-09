// ================= Home Page =================
import 'package:flutter/material.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:balance_me/pages/connection_lost_page.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = gc.defaultPage;

  void _updateSelectedPage(int index) {
    setState(() {
      _selectedPage = index;
    });
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
