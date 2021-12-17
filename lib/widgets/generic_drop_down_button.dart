// ================= Generic DropDown Button =================
import 'package:awesome_dropdown/awesome_dropdown.dart';
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
class GenericDropDownButton extends StatefulWidget {
  const GenericDropDownButton(this._list, this._dropDownButtonController, {this.onChangedCallback, Key? key}) : super(key: key);

  final List<String> _list;
  final PrimitiveWrapper _dropDownButtonController;
  final VoidCallback? onChangedCallback;

  @override
  _GenericDropDownButtonState createState() => _GenericDropDownButtonState();
}

class _GenericDropDownButtonState extends State<GenericDropDownButton> {

  @override
  void initState() {
    if (!widget._list.contains(widget._dropDownButtonController.value)) {
      throw Exception("The parameter which provided to the PrimitiveWrapper constructor is not in the list");
    }
    super.initState();
  }

  void _activateDropDownButton(String? value) {
    if (value != null) {
      setState(() {
        widget._dropDownButtonController.value = value;
        if (widget.onChangedCallback != null) {
          widget.onChangedCallback!();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AwesomeDropDown(
      selectedItemTextStyle: TextStyle(color: Colors.white, fontSize: gc.tabFontSize),
      dropDownList: widget._list,
      dropDownBGColor: gc.primaryColor,
      dropDownBottomBorderRadius: gc.dropDownRadius,
      dropDownTopBorderRadius: gc.dropDownRadius,
      dropDownBorderRadius: gc.dropDownRadius,
      dropDownIcon: const Icon(gc.minimizeIcon,color: Colors.white, ),
      onDropDownItemClick: _activateDropDownButton,
      selectedItem: widget._dropDownButtonController.value,
      numOfListItemToShow: gc.numOfItems,
    );
  }
}
