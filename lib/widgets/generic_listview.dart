// ================= Generic ListView =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

/*
* The widget receives the number of list tiles you want, a list of leading widget (will show in the beginning of the line)
* and trailing widgets (will show at the end of the line) assumption- the number of leading and trailing widgets
* is the same as the number of list tiles, if you don't want a leading or a trailing widget in a certain line
* simply add the value null to the list.
* the list includes dividers automatically between its tiles.
*
*/

class ListViewGeneric extends StatefulWidget {
  const ListViewGeneric(
      {Key? key, required this.leadingWidgets, required this.trailingWidgets, this.listTileHeight})
      : super(key: key);

  final List<Widget?> leadingWidgets;
  final List<Widget?> trailingWidgets;
  final double? listTileHeight;

  @override
  _ListViewGenericState createState() => _ListViewGenericState();
}

class _ListViewGenericState extends State<ListViewGeneric> {
  List<Widget> listViewTilesBuild() {
    List<Widget> tiles = [];
    if (widget.leadingWidgets.length != widget.trailingWidgets.length) {
      throw Exception("Different number of leading and trailing widgets");
    }
    for (var i = 0; i < widget.leadingWidgets.length; i++) {
      tiles.add(ListTile(
        leading: widget.leadingWidgets[i],
        trailing: widget.trailingWidgets[i],
      ));
      tiles.add(Divider(
        color: gc.dividerColor,
      ));
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: listViewTilesBuild(),
      itemExtent: widget.listTileHeight,
    );
  }
}
