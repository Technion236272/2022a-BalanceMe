// ================= AppBar Widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/pages/authentication/authentication_manager.dart';
import 'package:balance_me/widgets/user_avatar.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;


// MinorAppBar
class MinorAppBar extends StatelessWidget implements PreferredSizeWidget {

  const MinorAppBar(this._appBarTitle, {Key? key}) : super(key: key);
  final String _appBarTitle;
  final double _height = kToolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_appBarTitle),
      centerTitle: true,
    );
  }
}

// MainAppBar
class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar(this._authRepository, this._userStorage, this._pageIndex, {Key? key}) : super(key: key);

  final AuthRepository _authRepository;
  final UserStorage _userStorage;
  final int _pageIndex;
  final double _height = kToolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(_height);

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  String _getAppBarTitle(BuildContext context) {
    if (Languages.of(context) == null) {
      return Languages.of(context)!.appName;
    }

    if (widget._pageIndex == AppPages.Settings.index) {
      return Languages.of(context)!.settings;
    }
    if (widget._pageIndex == AppPages.Statistics.index) {
      return Languages.of(context)!.statistics;
    }

    return (widget._authRepository.status == AuthStatus.Authenticated) ? Languages.of(context)!.welcomeBack : Languages.of(context)!.welcomeAboard;
  }

  void _loginApp() {
    navigateToPage(context, AuthenticationManager(widget._authRepository,widget._userStorage), null);
  }

  void _logoutApp() {
    setState(() {
      widget._authRepository.signOut();
      if (Languages.of(context) != null) {
        displaySnackBar(context, Languages.of(context)!.successfullyLogout);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_getAppBarTitle(context)),
      centerTitle: true,
      leading: UserAvatar(widget._authRepository, gc.appBarAvatarRadius),
      actions: [
        widget._authRepository.status == AuthStatus.Authenticated ?
            IconButton(
                icon: const Icon(gc.authenticatedIcon),
                onPressed: _logoutApp,
                tooltip: Languages.of(context)!.logout,
              )
            : IconButton(
                icon: const Icon(gc.unauthenticatedIcon),
                onPressed: _loginApp,
                tooltip: Languages.of(context)!.login,
              ),
      ],
    );
  }
}
