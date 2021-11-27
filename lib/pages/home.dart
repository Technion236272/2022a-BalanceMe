// ================= Home Page =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/widgets/bottom_navigation.dart';
import 'package:balance_me/pages/balance/balance_view.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/types.dart';
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
    // TODO- replace to Settings and Statistics screens after they will be implemented
    if (_selectedPage == AppPages.Settings.index) {  // Settings
      return const Scaffold();
    }
    if (_selectedPage == AppPages.Statistics.index) {  // Statistics
      return const Scaffold();
    }  // Statistics
    return BalancePage(authRepository, userStorage);  // default: Balance
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthRepository, UserStorage>(
        builder: (context, authRepository, userStorage, child) {
          return Scaffold(
            appBar: MainAppBar(authRepository, userStorage),
            body: _getCurrentPage(authRepository, userStorage),
            bottomNavigationBar: BottomNavigation(_selectedPage, _updateSelectedPage),
          );
        }
    );
  }
}
