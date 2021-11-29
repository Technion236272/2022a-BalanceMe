import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;

class TabGeneric extends StatefulWidget {
  const TabGeneric( this.tabsList, this.tabBarViewList, {Key? key})
      : super(key: key);

  final List<Widget> tabBarViewList;
  final List<Tab> tabsList;


  @override
  _TabGenericState createState() => _TabGenericState();
}

class _TabGenericState extends State<TabGeneric> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.tabsList.length,
        child: genericTabs(
            context, widget.tabsList, widget.tabBarViewList));
  }

  Widget genericTabs(BuildContext context, List<Tab> tabsList, List<Widget> tabBarViewList) {
    return Padding(
      padding: EdgeInsets.all(gc.tabPadding),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: gc.tabBarColor,
              borderRadius: BorderRadius.circular(gc.tabBorderRadius),
            ),
            child: TabBar(
                indicatorColor: gc.tabIndicatorColor,
                labelColor: gc.tabLabelColor,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(fontSize: gc.tabFontSize),
                unselectedLabelColor: gc.tabUnselectedLabelColor,
                isScrollable: false,
                tabs: tabsList),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * gc.tabBodyHeightResize,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(children: tabBarViewList),
          )
        ],
      ),
    );
  }
}