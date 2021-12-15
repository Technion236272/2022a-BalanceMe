import 'package:balance_me/global/types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:balance_me/global/constants.dart' as gc;

/// The widget is a designed date picker.
/// It's received some designed parameter to design the container of the date
/// and the date picker itself.
/// It's also receive controller that holds the current state of the date picker (hold the selected date),
/// a callBack function with executed when you select a date, and a boolean parameter which
/// change the date picker mode between single date to range date (when true, the mode is range mode
/// and the default is false).
/// The widgets presents a button with the selected date (the default is the current date)
/// on press it shows the date picker where you can select the date or range of dates
/// depend on the date picker mode.
/// The value of the selected date\dates is stored in the controller.selectedDate or
/// controller.selectedRange.(startDate or endDate).
/// The callBack function is called when you change selection.
class DesignedDatePicker extends StatefulWidget {  // TODO- refactor
  const DesignedDatePicker({required this.dateController, this.onSelectDate, this.height = 35.0,
    this.buttonColor = gc.primaryColor, this.datePickerColor = Colors.white, this.datePickerWidth = 180.0, this.datePickerHeight = 300.0,
    this.isRange = false, this.viewSelector = DatePickerType.Day,  Key? key}) : super(key: key);

  final DateRangePickerController dateController;
  final VoidCallback? onSelectDate;
  final double height;
  final Color buttonColor;
  final Color datePickerColor;
  final double datePickerWidth;
  final double datePickerHeight;
  final bool isRange;
  final DatePickerType viewSelector;

  @override
  _DesignedDatePickerState createState() => _DesignedDatePickerState();
}

class _DesignedDatePickerState extends State<DesignedDatePicker> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String startDateString = "";
  String endDateString = "";
  bool isVisible = false;

  @override
  void initState() {
    startDateString = (widget.viewSelector == DatePickerType.Day)
        ? startDate.year.toString() + "/" + startDate.month.toString() + "/" + startDate.day.toString()
        : widget.viewSelector == DatePickerType.Month
        ? startDate.year.toString() + "/" + startDate.month.toString()
        : startDate.year.toString();

    endDateString = (widget.viewSelector == DatePickerType.Day)
        ? endDate.year.toString() + "/" + endDate.month.toString() + "/" + endDate.day.toString()
        : widget.viewSelector == DatePickerType.Month
        ? endDate.year.toString() + "/" + endDate.month.toString()
        : endDate.year.toString();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: (widget.viewSelector == DatePickerType.Day)
                ? (widget.isRange) ? gc.dateRangePickerDayViewWidth : gc.datePickerDayViewWidth
                : widget.viewSelector == DatePickerType.Month
                ? (widget.isRange) ? gc.dateRangePickerMonthViewWidth : gc.datePickerMonthViewWidth
                : (widget.isRange) ? gc.dateRangePickerYearViewWidth : gc.datePickerYearViewWidth,
            height: widget.height,
            child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                          (states) => widget.buttonColor.withOpacity(0.95)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(widget.height / 2),
                            side: BorderSide(color: widget.buttonColor),
                        )
                ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(gc.datePickerGeneralPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.isRange
                        ? startDateString + ' - ' + endDateString
                        : startDateString,
                        style: const TextStyle(
                            color: gc.secondaryColor,
                            fontSize: gc.datePickerFontSize,
                        ),
                      ),
                      Icon(isVisible
                          ? gc.expandIcon
                          : gc.minimizeIcon,
                      size: gc.datePickerIconSize,
                      color: gc.secondaryColor,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                }),
          ),
          Visibility(
            visible: isVisible,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: SizedBox(
              width: widget.datePickerWidth,
              height: widget.datePickerHeight,
              child:
              Padding(
                padding: const EdgeInsets.only(top: gc.datePickerGeneralPadding, right: gc.datePickerRightPadding),
                child: SfDateRangePicker(
                  selectionMode: widget.isRange ? DateRangePickerSelectionMode.range : DateRangePickerSelectionMode.single,
                  minDate: DateTime(2020),  // TODO- move to gc
                  maxDate: DateTime.now(),
                  view: widget.viewSelector == DatePickerType.Day
                      ? DateRangePickerView.month
                      : widget.viewSelector == DatePickerType.Month
                      ? DateRangePickerView.year
                      : DateRangePickerView.decade,
                  backgroundColor: widget.datePickerColor,
                  initialSelectedDate: DateTime.now(),
                  initialSelectedRange: PickerDateRange(startDate, endDate),
                  selectionTextStyle: const TextStyle(color: gc.secondaryColor),
                  showNavigationArrow: true,
                  showActionButtons: true,
                  allowViewNavigation: false,
                  controller: widget.dateController,
                  onSubmit: (Object val) {
                    setState(() {
                      if (val is DateTime) {
                        startDateString = (widget.viewSelector == DatePickerType.Day)
                            ? val.year.toString() + "/" + val.month.toString() + "/" + val.day.toString()
                            : widget.viewSelector == DatePickerType.Month
                            ? val.year.toString() + "/" + val.month.toString()
                            : val.year.toString();
                        widget.dateController.selectedDate = val;
                      }
                      if (val is PickerDateRange) {
                        startDate = val.startDate!;
                        endDate = val.endDate!;
                        startDateString = (widget.viewSelector == DatePickerType.Day)
                            ? startDate.year.toString() + "/" + startDate.month.toString() + "/" + startDate.day.toString()
                            : widget.viewSelector == DatePickerType.Month
                            ? startDate.year.toString() + "/" + startDate.month.toString()
                            : startDate.year.toString();
                        endDateString = (widget.viewSelector == DatePickerType.Day)
                            ? endDate.year.toString() + "/" + endDate.month.toString() + "/" + endDate.day.toString()
                            : widget.viewSelector == DatePickerType.Month
                            ? endDate.year.toString() + "/" + endDate.month.toString()
                            : endDate.year.toString();
                        widget.dateController.selectedRange = val;
                      }
                      widget.onSelectDate != null ? widget.onSelectDate!() : null;
                      isVisible = false;
                    });
                  },
                  onCancel: () {
                    setState(() {
                      widget.dateController.selectedDate = DateTime.now();
                      isVisible = false;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}