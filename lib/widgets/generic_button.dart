import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericButton extends StatefulWidget {
  const GenericButton(
      {Key? key,
      required this.buttonText,
      this.buttonColor = gc.primaryColor,
      this.onPressed})
      : super(key: key);
  final String buttonText;
  final Color buttonColor;
  final GestureTapCallback? onPressed;

  @override
  _GenericButtonState createState() => _GenericButtonState();
}

class _GenericButtonState extends State<GenericButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(widget.buttonColor)),
          onPressed: widget.onPressed,
          child: Text(widget.buttonText)),
    );
  }
}
