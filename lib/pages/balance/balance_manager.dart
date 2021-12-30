// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/balance/balance_page.dart';
import 'package:balance_me/pages/welcome.dart';
import 'package:balance_me/pages/set_category.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class BalanceManager extends StatefulWidget {
  const BalanceManager(this._authRepository, this._userStorage, {Key? key}) : super(key: key);

  final UserStorage _userStorage;
  final AuthRepository _authRepository;

  @override
  _BalanceManagerState createState() => _BalanceManagerState();
}

class _BalanceManagerState extends State<BalanceManager> {
  bool _isIncomeTab = false;
  bool _waitingForData = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    widget._userStorage.setDate();
    if (widget._authRepository.status == AuthStatus.Authenticated) {
      widget._userStorage.GET_balanceModel(successCallback: _stopWaitingForDataCB, failureCallback: _stopWaitingForDataCB);
    } else {
      _stopWaitingForDataCB();
    }
  }

  void _stopWaitingForDataCB([Json? data]) {
    setState(() {
      _waitingForData = false;
    });
  }

  bool get isIncomeTab => _isIncomeTab;

  void _setCurrentTab(int currentTab) {
    _isIncomeTab = (currentTab == 1);
    GoogleAnalytics.instance.logPageOpened(_isIncomeTab ? AppPages.Incomes : AppPages.Expenses);
  }

  void _openAddCategory() {
    navigateToPage(context, SetCategory(DetailsPageMode.Add, isIncomeTab, CurrencySign[widget._userStorage.userData == null ? gc.defaultUserCurrency : widget._userStorage.userData!.userCurrency]!), AppPages.SetCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _waitingForData ? const Center(child: CircularProgressIndicator())
      : (widget._userStorage.balance.isEmpty) ?
      WelcomePage() : ListView(children: [BalancePage(widget._userStorage.balance, _setCurrentTab)]),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(Languages.of(context)!.strAddCategory),
        icon: const Icon(gc.addIcon),
        onPressed: _openAddCategory,
        tooltip: Languages.of(context)!.strAddCategory,
      ),
    );
  }
}
