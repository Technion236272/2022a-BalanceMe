// ================= Archive Page =================
import 'package:balance_me/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/pages/balance/balance_page.dart';
import 'package:balance_me/common_models/balance_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
  final DateRangePickerController _test = DateRangePickerController();
  BalanceModel _currentBalance = BalanceModel();
  bool _isIncomeTab = true;
  bool _isVisible = false;

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

  void _hideDatePicker(){
    setState(() {
      _isVisible = false;
    });
  }

  Widget _getArchiveDatePicker() {
    return GestureDetector(
      onTap: _hideDatePicker,
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: ArchiveDatePicker(dateController: _test, onSelectDate: _getCurrentBalance, isVisible: _isVisible,),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: (_currentBalance.isEmpty) ?
            Stack(
              children: [
                GenericInfo(null, Languages.of(context)!.noDataForRange, null),
                _getArchiveDatePicker(),
              ],
            )
          : ListView(children: [BalancePage(_currentBalance, _setCurrentTab, additionalWidget: _getArchiveDatePicker())]),
      );
  }
}
