import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class GenericTooltip extends StatefulWidget {
  const GenericTooltip({Key? key, this.tip}) : super(key: key);
  final String? tip;

  @override
  _GenericTooltipState createState() => _GenericTooltipState();
}

class _GenericTooltipState extends State<GenericTooltip> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tip,
      child: Icon(gc.transactionDetailsIcon),
    );
  }
}
