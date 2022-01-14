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
    return Visibility(
      visible: widget.tip != null,
      child: Tooltip(
        message: widget.tip == null ? "" : widget.tip!,
        textStyle: widget.style,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(gc.detailsIcon),
        ),
      ),
    );
  }
}
