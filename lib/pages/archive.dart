// ================= Archive Page =================
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
  final DateRangePickerController _dateController = DateRangePickerController();
  BalanceModel _currentBalance = BalanceModel();
  DateTime _currentDate = DateTime.now();
  bool _isIncomeTab = true;

  bool get isIncomeTab => _isIncomeTab;

  void _setCurrentTab(int currentTab) {
    _isIncomeTab = currentTab == 0;
  }

  void _updateCurrentBalance(Json data) {
    setState(() {
      _currentBalance = BalanceModel.fromJson(data);
    });
    displaySnackBar(context, Languages.of(context)!.dateReloadSuccessful);
  }

  void _resetCurrentBalance() {
    setState(() {
      _currentBalance = BalanceModel();
    });
    displaySnackBar(context, Languages.of(context)!.noDataForRange);
  }

  void _getCurrentBalance() {  // TODO- check if data is this month and present failure snackbar
    if (_dateController.selectedDate != null) {
      int endOfMonthDay = (widget._userStorage.userData == null) ? gc.defaultEndOfMonthDay : widget._userStorage.userData!.endOfMonthDay;
      DateTime requestedRange = DateTime(_dateController.selectedDate!.year, _dateController.selectedDate!.month, endOfMonthDay + 1);

      if (_currentDate == requestedRange) {
        return;
      }

      _currentDate = requestedRange;
      setState(() {
        widget._userStorage.GET_balanceModel(modifyMainBalance: false, specificDate: _currentDate, successCallback: _updateCurrentBalance, failureCallback: _resetCurrentBalance);
      });
      GoogleAnalytics.instance.logArchiveDateChange(_currentDate.toFullDate());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          (_currentBalance.isEmpty) ? GenericInfo(null, Languages.of(context)!.noDataForRange, null)
              : ListView(children: [BalancePage(_currentBalance, _setCurrentTab)]),
          DesignedDatePicker(
            dateController: _dateController,
            onSelectDate: _getCurrentBalance,
            viewSelector: DatePickerType.Month,  // TODO- remove
          ),
        ],
      ),
    );
  }
}
