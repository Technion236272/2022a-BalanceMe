// ================= Date Picker Widgets =================
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class DatePicker extends StatefulWidget {
  DatePicker({this.dateController, this.onSelection, this.firstDate, this.lastDate, this.withBorder = false, this.color,
              this.textColor, this.iconColor, this.view = DatePickerType.Day, Key? key}) : super(key: key);

  PrimitiveWrapper? dateController;
  final VoidCallback? onSelection;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool withBorder;
  final Color? color;
  final Color? textColor;
  final Color? iconColor;
  final DatePickerType view;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _date = DateTime.now();
  DateTime _firstDate = gc.firstDate;
  DateTime _lastDate = DateTime.now();

  @override
  void initState() {
    _firstDate = widget.firstDate ?? gc.firstDate;
    _lastDate = widget.lastDate ?? DateTime.now();
    super.initState();
  }

  Future _pickDate(BuildContext context) async {
    final initialDate = _date;
    final newDate = await showDatePicker(
      useRootNavigator: true,
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: initialDate,
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (newDate == null) return;
    setState(() {
      _date = newDate;
      widget.dateController!.value = _date.toFullDate();
      if (widget.onSelection != null) {
        widget.onSelection!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.withBorder
          ? BoxDecoration(
              color: widget.color,
              border: Border.all(
                  color: Colors.black38, width: gc.cardThinBorderWidth),
              borderRadius: gc.datePickerRadius)
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: gc.datePickerPadding,
            child: Text(widget.dateController == null ? _date.toFullDate() : widget.dateController!.value, style: TextStyle(color: widget.textColor)),
          ),
          IconButton(
            iconSize: gc.iconSize,
            padding: gc.datePickerPadding,
            constraints: const BoxConstraints(),
            icon: const Icon(gc.calendarIcon),
            color: widget.iconColor,
            onPressed: () => _pickDate(context),
          )
        ],
      ),
    );
  }
}

class DateRangePicker extends StatefulWidget {
  DateRangePicker({this.dateRangeController, this.onSelection, this.firstDate, this.lastDate, this.withBorder = false, this.color,
                   this.textColor, this.iconColor, Key? key}) : super(key: key);

  PrimitiveWrapper? dateRangeController;
  final VoidCallback? onSelection;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool withBorder;
  final Color? color;
  final Color? textColor;
  final Color? iconColor;

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTimeRange _dateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DateTime _firstDate = gc.firstDate;
  DateTime _lastDate = DateTime.now();

  @override
  void initState() {
    _firstDate = widget.firstDate ?? gc.firstDate;
    _lastDate = widget.firstDate ?? DateTime.now();
    super.initState();
  }

  String _getText() {
    return '${_dateRange.start.year}/${_dateRange.start.month}/${_dateRange.start.day}-${_dateRange.end.year}/${_dateRange.end.month}/${_dateRange.end.day}';
  }

  Future _pickDateRange(BuildContext context) async {
    final initialDateRange = _dateRange;
    final newDate = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (newDate == null) return;
    setState(() {
      _dateRange = newDate;
      widget.dateRangeController!.value = _dateRange;
      if (widget.onSelection != null) {
        widget.onSelection!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.withBorder
          ? BoxDecoration(
              color: widget.color,
              border: Border.all(
                  color: Colors.black38, width: gc.cardThinBorderWidth),
              borderRadius: gc.datePickerRadius)
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: gc.datePickerPadding,
            child: Text(
              _getText(),
              style: TextStyle(color: widget.textColor),
            ),
          ),
          IconButton(
            iconSize: gc.iconSize,
            padding: gc.datePickerPadding,
            constraints: const BoxConstraints(),
            icon: const Icon(gc.calendarIcon),
            color: widget.iconColor,
            onPressed: () => _pickDateRange(context),
          )
        ],
      ),
    );
  }
}

class ArchiveDatePicker extends StatefulWidget {
  ArchiveDatePicker({required this.dateController, this.onSelectDate, this.firstDate, this.lastDate, this.height = 35.0, this.isVisible = false, Key? key}): super(key: key);

  final DateRangePickerController dateController;
  final VoidCallback? onSelectDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final double height;
  late bool isVisible;

  @override
  _ArchiveDatePickerState createState() => _ArchiveDatePickerState();
}

class _ArchiveDatePickerState extends State<ArchiveDatePicker> {
  DateTime initialDate = DateTime.now();
  String initialDateString = "";

  @override
  void initState() {
    initialDateString = initialDate.year.toString() + "/" + initialDate.month.toString();
    initialDate = widget.lastDate != null ? widget.lastDate! : DateTime.now();
    super.initState();
  }

  void _hideDatePicker() {
    setState(() {
      widget.isVisible = false;
    });
  }

  void _showDatePicker() {
    setState(() {
      widget.isVisible = true;
    });
  }

  void _onSubmit(val) {
    setState(() {
      if (val is DateTime) {
        initialDateString = val.year.toString() + "/" + val.month.toString();
        widget.dateController.selectedDate = val;
      }
      widget.onSelectDate != null ? widget.onSelectDate!() : null;
      widget.isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: gc.datePickerDayViewWidth,
            height: widget.height,
            child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => gc.primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.height / 2),
                    side: const BorderSide(color: gc.primaryColor),
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(gc.datePickerGeneralPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        initialDateString,
                        style: const TextStyle(
                          color: gc.secondaryColor,
                          fontSize: gc.datePickerFontSize,
                        ),
                      ),
                      Icon(
                        widget.isVisible ? gc.expandIcon : gc.minimizeIcon,
                        size: gc.datePickerIconSize,
                        color: gc.secondaryColor,
                      ),
                    ],
                  ),
                ),
                onPressed:
                    widget.isVisible ? _hideDatePicker : _showDatePicker),
          ),
          Visibility(
            visible: widget.isVisible,
            maintainAnimation: true,
            maintainState: true,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / gc.datePickerWidthScale,
              height: MediaQuery.of(context).size.height / gc.datePickerHeightScale,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: gc.datePickerGeneralPadding,
                    right: gc.datePickerRightPadding,
                ),
                child: SfDateRangePicker(
                  controller: widget.dateController,
                  minDate: widget.firstDate != null ? widget.firstDate! : gc.firstDate,
                  maxDate: widget.lastDate != null ? widget.lastDate! : DateTime.now(),
                  view: DateRangePickerView.year,
                  backgroundColor: gc.secondaryColor,
                  selectionTextStyle: const TextStyle(color: gc.secondaryColor),
                  showNavigationArrow: true,
                  showActionButtons: true,
                  allowViewNavigation: false,
                  onSubmit: _onSubmit,
                  onCancel: _hideDatePicker,
                  todayHighlightColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
