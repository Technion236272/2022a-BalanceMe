import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:balance_me/global/constants.dart' as gc;

class DesignedDatePicker extends StatefulWidget {
  const DesignedDatePicker({required this.dateController, this.onSelectDate, this.width = 150.0, this.height = 20.0, this.buttonColor = gc.primaryColor, this.datePickerColor = Colors.white, this.datePickerWidth = 180.0, this.datePickerHeight = 300.0, this.isRange = false,  Key? key}) : super(key: key);
  final DateRangePickerController dateController;
  final VoidCallback? onSelectDate;
  final double width;
  final double height;
  final Color buttonColor;
  final Color datePickerColor;
  final double datePickerWidth;
  final double datePickerHeight;
  final bool isRange;

  @override
  _DesignedDatePickerState createState() => _DesignedDatePickerState();
}

class _DesignedDatePickerState extends State<DesignedDatePicker> {
  String date = DateTime.now().year.toString() + "-" +DateTime.now().month.toString() + "-" + DateTime.now().day.toString();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: widget.width,
            height: widget.height,
            child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                          (states) => widget.buttonColor.withOpacity(0.4)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(widget.height/2),
                            side: BorderSide(color: widget.buttonColor),
                        )
                ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(gc.iconPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                            color: gc.secondaryColor,
                            fontSize: gc.tabFontSize),
                      ),
                      Icon(isVisible
                          ? gc.expandIcon
                          : gc.minimizeIcon,
                      color: gc.secondaryColor,)
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
              showDatePickerBox(widget.dateController, date, false),
            ),
          ),
        ],
      ),
    );
  }

  Widget showDatePickerBox(
      DateRangePickerController controller, String selector, bool navArrow) {
    return SfDateRangePicker(
      minDate: DateTime(2020),
      maxDate: DateTime.now(),
      backgroundColor: widget.datePickerColor,
      initialSelectedDate: DateTime.now(),
      selectionTextStyle: const TextStyle(color: gc.secondaryColor),
      showNavigationArrow: navArrow,
      view: DateRangePickerView.decade,
      showActionButtons: true,
      allowViewNavigation: true,
      controller: controller,
      onSubmit: (Object val) {
        setState(() {
          if (val is DateTime) {
            date = val.year.toString() + "-" +val.month.toString() + "-" + val.day.toString();
            if (widget.onSelectDate != null){
              widget.onSelectDate!();
            }
            isVisible = false;
          }
        });
      },
      onCancel: () {
        setState(() {
          controller.selectedDate = DateTime.now();
            isVisible = false;
        });
      },
    );
  }
}