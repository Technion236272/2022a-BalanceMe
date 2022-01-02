// ================= Summary Page =================
import 'package:balance_me/widgets/generic_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/auth_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/widgets/form_text_field.dart';
import 'package:balance_me/pages/set_workspace.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _requestContentController = TextEditingController();

  AuthRepository get authRepository => Provider.of<AuthRepository>(context, listen: false);
  UserStorage get userStorage => Provider.of<UserStorage>(context, listen: false);

  void _rebuildPage() => {setState(() => null)};

  void _closeModalBottomSheet() {
    _userNameController.text = "";
    _requestContentController.text = "";
    navigateBack(context);
  }

  void _openManageWorkspace() {
    openModalBottomSheet(context, [_getAddUsersModal()]);
  }

  void _openSetWorkspace() {
    navigateToPage(context, SetWorkspace(afterChangeWorkspaceCB: _rebuildPage), AppPages.SetWorkspace);
  }

  void _inviteUserToWorkspace() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate() && userStorage.userData != null) {
      if (userStorage.userData != null) {

        if (await userStorage.GET_isUserExist(_userNameController.text)) {
          userStorage.SEND_inviteWorkspaceRequest(userStorage.userData!.currentWorkspace, _userNameController.text, _requestContentController.text);
          displaySnackBar(context, Languages.of(context)!.strWorkspaceOperationSuccessful.replaceAll("%", Languages.of(context)!.strRemoved));
          GoogleAnalytics.instance.logInviteUserToWorkspace(userStorage.userData!.currentWorkspace, _userNameController.text);
        } else {
          displaySnackBar(context, Languages.of(context)!.strUserNotFound);
        }

      } else {
        displaySnackBar(context, Languages.of(context)!.strProblemOccurred);
      }

      _closeModalBottomSheet();
    }
  }

  String? _userValidatorFunction(String? value) {
    String? message = essentialFieldValidator(value) ? null : Languages.of(context)!.strEssentialField;
    if (message == null) {
      message = emailValidator(value) ? null : Languages.of(context)!.strBadEmail;
    }
    return message;
  }

  Widget _getAddUsersModal() {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
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
                        Languages.of(context)!.strInviteUserToWorkspace,
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
                  _userNameController,
                  1,
                  1,
                  Languages.of(context)!.strEmailText,
                  isBordered: true,
                  isValid: true,
                  validatorFunction: _userValidatorFunction,
                ),
              ),
              Padding(
                padding: gc.bottomSheetPadding,
                child: FormTextField(
                  _requestContentController,
                  1,
                  1,
                  Languages.of(context)!.strAddDescription,
                  isBordered: true,
                  isValid: true,
                ),
              ),
              ElevatedButton(  // TODO- add action button
                  onPressed: _inviteUserToWorkspace,
                  child: Text(Languages.of(context)!.strInvite)),
            ],
          ),
        ),
      ),
    );
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
                      Visibility(
                        visible: userStorage.workspaceUsers != null && authRepository.user != null && userStorage.workspaceUsers!.leader == authRepository.user!.email,
                        child: ElevatedButton(
                          onPressed: _openManageWorkspace,
                          child: Text(Languages.of(context)!.strManage),
                        ),
                      ),
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
