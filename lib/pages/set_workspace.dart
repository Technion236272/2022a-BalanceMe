// ================= Set Workspace Page =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/widgets/form_text_field.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/generic_dismissible.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
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

  bool get _shouldShowWorkspaceUsers => userStorage.workspaceUsers != null && !userStorage.workspaceUsers!.isOnlyLeader;

  bool get _shouldShowPendingRequests => userStorage.userData != null && userStorage.userData!.workspaceRequests.isNotEmpty;

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
    return Padding(
      padding: gc.workspaceTilePadding,
      child: Container(
        decoration: BoxDecoration(
          color: gc.entryColor,
          borderRadius: BorderRadius.circular(gc.entryBorderRadius),
          border: Border.all(
              color: userStorage.userData!.currentWorkspace == workspace ? gc.primaryColor : gc.disabledColor,
          ),
          boxShadow: [
            userStorage.userData!.currentWorkspace == workspace ? gc.workspaceTileShadow : BoxShadow()
          ],
        ),
        child: ListTile(
          title: Text(
            workspace,
            style: TextStyle(
                color: userStorage.userData!.currentWorkspace == workspace ? gc.primaryColor : gc.disabledColor,
                fontWeight: userStorage.userData!.currentWorkspace == workspace ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onTap: workspace == userStorage.userData!.currentWorkspace ? null : () => {_chooseWorkspace(workspace)},
        ),
      ),
    );
  }

  void _createNewWorkspace(Json? data) {
    userStorage.SEND_balanceModel();  // TODO- needed?
    if (authRepository.user != null && authRepository.user!.email != null) {
      userStorage.createWorkspaceUsers(authRepository.user!.email!);
      userStorage.SEND_workspaceUsers();
    }
  }

  void _chooseWorkspace(String workspace) async {
    userStorage.userData!.currentWorkspace = workspace;
    (authRepository.user != null && workspace != authRepository.user!.email) ? await userStorage.GET_workspaceUsers() : userStorage.resetWorkspaceUsers();
    setState(() {});
    userStorage.SEND_generalInfo();
    await userStorage.GET_balanceModel(failureCallback: _createNewWorkspace);
    widget.afterChangeWorkspaceCB == null ? null : widget.afterChangeWorkspaceCB!();
    displaySnackBar(context, Languages.of(context)!.strWorkspaceOperationSuccessful.replaceAll("%", Languages.of(context)!.strChanged));
    GoogleAnalytics.instance.logWorkspaceChanged(workspace);
  }

  void _removeWorkspace(String workspace) async {
    await userStorage.removeUserFromWorkspace(workspace);

    if (userStorage.userData != null && workspace == userStorage.userData!.currentWorkspace && authRepository.user != null) {
      _chooseWorkspace(authRepository.user!.email!);
    } else {
      setState(() {});
    }

    displaySnackBar(context, Languages.of(context)!.strWorkspaceOperationSuccessful.replaceAll("%", Languages.of(context)!.strRemoved));
    GoogleAnalytics.instance.logWorkspaceRemoved(workspace);
  }

  void _joinWorkspace(String workspace) {
    if (userStorage.userData != null) {
      setState(() {
        userStorage.userData!.workspaceRequests.add(workspace);
      });
      userStorage.SEND_generalInfo();
    }
    userStorage.SEND_joinWorkspaceRequest(workspace);
    displaySnackBar(context, Languages.of(context)!.strWorkspaceJoinRequestSent);
    _closeModalBottomSheet();
  }

  void _addWorkspace() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate() && userStorage.userData != null) {

      if (await userStorage.GET_isWorkspaceExist(_addWorkspaceController.text)) {  // TODO- add checking in pending
        navigateBack(context);
        await showYesNoAlertDialog(context, Languages.of(context)!.strJoinWorkspace, () => {_joinWorkspace(_addWorkspaceController.text)}, _closeModalBottomSheet);

      } else {
        // _createNewWorkspace(_addWorkspaceController.text);  // TODO- dont forget close modal
      }
    }
  }

  void _resendJoiningRequest() {
    // TODO
  }

  Widget _getAddWorkspaceModal() {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: MediaQuery.of(context).size.height / gc.bottomSheetSizeScale,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: gc.bottomSheetPadding,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          Languages.of(context)!.strAddNewWorkspace,
                          style: gc.bottomSheetTextStyle,
                      ),
                      IconButton(
                        onPressed: _closeModalBottomSheet,
                        icon: Icon(gc.closeIcon),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: gc.bottomSheetPadding,
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
              ElevatedButton(  // TODO- add action button
                  onPressed: _addWorkspace,
                  child: Text(Languages.of(context)!.strAdd)),
            ],
          ),
        ),
      ),
    );
  }

  void _closeModalBottomSheet() {
    _addWorkspaceController.text = "";
    navigateBack(context);
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _context) {
        return SafeArea(
          child: Wrap(
            children: [_getAddWorkspaceModal()],
          ),
        );
      },
    );
  }

  Widget _buildWorkspaceFromString(String workspace) {
    return (authRepository.user != null && workspace == authRepository.user!.email) ?
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
    List<Widget> workspaces = [];
    for (String workspace in userStorage.userData!.workspaceOptions) {
      workspaces.add(_buildWorkspaceFromString(workspace));
    }
    return workspaces.isEmpty ? [] : workspaces;
  }

  Widget _buildWorkspaceUserFromString(String user) {
    return (authRepository.user != null && user == authRepository.user!.email) ? Container() : Padding(
            padding: gc.workspaceTilePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  gc.userIcon,
                  color: gc.secondaryColor,
                ),
                Text(
                  user,
                  style: TextStyle(color: gc.secondaryColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
  }

  Widget _buildPendingRequestFromString(String user) {
    return Padding(
      padding: gc.workspaceTilePadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            user,
            style: TextStyle(color: gc.disabledColor, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: _resendJoiningRequest,
            child: Text(
              Languages.of(context)!.strResend,
              style: TextStyle(color: gc.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getWorkspaceUsers(List users, Function buildUserFunction) {
    List<Widget> usersList = [];
    for (String user in users) {
      usersList.add(buildUserFunction(user));
    }
    return usersList.isEmpty ? [] : usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinorAppBar(Languages.of(context)!.strManageWorkspaces),
      body: SingleChildScrollView(
        child: Padding(
          padding: gc.workspacesGeneralPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(Languages.of(context)!.strWorkspaceExplanation), // TODO- write the content
              const Divider(),
              Text(_shouldShowWorkspaceUsers ? Languages.of(context)!.strOtherWorkspaceUsers : Languages.of(context)!.strEmptyWorkspace),
              Padding(
                padding: gc.userTilePadding,
                child: Visibility(
                  visible: _shouldShowWorkspaceUsers,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: gc.primaryColor,
                      borderRadius: BorderRadius.circular(gc.entryBorderRadius),
                    ),
                    child: ListView(
                      children: _getWorkspaceUsers((userStorage.workspaceUsers == null) ? [] : userStorage.workspaceUsers!.users, _buildWorkspaceUserFromString),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
              ),
              const Divider(),
              Visibility(
                visible: _shouldShowPendingRequests,
                child: Column(
                  children: [
                    Text(Languages.of(context)!.strPendingWorkspaceRequests),
                    Padding(  // TODO- export
                      padding: gc.userTilePadding,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ListView(
                          children: _getWorkspaceUsers((userStorage.userData == null) ? [] : userStorage.userData!.workspaceRequests, _buildPendingRequestFromString),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Languages.of(context)!.strChooseWorkspace),
                  IconButton(
                      onPressed: _showModalBottomSheet, icon: Icon(gc.addIcon))
                ],
              ),
              ListView(
                children: _getAllWorkspaces(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
