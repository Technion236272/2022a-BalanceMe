// ================= Archive Page =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/pages/balance/balance_page.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:balance_me/widgets/date_picker.dart';
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
  bool _isIncomeTab = false;
  bool _isVisible = false;
  bool _waitingForData = false;

  @override
  void initState(){
    super.initState();
    widget._userStorage.archiveBalance = null;
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

  void _hideDatePicker(){
    setState(() {
      _isVisible = false;
    });
  }

  bool get isIncomeTab => _isIncomeTab;

  void _setCurrentTab(int currentTab) {
    _isIncomeTab = (currentTab == 1);
  }

  void _showMsgAccordingToBalance([Json? data]) {
    (data == null) ? displaySnackBar(context, Languages.of(context)!.strDataUnavailable) : displaySnackBar(context, Languages.of(context)!.strDataReloadSuccessful);
    _stopWaitingForDataCB();
  }

  void _getCurrentBalance() async {
    if (widget._authRepository.status == AuthStatus.Authenticated && _dateController.selectedDate != null) {
      int endOfMonthDay = (widget._userStorage.userData == null) ? gc.defaultEndOfMonthDay : widget._userStorage.userData!.endOfMonthDay;
      DateTime requestedRange = DateTime(_dateController.selectedDate!.year, _dateController.selectedDate!.month, endOfMonthDay);

      if (widget._userStorage.currentDate != null && widget._userStorage.currentDate!.isSameDate(requestedRange)) {
        return;
      }

      _waitingForData = true;
      widget._userStorage.archiveBalance = await widget._userStorage.GET_balanceModel(dateTime: requestedRange, successCallback: _showMsgAccordingToBalance, failureCallback: _showMsgAccordingToBalance);
      setState(() {});
      GoogleAnalytics.instance.logArchiveDateChange(requestedRange.toFullDate());
    } else {
      _showMsgAccordingToBalance();
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentMonth = getCurrentMonth((widget._userStorage.userData == null) ? gc.defaultEndOfMonthDay : widget._userStorage.userData!.endOfMonthDay);
    return GestureDetector(
      onTap: _hideDatePicker,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
        children: [
          _waitingForData ? const Center(child: CircularProgressIndicator())
          : (widget._userStorage.archiveBalance != null && !widget._userStorage.archiveBalance!.isEmpty) ?
              ListView(children: [BalancePage(widget._userStorage.archiveBalance!, _setCurrentTab)])
              : GenericInfo(topInfo: Languages.of(context)!.strDataUnavailable),
          Padding(
            padding: const EdgeInsets.only(top: gc.archiveDatePickerPadding),
            child: Center(
              child: ArchiveDatePicker(
                dateController: _dateController,
                onSelectDate: _getCurrentBalance,
                lastDate: DateTime(currentMonth.year, currentMonth.month - 1),
                isVisible: _isVisible,
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
