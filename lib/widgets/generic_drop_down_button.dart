// ================= Generic DropDown Button =================
import 'package:balance_me/global/types.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

/// The widget receives a List of String: ["hello", "world", ... ], controller of type PrimitiveWrapper(String initialSelected),
/// and callBack function.
/// The widgets presents a Dropdown button with the strings in the list.
/// in order to use the PrimitiveWrapper first create variable for example:
/// PrimitiveWrapper controller = PrimitiveWrapper("world");
/// And then pass it to the constructor of this widget:
/// GenericRadioButton(..., controller, ... , ...);
/// The initial selected button will be the "world" button.
/// The value of the selected radio button stored at the _radioButtonController.value.
/// The callBack function is called when you change selection.
/// The order of the buttons is the same order as the list.
/// If the list is too long the widget will continue in the next line.
///
class GenericDropDownButton extends StatefulWidget {
  const GenericDropDownButton(this._list, this._dropDownButtonController, {this.onChangedCallback, Key? key}) : super(key: key);

  final List<String> _list;
  final PrimitiveWrapper _dropDownButtonController;
  final VoidCallback? onChangedCallback;

  @override
  _GenericDropDownButtonState createState() => _GenericDropDownButtonState();
}

class _GenericDropDownButtonState extends State<GenericDropDownButton> {
  List<DropdownMenuItem<String>> itemsList = [];
  String? _selected;

  @override
  void initState() {
    if (!widget._list.contains(widget._dropDownButtonController.value)) {
      throw Exception(
          "The parameter which provided to the PrimitiveWrapper constructor is not in the list");
    }
    itemsList = widget._list.map(buildMenuItem).toList();
    super.initState();
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }

  void _onChanged(value) {
    setState(() {
      widget._dropDownButtonController.value = value;
      if (widget.onChangedCallback != null) {
        widget.onChangedCallback!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: gc.dropDownMargin,
        padding: gc.dropDownPadding,
        decoration: BoxDecoration(
          color: gc.dropdDownBGcolor,
          borderRadius: BorderRadius.circular(gc.dropDownRadius),
          border: gc.dropDownBorder,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: widget._dropDownButtonController.value,
            items: itemsList,
            onChanged: _onChanged,
            dropdownColor: gc.secondaryColor,
            isExpanded: true,
            menuMaxHeight: gc.numOfItems,
            style: gc.dropDownTextStyle,
            iconSize: gc.dropDownIconSize,
            iconDisabledColor: gc.disabledColor,
            iconEnabledColor: gc.primaryColor,
            enableFeedback: true,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
