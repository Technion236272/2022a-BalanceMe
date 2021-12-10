// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/common_models/category_model.dart';
import 'package:balance_me/pages/balance/balance_page.dart';
import 'package:balance_me/pages/welcome.dart';
import 'package:balance_me/pages/set_category.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class BalanceManager extends StatefulWidget {
  const BalanceManager(this._authRepository, this._userStorage, {Key? key}) : super(key: key);

  final AuthRepository _authRepository;
  final UserStorage _userStorage;

  @override
  _BalanceManagerState createState() => _BalanceManagerState();
}

class _BalanceManagerState extends State<BalanceManager> {
  bool _waitingForData = true;
  bool _isIncomeTab = true;

  void _init() {
    if (widget._authRepository.status == Status.Authenticated) {  // TODO- verify the case that user doesn't have data
      widget._userStorage.GET_balanceModel(callback: _stopWaitingForDataCB);
    } else {
      _waitingForData = false;
    }
  }

  void _stopWaitingForDataCB() {
    setState(() {
      _waitingForData = false;
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  // void _changeCategory(Category newCategory, bool toAdd) {
  //   List<Category> categoryListType = newCategory.isIncome ? widget._userStorage.balance.incomeCategories : widget._userStorage.balance.expensesCategories;
  //
  //   setState(() {
  //     toAdd ? categoryListType.add(newCategory) : categoryListType.remove(newCategory);
  //   });
  //
  //   widget._userStorage.SEND_balanceModel();
  // }
  //
  // void _addCategory(Category newCategory) {
  //   _changeCategory(newCategory, true);
  // }
  //
  // void _removeCategory(Category newCategory) {
  //   _changeCategory(newCategory, false);
  // }

  bool get isIncomeTab => _isIncomeTab;

  void _setCurrentTab(int currentTab) {
    _isIncomeTab = currentTab == 0;
  }

  void _openAddCategory() {
    navigateToPage(context, SetCategory(widget._userStorage.addCategory, isIncomeTab));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _waitingForData ? const Center(child: CircularProgressIndicator())
      : (widget._userStorage.balance.isEmpty) ?
        const WelcomePage() : SingleChildScrollView(child: BalancePage(widget._userStorage.balance, _setCurrentTab)),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddCategory,
        child: const Icon(gc.addIcon),
        tooltip: Languages.of(context)!.addCategory,
      ),
    );
  }
}
