// ================= Set Workspace Page =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/widgets/generic_tooltip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:balance_me/widgets/appbar.dart';
import 'package:balance_me/widgets/form_text_field.dart';
import 'package:balance_me/common_models/workspace_users_model.dart';
import 'package:balance_me/common_models/belongs_workspaces.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/generic_dismissible.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SetWorkspace extends StatefulWidget {
  const SetWorkspace({Key? key}) : super(key: key);

  @override
  _SetWorkspaceState createState() => _SetWorkspaceState();
}

class _SetWorkspaceState extends State<SetWorkspace> {
  final _modalBottomSheetFormKey = GlobalKey<FormState>();
  late WorkspaceUsers? _workspaceUsers;
  late BelongsWorkspaces _belongWorkspace;
  TextEditingController _modalBottomSheetController = TextEditingController();

  AuthRepository get authRepository => Provider.of<AuthRepository>(context, listen: false);
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  // ================ LOGIC ================

  bool get _shouldShowWorkspaceUsers => _workspaceUsers != null && !_workspaceUsers!.isOnlyLeader;

  bool get _shouldShowPendingRequests => _belongWorkspace.joiningRequests.isNotEmpty;

  bool get _shouldShowInvitations => _belongWorkspace.invitations.isNotEmpty;

  String? _addUserValidatorFunction(String? value) {
    String? message = essentialFieldValidator(value) ? null : Languages.of(context)!.strEssentialField;
    if (message == null) {
      message = _belongWorkspace.belongs.contains(value) ? Languages.of(context)!.strWorkspaceAlreadyExist : null;
    }
    if (message == null) {
      message = notEmailValidator(value) ? null : Languages.of(context)!.strNotEmailValidator;
    }
    if (message == null) {
      message = _belongWorkspace.joiningRequests.contains(value) ? Languages.of(context)!.strJoiningWorkspaceRequestExist : null;
    }
    if (message == null) {
      message = lineLimitMaxValidator(value, gc.defaultMaxCharactersLimit) ? null : Languages.of(context)!.strMaxCharactersLimit.replaceAll("%", gc.defaultMaxCharactersLimit.toString());
    }
    if (message == null) {
      message = _belongWorkspace.invitations.contains(value) ? Languages.of(context)!.strYouAlreadyInvitedToJoin : null;
    }
    return message;
  }

  String? _inviteUserValidatorFunction(String? value) {
    String? message = essentialFieldValidator(value) ? null : Languages.of(context)!.strEssentialField;
    if (message == null) {
      message = emailValidator(value) ? null : Languages.of(context)!.strBadEmail;
    }
    if (message == null) {
      message = (_workspaceUsers != null && _workspaceUsers!.pendingJoiningRequests.contains(value)) ? Languages.of(context)!.strUserAlreadyRequestToJoin : null;
    }
    if (message == null) {
      message = (_workspaceUsers != null && _workspaceUsers!.users.contains(value)) ? Languages.of(context)!.strUserAlreadyInWorkspace : null;
    }
    return message;
  }

  void _chooseWorkspace(String workspace) async {
    setState(() {
      userStorage.chooseWorkspace(workspace);
    });
    displaySnackBar(context, Languages.of(context)!.strWorkspaceOperationSuccessful.replaceAll("%", Languages.of(context)!.strChanged));
    GoogleAnalytics.instance.logWorkspaceChanged(workspace);
  }

  void _removeWorkspace(String workspace) {
    userStorage.removeUserFromWorkspace(workspace);

    if (userStorage.userData != null && workspace == userStorage.userData!.currentWorkspace && authRepository.user != null) {
      _chooseWorkspace(authRepository.user!.email!);
    }

    displaySnackBar(context, Languages.of(context)!.strWorkspaceOperationSuccessful.replaceAll("%", Languages.of(context)!.strRemoved));
    GoogleAnalytics.instance.logWorkspaceRemoved(workspace);
  }

  void _createNewWorkspace(String newWorkspace) {
      userStorage.createNewWorkspace(newWorkspace);
      _closeModalBottomSheet();
      displaySnackBar(context, Languages.of(context)!.strWorkspaceCreated);
      GoogleAnalytics.instance.logWorkspaceCreated(newWorkspace);
  }

  void _requestJoiningWorkspace(String workspace) async {
    if (authRepository.user != null && authRepository.user!.email != null && !_belongWorkspace.joiningRequests.contains(workspace)) {
      userStorage.SEND_updateJoiningRequests(authRepository.user!.email!, workspace, true);
      _closeModalBottomSheet();
    }

    String? workspaceLeader = await userStorage.GET_workspaceLeader(workspace);
    if (workspaceLeader != null && await userStorage.SEND_joinWorkspaceRequest(workspace, workspaceLeader)) {
      displaySnackBar(context, Languages.of(context)!.strWorkspaceJoinRequestSent);
      GoogleAnalytics.instance.logWorkspaceJoinRequestSent(workspace);

    } else {
      displaySnackBar(context, Languages.of(context)!.strProblemOccurred);
    }
  }

  void _addWorkspace() async {
    if (_modalBottomSheetFormKey.currentState != null && _modalBottomSheetFormKey.currentState!.validate() && userStorage.userData != null) {

      if (await userStorage.isExist_Workspace(_modalBottomSheetController.text)) {
        navigateBack(context);
        await showYesNoAlertDialog(context, Languages.of(context)!.strJoinWorkspace, () => {_requestJoiningWorkspace(_modalBottomSheetController.text)}, _closeModalBottomSheet);

      } else {
        _createNewWorkspace(_modalBottomSheetController.text);
      }
    }
  }

  void _approveRequest(String approved, bool? isInvitation) {
    (isInvitation != null && !!isInvitation) ? userStorage.replyWorkspaceInvitation(context, approved, true) : userStorage.replyUserJoiningRequest(context, approved, true);
  }

  void _rejectedRequest(String rejected, bool? isInvitation) {
    (isInvitation != null && !!isInvitation) ? userStorage.replyWorkspaceInvitation(context, rejected, false) : userStorage.replyUserJoiningRequest(context, rejected, false);
  }

  void _inviteUserToWorkspace() async {
    if (_modalBottomSheetFormKey.currentState != null && _modalBottomSheetFormKey.currentState!.validate()) {

      String invitedUser = _modalBottomSheetController.text.toLowerCase();
      if (await userStorage.isExist_generalInfo(invitedUser)) {
        userStorage.SEND_updateInvitationsList(userStorage.userData!.currentWorkspace, invitedUser, true);
        userStorage.SEND_inviteWorkspaceRequest(userStorage.userData!.currentWorkspace, invitedUser);
        displaySnackBar(context, Languages.of(context)!.strInvitedSuccessfullyWorkspace);
        GoogleAnalytics.instance.logInviteUserToWorkspace(userStorage.userData!.currentWorkspace, invitedUser);
      } else {
        displaySnackBar(context, Languages.of(context)!.strUserNotFound);
      }

      _closeModalBottomSheet();
    }
  }

  void _hideJoiningRequest(String workspace) {
    userStorage.SEND_updateJoiningRequests(authRepository.user!.email!, workspace, false);
  }

  // ================ UI ================

  void _closeModalBottomSheet() {
    _modalBottomSheetController.text = "";
    _modalBottomSheetController.text = "";
    navigateBack(context);
  }

  void _showModalBottomSheet(bool isAddWorkspace) {
    openModalBottomSheet([_getModalBottomSheet(isAddWorkspace)]);
  }

  Widget _getModalBottomSheet(bool isAddWorkspace) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: MediaQuery.of(context).size.height / gc.bottomSheetSizeScale,
        color: Theme.of(context).cardColor,
        child: Form(
          key: _modalBottomSheetFormKey,
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
                        isAddWorkspace ? Languages.of(context)!.strAddNewWorkspace :  Languages.of(context)!.strInviteUserToWorkspace,
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
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: FormTextField(
                  _modalBottomSheetController,
                  1,
                  1,
                  isAddWorkspace ? Languages.of(context)!.strWorkspace : Languages.of(context)!.strEmailText,
                  isBordered: true,
                  isValid: true,
                  validatorFunction: isAddWorkspace ? _addUserValidatorFunction : _inviteUserValidatorFunction,
                  autofocus: true,
                ),
              ),
              ElevatedButton(
                  onPressed: isAddWorkspace ? _addWorkspace : _inviteUserToWorkspace,
                  child: isAddWorkspace ? Text(Languages.of(context)!.strAdd) : Text(Languages.of(context)!.strInvite),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getWorkspace(String workspace) {
    return Padding(
      padding: gc.workspaceTilePadding,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(gc.entryBorderRadius),
          border: Border.all(
            color: userStorage.userData!.currentWorkspace == workspace ? Theme.of(context).toggleableActiveColor : Theme.of(context).disabledColor,
          ),
          boxShadow: [
            userStorage.userData!.currentWorkspace == workspace ? BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 2, offset: Offset(2,2)) : BoxShadow()
          ],
        ),
        child: ListTile(
          title: Text(
            workspace,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: userStorage.userData!.currentWorkspace == workspace ? Theme.of(context).toggleableActiveColor : Theme.of(context).hoverColor,
              fontWeight: userStorage.userData!.currentWorkspace == workspace ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onTap: workspace == userStorage.userData!.currentWorkspace ? null : () => {_chooseWorkspace(workspace)},
        ),
      ),
    );
  }

  Widget _buildWorkspaceFromString(String workspace, bool? param) {
    return (authRepository.user != null && workspace == authRepository.user!.email) ?
      _getWorkspace(workspace) : GenericDeleteDismissible(
      workspace,
      Languages.of(context)!.strWorkspace,
      _getWorkspace(workspace),
      removeCallback: () => {_removeWorkspace(workspace)},
    );
  }

  List<Widget> _getTiles(List list, Function buildUserFunction, [bool? paramForFunction]) {
    List<Widget> tiles = [];
    for (String tile in list) {
      tiles.add(buildUserFunction(tile, paramForFunction));
    }
    return tiles.isEmpty ? [] : tiles;
  }

  Widget _getListView(List<Widget> children) {
    return ListView(
      children: children,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildWorkspaceUserFromString(String user, bool? param) {
    return (authRepository.user != null && user == authRepository.user!.email) ? Container() : Padding(
      padding: gc.workspaceTilePadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            user,
            textAlign: TextAlign.center,
            style: TextStyle(color: gc.secondaryColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoButtonTile(String text, Function firstOnPress, String firstText, Function secondOnPress, String secondText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: gc.workspacesGeneralPadding,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => {firstOnPress(text)},
              child: Text(
                firstText,
              ),
            ),
            TextButton(
              onPressed: () => {secondOnPress(text)},
              child: Text(
                secondText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPendingRequestFromString(String tile, bool? param) {
    return _buildTwoButtonTile(tile, _hideJoiningRequest, Languages.of(context)!.strHide, _requestJoiningWorkspace, Languages.of(context)!.strResend);
  }

  Widget _buildApproveRejectFromString(String tile, bool? isInvitation) {
    void approveRequest(text) => {_approveRequest(text, isInvitation)};
    void rejectRequest(text) => {_rejectedRequest(text, isInvitation)};

    return _buildTwoButtonTile(tile, approveRequest, Languages.of(context)!.strApprove, rejectRequest, Languages.of(context)!.strReject);
  }

  Widget _getUserList(bool visibleCondition, String title, List<Widget> listTiles, [BoxDecoration? decoration]) {
    return Visibility(
      visible: visibleCondition,
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.headline3,),
          Padding(
            padding: gc.userTilePadding,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: decoration,
              child: _getListView(listTiles),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MinorAppBar(Languages.of(context)!.strManageWorkspaces),
        body: StreamBuilder(
            stream: CombineLatestStream.list([userStorage.STREAM_workspaceUsers(), userStorage.STREAM_belongsWorkspaces()]),
            builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {

              if (!snapshot.hasData || snapshot.data![0].data() == null ||
                  snapshot.data![1].data() == null || (snapshot.data![1].data()! as Json)["belongsWorkspaces"] == null) {
                return Center(child: CircularProgressIndicator());
              }

              _workspaceUsers = (authRepository.user != null && userStorage.userData != null && userStorage.userData!.currentWorkspace != authRepository.user!.email
                && (snapshot.data![0].data()! as Json)["workspaceUsers"] != null && WorkspaceUsers.isWorkspaceUsersValid((snapshot.data![0].data()! as Json)["workspaceUsers"])) ?
                WorkspaceUsers.fromJson((snapshot.data![0].data()! as Json)["workspaceUsers"]) : null;

              _belongWorkspace = BelongsWorkspaces.fromJson((snapshot.data![1].data()! as Json)["belongsWorkspaces"]);

              return SingleChildScrollView(
                      child: Padding(
                        padding: gc.workspacesGeneralPadding,
                        child: Column(
                          children: [
                            Text(
                              Languages.of(context)!.strWorkspaceExplanation,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            GenericTooltip(tip: Languages.of(context)!.strWorkspaceTooltip),
                            const Divider(),
                            Visibility(
                                visible: !_shouldShowWorkspaceUsers,
                                child: Column(
                                    children: [
                                      Text(
                                        Languages.of(context)!.strEmptyWorkspace,
                                        style: Theme.of(context).textTheme.subtitle1,
                                      ),
                                      const Divider()
                                    ],
                                ),
                            ),
                            Visibility(
                              visible: _shouldShowWorkspaceUsers,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width/gc.workspaceUsersScale,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(Languages.of(context)!.strOtherWorkspaceUsers, style: Theme.of(context).textTheme.subtitle1,),
                                    Padding(
                                      padding: gc.userTilePadding,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).toggleableActiveColor,
                                          borderRadius: BorderRadius.circular(gc.entryBorderRadius),
                                        ),
                                        child: _getListView(_getTiles(_workspaceUsers == null ? [] : _workspaceUsers!.users, _buildWorkspaceUserFromString)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: gc.workspaceAskToJoinColor,
                              child: Padding(
                                padding: (userStorage.userData != null && _belongWorkspace.joiningRequests.length > gc.zero) ? gc.userTilePadding : EdgeInsets.zero,
                                child: _getUserList(
                                  _shouldShowPendingRequests,
                                  Languages.of(context)!.strPendingWorkspaceRequests,
                                  _getTiles((userStorage.userData == null) ? [] : _belongWorkspace.joiningRequests, _buildPendingRequestFromString),
                                ),
                              ),
                            ),
                            Card(
                              color: gc.workspaceInvitationsColor,
                              child: Padding(
                                padding: (userStorage.userData != null && _belongWorkspace.invitations.length > gc.zero) ? gc.userTilePadding : EdgeInsets.zero,
                                child: _getUserList(
                                  _shouldShowInvitations,
                                  Languages.of(context)!.strPendingInvitationsRequests,
                                  _getTiles((userStorage.userData == null) ? [] : _belongWorkspace.invitations, _buildApproveRejectFromString, true),
                                ),
                              ),
                            ),
                            Card(
                              color: gc.workspaceUsersRequestsColor,
                              child: Padding(
                                padding: (_workspaceUsers != null && _workspaceUsers!.pendingJoiningRequests.length > gc.zero) ? gc.userTilePadding : EdgeInsets.zero,
                                child: _getUserList(
                                  _workspaceUsers == null ? false : _workspaceUsers!.isPendingJoiningRequests,
                                  Languages.of(context)!.strPendingUsersRequestsTitle.replaceAll("%", userStorage.userData!.currentWorkspace),
                                  _getTiles(_workspaceUsers == null ? [] : _workspaceUsers!.pendingJoiningRequests, _buildApproveRejectFromString),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Languages.of(context)!.strChooseWorkspace),
                                Visibility(
                                  visible: _workspaceUsers != null && authRepository.user != null && _workspaceUsers!.leader == authRepository.user!.email,
                                  child: TextButton(
                                    onPressed: () => {_showModalBottomSheet(false)},
                                    child: Text(Languages.of(context)!.strInvite, style: Theme.of(context).textTheme.subtitle2,),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () => {_showModalBottomSheet(true)},
                                    icon: Icon(gc.addIcon),
                                ),
                              ],
                            ),
                            _getListView(_getTiles((userStorage.userData == null) ? [] : _belongWorkspace.belongs, _buildWorkspaceFromString)),
                          ],
                        ),
                      ),
                    );
              }
        )
    );
  }
}
