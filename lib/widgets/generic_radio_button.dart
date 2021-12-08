// ================= Generic Radio Button =================
import 'package:balance_me/global/types.dart';
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

/*
* The widget receives a List of String: ["hello", "world", ... ], controller of type PrimitiveWrapper(String value),
* initial String from the provided List, and callBack function.
* The widgets presents a row of radio buttons with the strings in the list.
* The initial selected button is the one which is provided as _initialValue.
* in order to use the PrimitiveWrapper first create variable for example:
* PrimitiveWrapper controller = PrimitiveWrapper("");
* And then pass it to the constructor of this widget:
* GenericRadioButton(..., controller, ... , ...);
* The value of the selected radio button stored at the _radioButtonController.value.
* The callBack function is called when you change selection.
* The order of the buttons is the same order as the list.
* If the list is too long the widget will continue in the next line.
*/

class GenericRadioButton extends StatefulWidget {
  const GenericRadioButton(this._options, this._radioButtonController, this._initialValue, {this.onTapCallback, Key? key}) : super(key: key);

  final List<String> _options;
  final PrimitiveWrapper _radioButtonController;
  final String _initialValue;
  final VoidCallback? onTapCallback;

  @override
  State<GenericRadioButton> createState() => _GenericRadioButtonState();
}

class _GenericRadioButtonState extends State<GenericRadioButton> {
  void _activateRadioButton(String? value) {
    if (value != null) {
      setState(() {
        widget._radioButtonController.value = value;
        if (widget.onTapCallback != null) {
          widget.onTapCallback!();
        }
      });
    }
  }

  List<Widget> _radioButtonOptions() {
    List<Widget> buttonOptions = [];
    for (String data in widget._options) {
      buttonOptions.add(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<String>(
                activeColor: gc.primaryColor,
                value: data,
                groupValue: widget._radioButtonController.value,
                onChanged: (String? value) => _activateRadioButton(value),
              ),
              Text(data),
            ],
          )
      );
    }
    return buttonOptions;
  }

  @override
  void initState() {
    if (widget._options.contains(widget._initialValue)) {
      widget._radioButtonController.value = widget._initialValue;
    }
    else {
      throw Exception("The _initialValue is not in the list");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: _radioButtonOptions(),
    );
  }
}
