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
  bool _isIncomeTab = true;
  bool _waitingForData = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    widget._userStorage.setDate();
    if (widget._authRepository.status == AuthStatus.Authenticated) {  // TODO- verify the case that user doesn't have data
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
    navigateToPage(context, SetCategory(DetailsPageMode.Add, isIncomeTab), AppPages.SetCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _waitingForData ? const Center(child: CircularProgressIndicator())
      : (widget._userStorage.balance.isEmpty) ?
      WelcomePage() : ListView(children: [BalancePage(widget._userStorage.balance, _setCurrentTab)]),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddCategory,
        child: const Icon(gc.addIcon),
        tooltip: Languages.of(context)!.addCategory,
      ),
    );
  }
}
