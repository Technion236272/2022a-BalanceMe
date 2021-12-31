// ================= Set Workspace Page =================
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/widgets/form_text_field.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/generic_dismissible.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SetWorkspace extends StatefulWidget {
  const SetWorkspace({this.afterChangeWorkspaceCB, Key? key}) : super(key: key);

  final VoidCallback? afterChangeWorkspaceCB;

  @override
  _SetWorkspaceState createState() => _SetWorkspaceState();
}

class _SetWorkspaceState extends State<SetWorkspace> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _addWorkspaceController = TextEditingController();

  AuthRepository get authRepository => Provider.of<AuthRepository>(context, listen: false);
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  String? _addWorkspaceValidatorFunction(String? value) {
    String? message = essentialFieldValidator(value) ? null : Languages.of(context)!.strEssentialField;
    if (message == null) {
      message = notEmailValidator(value) ? null : Languages.of(context)!.strNotEmailValidator;
    }
    if (message == null && userStorage.userData != null) {
      message = userStorage.userData!.workspaceOptions.contains(value) ? Languages.of(context)!.strWorkspaceAlreadyExist : null;
    }
    return message;
  }

  Widget _getWorkspace(String workspace) {
    return TextButton(
      onPressed: workspace == userStorage.userData!.currentWorkspace ? null : () => {_chooseWorkspace(workspace)},
      child: Text(workspace),
    );
  }

  void _closeAddWorkspace() {
    _addWorkspaceController.text = "";
    navigateBack(context);
  }

  void _chooseWorkspace(String workspace) {
    setState(() {
      userStorage.userData!.currentWorkspace = workspace;
    });
    widget.afterChangeWorkspaceCB == null ? null : widget.afterChangeWorkspaceCB!();
    userStorage.SEND_generalInfo();
    displaySnackBar(context, Languages.of(context)!.strWorkspaceOperationSuccessful.replaceAll("%", Languages.of(context)!.strChanged));
    GoogleAnalytics.instance.logWorkspaceChanged(workspace);
  }

  void _removeWorkspace(String workspace) {
    setState(() {
      userStorage.userData!.workspaceOptions.remove(workspace);
    });
    userStorage.SEND_generalInfo();
    displaySnackBar(context, Languages.of(context)!.strWorkspaceOperationSuccessful.replaceAll("%", Languages.of(context)!.strRemoved));
    GoogleAnalytics.instance.logWorkspaceRemoved(workspace);
  }

  void _addWorkspace() {
    if (_formKey.currentState != null && _formKey.currentState!.validate() && userStorage.userData != null) {
      // TODO- add more checks for the new workspace
      setState(() {
        userStorage.userData!.workspaceOptions.add(_addWorkspaceController.text);
      });
      userStorage.SEND_generalInfo();
      _closeAddWorkspace();
      displaySnackBar(context, Languages.of(context)!.strWorkspaceOperationSuccessful.replaceAll("%", Languages.of(context)!.strAdded));
      GoogleAnalytics.instance.logWorkspaceAdded(_addWorkspaceController.text);
    }
  }

  Widget _showAddWorkspace() {  // TODO- design
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
      removeCallback: () => {_removeWorkspace(workspace)},
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
  Widget build(BuildContext context) {  // TODO- design
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
