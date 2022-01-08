import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericTooltip extends StatefulWidget {
  const GenericTooltip({Key? key, this.tip, this.style}) : super(key: key);
  final String? tip;
  final TextStyle? style;

  @override
  _GenericTooltipState createState() => _GenericTooltipState();
}

class _GenericTooltipState extends State<GenericTooltip> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tip,
      textStyle: widget.style,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(gc.detailsIcon),
      ),
    );
  }
}
