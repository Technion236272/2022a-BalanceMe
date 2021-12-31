// ================= Summary Page =================
import 'package:balance_me/widgets/generic_listview.dart';
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

  void _rebuildPage() => {setState(() {})};

  void _openSetWorkspace() {
    navigateToPage(context, SetWorkspace(afterChangeWorkspaceCB: _rebuildPage), AppPages.SetWorkspace);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            Text(Languages.of(context)!.strBalanceSummary),
            // TODO- design: add diagram
            ListViewGeneric(
              leadingWidgets: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Visibility(
                    visible: authRepository.status == AuthStatus.Authenticated && userStorage.userData != null,
                    child: Text(Languages.of(context)!.strCurrentWorkspace),
                  ),
                ),
              ],
              trailingWidgets: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Visibility(
                    visible: authRepository.status == AuthStatus.Authenticated && userStorage.userData != null,
                    child: Row(
                      children: [
                        Text(userStorage.userData!.currentWorkspace),
                        ElevatedButton(
                          onPressed: _openSetWorkspace,
                          child: Text(Languages.of(context)!.strSet),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
      ),
    );
  }
}
