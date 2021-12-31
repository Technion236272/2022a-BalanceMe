// ================= Summary Page =================
import 'package:balance_me/widgets/action_button.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/widgets/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/widgets/generic_drop_down_button.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/generic_dismissible.dart';
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

class SetWorkspace extends StatefulWidget {
  const SetWorkspace({Key? key}) : super(key: key);

  @override
  _SetWorkspaceState createState() => _SetWorkspaceState();
}

class _SetWorkspaceState extends State<SetWorkspace> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _addWorkspaceController = TextEditingController();

  AuthRepository get authRepository => Provider.of<AuthRepository>(context, listen: false);
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  String? _addWorkspaceValidatorFunction(String? value) {
    // if (value != null){
    //   value = value.split(widget._currencySign).first;
    // }
    // String? message = _essentialFieldValidatorFunction(value);
    // if (message == null) {
    //   return lineLimitMaxValidator(value, gc.defaultMaxCharactersLimit) ? null : Languages.of(context)!.strMaxCharactersLimit.replaceAll("%", gc.defaultMaxCharactersLimit.toString());
    // }
    // return message;
    return null;
  }

  Widget _getWorkspace(String workspace) {
    return Text(workspace); // TODO- design: chosen one should be bold
  }

  void _removeWorkspace() {
    // TODO
  }

  void _closeAddWorkspace() {
    navigateBack(context);
  }

  void _addWorkspace() {

  }

  Widget _showAddWorkspace() {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 250,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                child: Row(
                  children: [
                    Text(Languages.of(context)!.strAddNewWorkspace, style: TextStyle(fontSize: 16)),
                    IconButton(onPressed: _closeAddWorkspace, icon: Icon(gc.closeIcon)),
                  ]
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormTextField(
                  _addWorkspaceController,
                  1,
                  1,
                  Languages.of(context)!.strWorkspace,
                  isBordered: true,
                  isValid: true,
                  validatorFunction: _addWorkspaceValidatorFunction,
                ),
              ),
              const Divider(),
              ElevatedButton(onPressed: _addWorkspace, child: Text(Languages.of(context)!.strAdd)),
            ],
          ),
        ),
      ),
    );
  }

  void _addNewWorkspace() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext _context) {
          return SafeArea(
            child: Wrap(
              children: [_showAddWorkspace()],
            ),
          );
        });
  }

  Widget _buildWorkspaceFromString(String workspace) {
    return (workspace == userStorage.userData!.currentWorkspace || (authRepository.user != null && workspace == authRepository.user!.email)) ?
    _getWorkspace(workspace) : GenericDeleteDismissible(
      workspace,
      Languages.of(context)!.strWorkspace,
      _getWorkspace(workspace),
      removeCallback: _removeWorkspace,
    );
  }

  List<Widget> _getAllWorkspaces() {
    if (userStorage.userData == null) {
      navigateBack(context);
      return [];
    }
    Iterable<Widget> workspaces = userStorage.userData!.workspaceOptions.map((workspace) => _buildWorkspaceFromString(workspace));
    return workspaces.isEmpty ? [] : ListTile.divideTiles(context: context, tiles: workspaces).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinorAppBar(Languages.of(context)!.strManageWorkspaces),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(Languages.of(context)!.strWorkspaceExplanation),  // TODO- write the content
              const Divider(),
              Row(
                children: [
                  Text(Languages.of(context)!.strChooseWorkspace),
                  IconButton(onPressed: _addNewWorkspace, icon: Icon(gc.addIcon))
                ],
              ),
              SizedBox(
                  width: 100,
                  height: 100,
                  child: ListView(children: _getAllWorkspaces()),
              ),
            ],
        ),
      ),
    );
  }
}
