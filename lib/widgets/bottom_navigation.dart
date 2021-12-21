// ================= AppBar Widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(this._selectedPage, this._updateSelectedPage, {Key? key}) : super(key: key);

  final int _selectedPage;
  final VoidCallbackInt _updateSelectedPage;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(gc.settingsPage),
          label: Languages.of(context)!.settings,
          tooltip: Languages.of(context)!.settings,
        ),
        BottomNavigationBarItem(
          icon: const Icon(gc.balancePage),
          label: Languages.of(context)!.balance,
          tooltip: Languages.of(context)!.balance,
        ),
        BottomNavigationBarItem(
          icon: const Icon(gc.archivePage),
          label: Languages.of(context)!.archive,
          tooltip: Languages.of(context)!.archive,
        ),
      ],
      currentIndex: _selectedPage,
      selectedItemColor: gc.bottomNavigationSelectedColor,
      onTap: _updateSelectedPage,
    );
  }
}
