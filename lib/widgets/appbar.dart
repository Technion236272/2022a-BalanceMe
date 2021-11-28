// ================= AppBar Widget =================
import 'package:flutter/material.dart';
import 'package:balance_me/widgets/user_avatar.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;
import 'package:balance_me/pages/login.dart';

// MinorAppBar
class MinorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MinorAppBar(this.appBarTitle, {Key? key}) : super(key: key);
  final String appBarTitle;
  final double height = kToolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
      centerTitle: true,
    );
  }
}

// MainAppBar
class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar(this._authRepository, this._userStorage, {Key? key}) : super(key: key);

  final AuthRepository _authRepository;
  final UserStorage _userStorage;
  final double height = kToolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(height);

  String getAppBarTitle(BuildContext context) {
    if (Languages.of(context) == null) {
      return "";
    }
    String userName = (_authRepository.status == Status.Authenticated && _authRepository.user != null) ?
    ", " + _authRepository.user!.email.toString() : "";
    return Languages.of(context)!.welcome + userName; // TODO- consider use user full name
  }

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  void _loginApp() {
    // TODO- replace to login screen after it will be implemented
    navigateToPage(context,  LoginPage());
  }

  void _logoutApp() {
    widget._authRepository.signOut();
    if (Languages.of(context) != null) {
      displaySnackBar(context, Languages.of(context)!.successfullyLogout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.getAppBarTitle(context)),
      centerTitle: true,
      leading: UserAvatar(widget._authRepository, gc.appBarAvatarRadius),
      actions: [
        widget._authRepository.status == Status.Authenticated ?
            IconButton(
                icon: const Icon(gc.authenticatedIcon),
                onPressed: () {
                  setState(
                      () => {_logoutApp()});
                },
                tooltip: Languages.of(context)!.logout,
              )
            : IconButton(
                icon: const Icon(gc.unauthenticatedIcon),
                onPressed: () => _loginApp(),
                tooltip: Languages.of(context)!.login,
              ),
      ],
    );
  }
}
