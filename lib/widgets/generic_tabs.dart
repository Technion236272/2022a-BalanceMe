// ================= Generic Tab Widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/global/types.dart';

class TabGeneric extends StatefulWidget {
  const TabGeneric( this.tabsList, this.tabBarViewList, {this.onSwitch,Key? key})
      : super(key: key);

  final List<Widget> tabBarViewList;
  final List<Tab> tabsList;
  final VoidCallbackInt? onSwitch;


  @override
  _TabGenericState createState() => _TabGenericState();
}

class _TabGenericState extends State<TabGeneric> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.tabsList.length,
        child: Padding(
          padding: EdgeInsets.all(gc.tabPadding),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: gc.tabBarColor,
                  borderRadius: BorderRadius.circular(gc.tabBorderRadius),
                ),
                child: TabBar(
                    onTap:(int value) { if (widget.onSwitch!=null) {
                      widget.onSwitch!(value);
                    }},
                    indicatorColor: gc.tabIndicatorColor,
                    labelColor: gc.tabLabelColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: TextStyle(fontSize: gc.tabFontSize),
                    unselectedLabelColor: gc.tabUnselectedLabelColor,
                    isScrollable: false,
                    tabs: widget.tabsList),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * gc.tabBodyHeightResize,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(children: widget.tabBarViewList),
              )
            ],
          ),
        ));
  }
}