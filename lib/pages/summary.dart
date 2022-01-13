// ================= Summary Page =================
import 'package:balance_me/common_models/balance_model.dart';
import 'package:balance_me/global/dispatcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/widgets/generic_edit_button.dart';
import 'package:balance_me/widgets/generic_tooltip.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/set_workspace.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SummaryPage extends StatefulWidget {
  const SummaryPage(this._balance, {Key? key}) : super(key: key);
  final BalanceModel _balance;

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  bool _isDisabledBankBalance = true;
  late double _currentIncomes;
  late double _currentExpenses;
  late double _expectedIncomes;
  late double _expectedExpenses;
  TextEditingController _controllerBankBalance = TextEditingController();

  AuthRepository get authRepository => Provider.of<AuthRepository>(context, listen: false);
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    GeneralInfoDispatcher.subscribe(() {
      if (mounted && userStorage.userData != null && userStorage.userData!.bankBalance != null) {
        _controllerBankBalance = TextEditingController(text: userStorage.userData!.bankBalance.toString());
      }
    });
  }

  void _calculateBalance() {
    _currentIncomes = widget._balance.getTotalAmount(isIncome: true, isExpected: false);
    _currentExpenses = widget._balance.getTotalAmount(isIncome: false, isExpected: false);
    _expectedIncomes = widget._balance.getTotalAmount(isIncome: true, isExpected: true);
    _expectedExpenses = widget._balance.getTotalAmount(isIncome: false, isExpected: true);
  }

  void _openSetWorkspace() {
    navigateToPage(context, SetWorkspace(), AppPages.SetWorkspace);
  }

  bool get showWorkspacesAndBankBalance {
    return (authRepository.status == AuthStatus.Authenticated && userStorage.userData != null && userStorage.currentDate != null);
  }

  void _updateBankBalance() {
    if (userStorage.userData != null) {
      double? newBankBalance;

      if (_controllerBankBalance.text != "") {
        newBankBalance = double.parse(_controllerBankBalance.text);
      }

      userStorage.userData!.bankBalance = newBankBalance;
      userStorage.SEND_generalInfo();
      _enableEditBankBalance(null);
      FocusScope.of(context).unfocus(); // Remove the keyboard
    }
  }

  bool _enableEditCondition(String? value) => (value == null);

  void _enableEditBankBalance(String? value) {
    setState(() {
      _isDisabledBankBalance = _enableEditCondition(value);
    });
  }

  Widget _summaryCardWidget(String tip, String firstTitle, double currentAmount, String secTitle, double expectedAmount, bool currentAboveExpected){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: GenericTooltip(
              tip: tip,
              style: TextStyle(fontSize: 12, color: gc.secondaryColor),
            ),
          ),
          Expanded(
            flex: 9,
            child: Card(
              shadowColor: gc.primaryColor.withOpacity(0.5),
              elevation: gc.cardElevationHeight,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: getColorForCard(currentAboveExpected, currentAmount, expectedAmount),
                    width: gc.cardBorderWidth,
                ),
                borderRadius: BorderRadius.circular(gc.entryBorderRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: gc.categoryAroundPadding),
                        child: Text(
                          firstTitle,
                          style: TextStyle(
                            color: gc.disabledColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        currentAmount.toMoneyFormat(CurrencySign[userStorage.userData == null ? gc.defaultUserCurrency : userStorage.userData!.userCurrency]!),
                        textDirection: getTextDirection(gc.ltr),
                        style: TextStyle(
                          color: getColorForCard(currentAboveExpected, currentAmount, expectedAmount),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(gc.categoryTopPadding),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: gc.categoryAroundPadding),
                          child: Text(secTitle,
                            style: TextStyle(
                              color: gc.disabledColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          expectedAmount.toMoneyFormat(CurrencySign[userStorage.userData == null ? gc.defaultUserCurrency : userStorage.userData!.userCurrency]!),
                          textDirection: getTextDirection(gc.ltr),
                          style: TextStyle(
                            color: getColorForCard(currentAboveExpected, currentAmount, expectedAmount),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _calculateBalance();
    return SingleChildScrollView(
      child: Padding(
        padding: gc.summeryHorizontalPadding,
        child: Column(
          children: [
            Padding(
              padding: gc.summeryVerticalPadding,
              child: Visibility(
                visible: userStorage.currentDate != null,
                child: Text(
                  Languages.of(context)!.strBalanceSummary,
                  style: TextStyle(fontSize: gc.tabFontSize, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: showWorkspacesAndBankBalance,
                    child: Text(
                      Languages.of(context)!.strCurrentWorkspace,
                      style: TextStyle(fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: showWorkspacesAndBankBalance,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / gc.currentWorkspaceBoxScale,
                            child: Text(userStorage.userData!.currentWorkspace)
                        ),
                        SizedBox(
                          width: gc.setWorkspaceButtonWidth,
                          height: gc.setWorkspaceButtonHeight,
                          child: ElevatedButton(
                            onPressed: _openSetWorkspace,
                            child: Text(Languages.of(context)!.strSet),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Visibility(visible: showWorkspacesAndBankBalance && userStorage.userData!.currentWorkspace == authRepository.getEmail, child: Divider()),
            Visibility(
              visible: showWorkspacesAndBankBalance && userStorage.userData!.currentWorkspace == authRepository.getEmail,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GenericTooltip(
                    tip: Languages.of(context)!.strBeginningMontBalanceInfo,
                    style: TextStyle(fontSize: gc.summaryTooltipFontSize, color: gc.secondaryColor),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.25,
                    child: TextBox(
                      _controllerBankBalance,
                      Languages.of(context)!.strBeginningMonthBalance,
                      isNumeric: true,
                      haveBorder: false,
                      onChanged: _enableEditBankBalance,
                      languageDirection: gc.ltr,
                      suffix: GenericIconButton(
                        onTap: _updateBankBalance,
                        isDisabled: _isDisabledBankBalance,
                        opacity: gc.disabledOpacity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            showWorkspacesAndBankBalance && userStorage.userData!.bankBalance != null && userStorage.userData!.currentWorkspace == authRepository.getEmail ?
            _summaryCardWidget(
                Languages.of(context)!.strBankInfo,
                Languages.of(context)!.strCurrentBankBalance,
                userStorage.userData!.bankBalance! + (_currentIncomes - _currentExpenses),
                Languages.of(context)!.strExpectedBankBalance,
                userStorage.userData!.bankBalance! + (_expectedIncomes - _expectedExpenses),
                true) : Container(),
            Divider(),
            _summaryCardWidget(Languages.of(context)!.strIncomeBalanceInfo, Languages.of(context)!.strCurrentIncomes, _currentIncomes, Languages.of(context)!.strExpectedIncomes, _expectedIncomes, true),
            _summaryCardWidget(Languages.of(context)!.strExpensesBalanceInfo, Languages.of(context)!.strCurrentExpenses, _currentExpenses, Languages.of(context)!.strExpectedExpenses, _expectedExpenses, false),
            _summaryCardWidget(Languages.of(context)!.strTotalBalanceInfo, Languages.of(context)!.strTotalCurrentBalance, (_currentIncomes - _currentExpenses), Languages.of(context)!.strTotalExpectedBalance, (_expectedIncomes - _expectedExpenses), true),
          ],
        ),
      ),
    );
  }
}
