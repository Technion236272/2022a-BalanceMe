// ================= Summary Page =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/pages/set_workspace.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/types.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  AuthRepository get authRepository => Provider.of<AuthRepository>(context, listen: false);
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  void _openSetWorkspace() {
    navigateToPage(context, SetWorkspace(), AppPages.SetWorkspace);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(Languages.of(context)!.strBalanceSummary),
          Visibility(  // TODO - move to List
            visible: authRepository.status == AuthStatus.Authenticated && userStorage.userData != null,
            child: Row(
              children: [
                Text(Languages.of(context)!.strCurrentWorkspace),
                Text(userStorage.userData!.currentWorkspace),
                ElevatedButton(
                  onPressed: _openSetWorkspace,
                  child: Text(Languages.of(context)!.strSet),
                ),
              ],
            ),
          ),
        ],
    );
  }
}
