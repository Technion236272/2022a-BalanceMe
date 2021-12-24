// ================= Archive Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/pages/balance/balance_page.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:balance_me/widgets/generic_info.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class Archive extends StatefulWidget {
  const Archive(this._authRepository, this._userStorage, {Key? key}) : super(key: key);

  final UserStorage _userStorage;
  final AuthRepository _authRepository;

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  final DateRangePickerController _dateController = DateRangePickerController();
  bool _isIncomeTab = true;
  bool _isVisible = false;
  bool _waitingForData = false;

  @override
  void initState(){
    super.initState();
    widget._userStorage.currentDate = null;
    if (widget._authRepository.status == AuthStatus.Authenticated) {
      widget._userStorage.resetBalance();
    }
  }

  void _stopWaitingForDataCB() {
    setState(() {
      _waitingForData = false;
    });
  }

  bool get isIncomeTab => _isIncomeTab;

  void _setCurrentTab(int currentTab) {
    _isIncomeTab = (currentTab == 0);
  }

  void _showMsgAccordingToBalance([Json? data]) {
    (data == null) ? displaySnackBar(context, Languages.of(context)!.dataUnavailable) : displaySnackBar(context, Languages.of(context)!.dateReloadSuccessful);
    _stopWaitingForDataCB();
  }

  void _getCurrentBalance() {  // TODO- check if data is this month and present failure snackbar
    if (widget._authRepository.status == AuthStatus.Authenticated && _dateController.selectedDate != null) {
      print("&&&&&&&&&&&&&&& selectedDate = ${_dateController.selectedDate!.toFullDate()}");
      int endOfMonthDay = (widget._userStorage.userData == null) ? gc.defaultEndOfMonthDay : widget._userStorage.userData!.endOfMonthDay;
      DateTime requestedRange = DateTime(_dateController.selectedDate!.year, _dateController.selectedDate!.month, endOfMonthDay);

      print("&&&&&&&&&&&&&&& requestedRange = ${requestedRange.toFullDate()}");

      if (widget._userStorage.currentDate != null && widget._userStorage.currentDate!.isSameDate(requestedRange)) {
        print("********");
        return;
      }

      widget._userStorage.setDate(requestedRange);
      setState(() {
        _waitingForData = true;
        widget._userStorage.GET_balanceModel(successCallback: _showMsgAccordingToBalance, failureCallback: _showMsgAccordingToBalance);
      });
      GoogleAnalytics.instance.logArchiveDateChange(widget._userStorage.currentDate!.toFullDate());

    } else {
      _showMsgAccordingToBalance();
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
          child: ArchiveDatePicker(dateController: _dateController, onSelectDate: _getCurrentBalance, isVisible: _isVisible,),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _waitingForData ? const Center(child: CircularProgressIndicator())

          : (widget._userStorage.currentDate != null && !widget._userStorage.balance.isEmpty) ?
              ListView(children: [BalancePage(widget._userStorage.balance, _setCurrentTab)])
              : GenericInfo(topInfo: Languages.of(context)!.dataUnavailable),
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
