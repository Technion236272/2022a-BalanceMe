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
  BalanceModel _monthlyBalance = BalanceModel();
  bool _isIncomeTab = true;

  bool get isIncomeTab => _isIncomeTab;

  void _setCurrentTab(int currentTab) {
    _isIncomeTab = currentTab == 0;
  }

  void _getMonthlyBalance() {
    if (_dateController.selectedDate != null) {
      int endOfMonthDay = (widget._userStorage.userData == null) ? gc.defaultEndOfMonthDay : widget._userStorage.userData!.endOfMonthDay;
      DateTime requestedRange = DateTime(_dateController.selectedDate!.year, _dateController.selectedDate!.month, endOfMonthDay);
      setState(() {
        widget._userStorage.GET_balanceModel(modifyBalance: _monthlyBalance, specificDate: requestedRange);
      });
      GoogleAnalytics.instance.logArchiveDateChange(requestedRange.toFullDate());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_monthlyBalance.isEmpty);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),  // TODO- gc
            child: DesignedDatePicker(
              dateController: _dateController,
              viewSelector: DatePickerType.Month,
              onSelectDate: _getMonthlyBalance,
            ),
          ),
          (_monthlyBalance.isEmpty) ?
            GenericInfo(topInfo: Languages.of(context)!.noDataForRange)
          : ListView(children: [BalancePage(_monthlyBalance, _setCurrentTab)]),
        ],
      ),
    );
  }
}
