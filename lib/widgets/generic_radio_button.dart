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
  const GenericRadioButton(this.options, {Key? key}) : super(key: key);
  final List<String> options;

  @override
  State<GenericRadioButton> createState() => _GenericRadioButtonState();
}

class _GenericRadioButtonState extends State<GenericRadioButton> {
  String? _character;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: radioButtonOptions(widget.options),
    );
  }

  List<Widget> radioButtonOptions(List<String> options) {
    List<Widget> buttonOptions = [];
    for (String data in options) {
      buttonOptions.add(SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              activeColor: gc.primaryColor,
              value: data,
              groupValue: _character,
              onChanged: (String? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            Text(data)
          ],
        ),
      ));
    }
    return buttonOptions;
  }
}
