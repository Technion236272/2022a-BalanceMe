// ================= Generic button widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/widgets/action_button.dart';

/*
* The widget receives the text which will show up on the button,
*  the color of the button (filled as shown in the UI)
* and an optional function which it will perform when pressed (a void function)
*/

class GenericButton extends StatefulWidget {
  const GenericButton(
      {Key? key,
      required this.buttonText,
      this.buttonColor = gc.primaryColor,
      required this.onPressed})
      : super(key: key);
  final String buttonText;
  final Color buttonColor;
  final GestureTapCallback onPressed;

  @override
  _GenericButtonState createState() => _GenericButtonState();
}

class _GenericButtonState extends State<GenericButton> {
    bool _loading=false;
   void _updatePerformingSave(bool state) {
     setState(() {
       _loading = state;
     });
   }
  ButtonStyle filledButtonColor()
  {
    ButtonStyle fillTheButton=ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all<Color>(widget.buttonColor));
    return fillTheButton;
  }
  Future<void> waitForFunction()
  async {
    _updatePerformingSave(true);
    widget.onPressed.call();
    Future.delayed(Duration.zero);
    _updatePerformingSave(false);
  }
  @override
  Widget build(BuildContext context) {
    return ActionButton(_loading,widget.buttonText,waitForFunction,style: filledButtonColor());
  }
}
