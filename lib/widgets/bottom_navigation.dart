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
          label: Languages.of(context)!.strSettings,
          tooltip: Languages.of(context)!.strSettings,
        ),
        BottomNavigationBarItem(
          icon: const Icon(gc.balancePage),
          label: Languages.of(context)!.strBalance,
          tooltip: Languages.of(context)!.strBalance,
        ),
        BottomNavigationBarItem(
          icon: const Icon(gc.archivePage),
          label: Languages.of(context)!.strArchive,
          tooltip: Languages.of(context)!.strArchive,
        ),
      ],
      currentIndex: _selectedPage,
      selectedItemColor: gc.bottomNavigationSelectedColor,
      onTap: _updateSelectedPage,
    );
  }
}
