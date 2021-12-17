// ================= Image picker widget =================
import 'package:balance_me/global/constants.dart' as gc;
import 'package:flutter/material.dart';

List<Widget> createOptions(List<GestureTapCallback?> actions,
    List<Widget?> leading, List<String> titles) {
  List<Widget> options = [];
  if (leading.length != actions.length ||
      titles.length != actions.length ||
      titles.length != leading.length) {
    throw Exception(gc.differentListLength);
  }
  for (int i = 0; i < actions.length; i++) {
    options.add(ListTile(
      leading: leading[i],
      title: Text(titles[i]),
      onTap: actions[i],
    ));
  }
  return options;
}

void imagePicker(BuildContext context, List<GestureTapCallback?> actions,
    List<Widget?> leading, List<String> titles) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: createOptions(actions, leading, titles),
          ),
        );
      });
}
