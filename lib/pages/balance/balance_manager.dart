// ================= Balance Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/balance/balance_model.dart';
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
  BalanceModel? _balanceModel;
  bool _waitingForData = true;
  bool _isIncomeTab = true;

  void _init() {
    if (widget._authRepository.status == Status.Authenticated) {  // TODO- verify the case that user doesn't have data
      widget._userStorage.GET_balanceModel(_parseBalanceDataCB, _failedCB, getCurrentMonthPerEndMonthDay(gc.defaultEndOfMonthDay));
    } else {
      _waitingForData = false;
    }
  }

  void _parseBalanceDataCB(Json? categories) {
    if (categories != null) {
      _balanceModel = BalanceModel.fromJson(categories);
    }
    _waitingForData = false;
  }

  void _failedCB() {
    setState(() {
      _waitingForData = false;
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _addCategory(Category newCategory) {
    _balanceModel ??= BalanceModel();  // if the user is not logged in or doesn't have date, create am empty BalanceModel
    List<Category> categoryListType = newCategory.isIncome ? _balanceModel!.incomeCategories : _balanceModel!.expensesCategories;

    setState(() {
      categoryListType.add(newCategory);
    });

    _saveBalanceModel();
  }

  void _saveBalanceModel() {  // TODO- think what should we do with constants transactions
    if (widget._authRepository.status == Status.Authenticated && widget._userStorage.userData != null) {
      widget._userStorage.SEND_balanceModel(_balanceModel!.toJson(), getCurrentMonthPerEndMonthDay(widget._userStorage.userData!.endOfMonthDay));  // TODO- verify precision digit
    }
  }

  bool get isIncomeTab => _isIncomeTab;

  void _setCurrentTab(int currentTab) {
    _isIncomeTab = currentTab == 0;
  }

  void _openAddCategory() {
    navigateToPage(context, SetCategory(_addCategory, isIncomeTab));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _waitingForData ? const Center(child: CircularProgressIndicator())
      : (_balanceModel == null) ?
        const WelcomePage() : SingleChildScrollView(child: BalancePage(_balanceModel!, _saveBalanceModel, _setCurrentTab)),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddCategory,
        child: const Icon(gc.addIcon),
        tooltip: Languages.of(context)!.addCategory,
      ),
    );
  }
}
