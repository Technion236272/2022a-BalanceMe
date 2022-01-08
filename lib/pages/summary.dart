// ================= Summary Page =================
import 'package:balance_me/widgets/generic_edit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/set_workspace.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  AuthRepository get authRepository => Provider.of<AuthRepository>(context, listen: false);
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);
  bool _isDisabledBeginningBalance = true;
  double _beginningMonthBalance = 0;
  double _currentIncomes = 0;
  double _currentExpenses = 0;
  double _ExpectedIncomes = 0;
  double _ExpectedExpenses = 0;
  late TextEditingController _controllerBeginningMonthBalance;

  @override
  void initState() {
    super.initState();
    _controllerBeginningMonthBalance = TextEditingController(text: "");
    //TODO - initial all balance info from the firebase
  }

  void _rebuildPage() => {setState(() => null)};

  void _openSetWorkspace() {
    navigateToPage(context, SetWorkspace(afterChangeWorkspaceCB: _rebuildPage), AppPages.SetWorkspace);
  }

  void _updateBeginningBalance() {
    //TODO - Save the bank balance in the firebase
    if(_controllerBeginningMonthBalance.text != ""){
      _beginningMonthBalance = double.parse(_controllerBeginningMonthBalance.text);
    }
    _enableEditBeginningBalance(null);
  }

  bool _enableEditCondition(String? value) => (value == null || value == "");

  void _enableEditBeginningBalance(String? value) {
    setState(() {
      _isDisabledBeginningBalance = _enableEditCondition(value);
    });
  }

  String? _positiveNumberValidatorFunction(String? value) {
    String? message = value;
    if (message == null) {
      try {
        return positiveNumberValidator(num.parse(value!)) ? null : Languages.of(context)!.strMustPositiveNum;
      } catch(e) {
        return Languages.of(context)!.strBadNumberForm;
      }
    }
    return message;
  }

  Widget _summaryCardWidget(String firstTitle, double firstAmount, String secTitle, double secAmount){
    return Card(
      shadowColor: gc.primaryColor.withOpacity(0.5),
      elevation: gc.cardElevationHeight,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
            color: gc.primaryColor, width: gc.cardBorderWidth),
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
                    fontSize: gc.fontSizeLoginImage,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(firstAmount.toString(),
                style: TextStyle(
                  color: gc.primaryColor,
                  fontSize: gc.fontSizeLoginImage,
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
                      fontSize: gc.fontSizeLoginImage,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(secAmount.toString(),
                  style: TextStyle(
                    color: gc.primaryColor,
                    fontSize: gc.fontSizeLoginImage,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: gc.summeryHorizontalPadding,
        child: Column(
          children: [
            Padding(
              padding: gc.summeryVerticalPadding,
              child: Text(
                Languages.of(context)!.strBalanceSummary,
                style: TextStyle(fontSize: gc.tabFontSize, fontWeight: FontWeight.bold),
              ),
            ),
            // TODO- design: add diagram
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: authRepository.status == AuthStatus.Authenticated && userStorage.userData != null,
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
                    visible: authRepository.status == AuthStatus.Authenticated && userStorage.userData != null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width/gc.currentWorkspaceBoxScale,
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
            Divider(),
            TextBox( //TODO - Not completed yet
              _controllerBeginningMonthBalance,
              Languages.of(context)!.strBeginningMonthBalance, //TODO - Change to correct string
              isNumeric: true,
              validatorFunction: _positiveNumberValidatorFunction,
              haveBorder: false,
              onChanged: _enableEditBeginningBalance,
              suffix: GenericIconButton(
                onTap: _updateBeginningBalance,
                isDisabled: _isDisabledBeginningBalance,
                opacity: gc.disabledOpacity,
              ),
            ),
            Visibility(
                visible: _beginningMonthBalance != gc.zero,
                child: _summaryCardWidget(Languages.of(context)!.strCurrentBankBalance, _beginningMonthBalance + (_currentIncomes - _currentExpenses), Languages.of(context)!.strExpectedBankBalance, _beginningMonthBalance + (_ExpectedIncomes - _ExpectedExpenses))),
            _summaryCardWidget(Languages.of(context)!.strCurrentIncomes, _currentIncomes, Languages.of(context)!.strExpectedIncomes, _ExpectedIncomes),
            _summaryCardWidget(Languages.of(context)!.strCurrentExpenses, _currentExpenses, Languages.of(context)!.strExpectedExpenses, _ExpectedExpenses),
            _summaryCardWidget(Languages.of(context)!.strTotalCurrentBalance, (_currentIncomes - _currentExpenses), Languages.of(context)!.strTotalExpectedBalance, (_ExpectedIncomes - _ExpectedExpenses)),
          ],
        ),
      ),
    );  }
}
