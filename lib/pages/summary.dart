// ================= Summary Page =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/widgets/generic_drop_down_button.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/text_box_with_border.dart';
import 'package:balance_me/pages/authentication/change_password.dart';
import 'package:balance_me/widgets/languages_drop_down.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/pages/profile_settings.dart';
import 'package:balance_me/widgets/generic_radio_button.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/config.dart' as config;
import 'package:balance_me/global/constants.dart' as gc;

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  late TextEditingController _addNewGroupController;
  late PrimitiveWrapper _dropDownController;
  bool _showAddNewGroup = false;

  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _addNewGroupController = TextEditingController();
    _dropDownController = PrimitiveWrapper((userStorage.userData == null) ? Languages.of(context)!.strAddNewWorkspace : userStorage.userData!.groupName);
  }

  void _showAddWorkspaceIfNeeded() {
    setState(() {
      _showAddNewGroup = (_dropDownController.value == Languages.of(context)!.strAddNewWorkspace);
    });
  }

  void _addNewWorkspace() {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(Languages.of(context)!.strBalanceSummary),
          // GenericDropDownButton(
          //   [],  // TODO
          //   _dropDownController,
          //   onChangedCallback: _showAddWorkspaceIfNeeded,
          // ),
          Visibility(
            visible: _showAddNewGroup,
            child: Row(
              children: [
                TextBox(
                  _addNewGroupController,
                  Languages.of(context)!.strAddNewWorkspace,
                  haveBorder: false,
                ),
                ElevatedButton(
                    onPressed: _addNewWorkspace,
                    child: Text(Languages.of(context)!.strAdd)
                ),
              ],
            ),
          )
        ],
    );
  }
}
