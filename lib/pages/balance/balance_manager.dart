// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balance_me/common_models/balance_model.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/balance/balance_page.dart';
import 'package:balance_me/pages/welcome.dart';
import 'package:balance_me/pages/set_category.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/config.dart' as config;
import 'package:balance_me/global/constants.dart' as gc;

class BalanceManager extends StatefulWidget {
  const BalanceManager(this._authRepository, this._userStorage, {Key? key}) : super(key: key);

  final UserStorage _userStorage;
  final AuthRepository _authRepository;

  @override
  _BalanceManagerState createState() => _BalanceManagerState();
}

class _BalanceManagerState extends State<BalanceManager> {
  BalanceTabs _currentTab = BalanceTabs.Summary;

  @override
  void initState() {
    super.initState();
    widget._userStorage.setDate();
  }

  bool _shouldShowWelcomePage() => widget._userStorage.balance.isEmpty;

  void _setCurrentTab(int currentTab) {
    FocusScope.of(context).unfocus(); // Remove the keyboard
    setState(() {
      _currentTab = BalanceTabs.values[currentTab];
    });

    switch (_currentTab) {
      case BalanceTabs.Summary:
        GoogleAnalytics.instance.logPageOpened(AppPages.Summary);
        break;
      case BalanceTabs.Expenses:
        GoogleAnalytics.instance.logPageOpened(AppPages.Expenses);
        break;
      case BalanceTabs.Incomes:
        GoogleAnalytics.instance.logPageOpened(AppPages.Incomes);
        break;
    }
  }

  void _openAddCategory() {
    navigateToPage(context, SetCategory(DetailsPageMode.Add, _currentTab == BalanceTabs.Incomes, CurrencySign[widget._userStorage.userData == null ? gc.defaultUserCurrency : widget._userStorage.userData!.userCurrency]!), AppPages.SetCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: widget._userStorage.STREAM_balanceModel(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if ((!snapshot.hasData || snapshot.data!.data() == null || !BalanceModel.isBalanceValid(snapshot.data!.data()! as Json)) && widget._authRepository.status == AuthStatus.Authenticated) {
            print("@@ No data, try to get previous month data");
            widget._userStorage.getBalanceAfterEndOfMonth();
            return Center(child: CircularProgressIndicator());
          }

          if (widget._authRepository.status == AuthStatus.Authenticated && snapshot.hasData) {
            widget._userStorage.assignBalance(BalanceModel.fromJson((snapshot.data!.data()! as Json)[config.categoriesDoc]));
          }

          return (_shouldShowWelcomePage()) ? WelcomePage() : ListView(children: [BalancePage(widget._userStorage.balance, _setCurrentTab)]);
        },
      ),
      floatingActionButton: Visibility(
        visible: _shouldShowWelcomePage() || _currentTab != BalanceTabs.Summary,
        child: FloatingActionButton.extended(
          label: Text(Languages.of(context)!.strAddCategory),
          icon: const Icon(gc.addIcon),
          onPressed: _openAddCategory,
          tooltip: Languages.of(context)!.strAddCategory,
        ),
      ),
    );
  }
}
