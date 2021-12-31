// ================= Generic ListView =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

/// The widget receives the number of list tiles you want, a list of leading widget (will show in the beginning of the line)
/// and trailing widgets (will show at the end of the line) assumption- the number of leading and trailing widgets
/// is the same as the number of list tiles, if you don't want a leading or a trailing widget in a certain line
/// simply add the value null to the list.
/// the list includes dividers automatically between its tiles.
class ListViewGeneric extends StatelessWidget {
  const ListViewGeneric({Key? key, required this.leadingWidgets, required this.trailingWidgets, this.listTileHeight, this.isScrollable = true}) : super(key: key);

  final List<Widget?> leadingWidgets;
  final List<Widget?> trailingWidgets;
  final double? listTileHeight;
  final bool isScrollable;

  List<Widget> _getListViewTilesBuild() {
    List<Widget> tiles = [];

    if (leadingWidgets.length != trailingWidgets.length) {
      throw Exception("Different number of leading and trailing widgets");
    }

    for (var i = 0; i < leadingWidgets.length; i++) {

        tiles.add(ListTile(
          leading: leadingWidgets[i],
          trailing: trailingWidgets[i],
        ));

        tiles.add(const Divider(color: gc.dividerColor));
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: _getListViewTilesBuild(),
      itemExtent: listTileHeight,
      physics: isScrollable ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
    );
  }
}
