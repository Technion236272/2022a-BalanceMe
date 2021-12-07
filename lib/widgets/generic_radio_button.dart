// ================= Generic Radio Button =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

/*
* The widget receives a List of String:
* ["hello", "world", ... ]
* The widgets presents a row of radio buttons with the strings in the list.
* The order of the buttons is the same order as the list.
* If the list is too long the widget will continue in the next line.
*/

class GenericRadioButton extends StatefulWidget {
  GenericRadioButton(this._options, this._radioButtonController,
      {this.onTapCallback, Key? key})
      : super(key: key);
  final List<String> _options;
  late String _radioButtonController;
  final VoidCallback? onTapCallback;


  set radioButtonController(String value) {
    _radioButtonController = value;
  }

  @override
  State<GenericRadioButton> createState() => _GenericRadioButtonState();
}

class _GenericRadioButtonState extends State<GenericRadioButton> {

  void _activateRadioButton(String? value){
    setState(() {
      widget._radioButtonController = value!;
      widget.onTapCallback;
    });
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
                groupValue: widget._radioButtonController,
                onChanged: (String? value) => _activateRadioButton(value),
              ),
              Text(data)
            ],
          ));
    }
    return buttonOptions;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: _radioButtonOptions(),
    );
  }

}
