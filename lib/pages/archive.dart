// ================= Archive Page =================
import 'package:balance_me/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/pages/balance/balance_page.dart';
import 'package:balance_me/common_models/balance_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:balance_me/widgets/designed_date_picker.dart';
import 'package:balance_me/widgets/generic_info.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class Archive extends StatefulWidget {
  const Archive(this._userStorage, {Key? key}) : super(key: key);

  final UserStorage _userStorage;

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  final PrimitiveWrapper _dateController = PrimitiveWrapper(DateTime.now());
  BalanceModel _currentBalance = BalanceModel();
  bool _isIncomeTab = true;

  bool get isIncomeTab => _isIncomeTab;

  void _setCurrentTab(int currentTab) {
    _isIncomeTab = currentTab == 0;
  }

  void _updateCurrentBalance(Json data) {
    setState(() {
      _currentBalance = BalanceModel.fromJson(data);
    });
  }

  void _resetCurrentBalance() {
    setState(() {
      _currentBalance = BalanceModel();
    });
  }

  void _getCurrentBalance() {
    if (_dateController.value != null) {
      int endOfMonthDay = (widget._userStorage.userData == null) ? gc.defaultEndOfMonthDay : widget._userStorage.userData!.endOfMonthDay;
      DateTime requestedRange = DateTime(_dateController.value!.year, _dateController.value!.month, endOfMonthDay);
      setState(() {
        widget._userStorage.GET_balanceModel(modifyMainBalance: false, specificDate: requestedRange, successCallback: _updateCurrentBalance, failureCallback: _resetCurrentBalance);
      });
      GoogleAnalytics.instance.logArchiveDateChange(requestedRange.toFullDate());
    }
  }

  Widget _getArchiveDatePicker() {
    return Center(
      child: Padding(
        padding: gc.ArchDatePickerPadd,
        child: SizedBox(
          width: MediaQuery.of(context).size.width/3,
          child: DatePicker(
            view: DatePickerType.Month,
            dateController: _dateController,
            onSelection: _getCurrentBalance,
            firstDate: gc.firstDate,
            lastDate: DateTime(DateTime.now().year,DateTime.now().month - 1 , DateTime.now().day), // TODO - put the last Date you want to see backwards
            withBorder: true,
            color: gc.primaryColor,
            textColor: gc.secondaryColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: (_currentBalance.isEmpty) ?
            Column(
              children: [
                GenericInfo(topInfo: Languages.of(context)!.noDataForRange),
                _getArchiveDatePicker()
              ],
            )
          : ListView(children: [BalancePage(_currentBalance, _setCurrentTab, additionalWidget: _getArchiveDatePicker())]),
      );
  }
}
