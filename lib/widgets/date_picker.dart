import 'package:flutter/material.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class DatePicker extends StatefulWidget {
  DatePicker({this.dateController,this.onSelection, this.firstDate, this.lastDate, this.withBorder = false,
              this.color,this.textColor, this.iconColor, this.view = DatePickerType.Day, Key? key}) : super(key: key);

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
  DateTime _date = gc.today;
  DateTime _firstDate = gc.firstDate;
  DateTime _lastDate = gc.today;

  @override
  void initState() {
    _firstDate = widget.firstDate ?? gc.firstDate;
    _lastDate = widget.lastDate ?? gc.today;
    _date = _date.isAfter(_lastDate) ? DateTime(_lastDate.year,_lastDate.month - 1, _lastDate.day) : _date;
    super.initState();
  }

  String _getText(){
      return widget.view == DatePickerType.Day ? '${_date.year}/${_date.month}/${_date.day}' : '${_date.year}/${_date.month}';
  }

  Future _pickDate(BuildContext context) async {
    final initialDate = _date;
    final newDate = await showDatePicker(
      useRootNavigator: true,
      initialDatePickerMode: DatePickerMode.year,
      context: context,
      initialDate: initialDate,
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (newDate == null) return;
    setState(() {
      _date = newDate;
      widget.dateController!.value = widget.view == DatePickerType.Day ? _date : DateTime(_date.year, _date.month);
      if(widget.onSelection != null){
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
            child: Text(_getText(), style: TextStyle(color: widget.textColor)),
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
  DateRangePicker({this.dateRangeController, this.onSelection, this.firstDate, this.lastDate,this.withBorder = false, this.color, this.textColor,this.iconColor, Key? key}) : super(key: key);

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
  DateTimeRange _dateRange = DateTimeRange(start: gc.today, end: gc.today);
  DateTime _firstDate = gc.firstDate;
  DateTime _lastDate = gc.today;

  @override
  void initState() {
    _firstDate = widget.firstDate ?? gc.firstDate;
    _lastDate = widget.firstDate ?? gc.today;
    super.initState();
  }

  String _getText(){
    return '${_dateRange.start.year}/${_dateRange.start.month}/${_dateRange.start.day} - ${_dateRange.end.year}/${_dateRange.end.month}/${_dateRange.end.day}';
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
      if(widget.onSelection != null){
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
            padding:gc.datePickerPadding,
            child: Text(_getText(), style: TextStyle(color: widget.textColor),),
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


