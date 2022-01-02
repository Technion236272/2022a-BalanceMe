// // ================= Messages Repository =================
// import 'package:flutter/cupertino.dart';
// import 'package:balance_me/localization/resources/resources.dart';
// import 'package:balance_me/global/types.dart';
// import 'package:balance_me/global/utils.dart';
//
// void handleUserMessages(BuildContext context, List messages) {
//   for (var message in messages) {
//     switch (message["type"]) {
//       case UserMessage.RequestWorkspace:
//         _handleRequestWorkspace(context, message);
//         break;
//       case UserMessage.AcceptWorkspace:
//         _handleAcceptWorkspace(context, message);
//         break;
//       case UserMessage.RejectWorkspace:
//         _handleRejectWorkspace(context, message);
//         break;
//     }
//   }
// }
//
// void _handleRequestWorkspace(BuildContext context, Json message) {
//   String customContent = message["content"] == null ? "" : message["content"];
//   showDismissBanner(context, Languages.of(context)!.strWorkspaceInvitation.replaceAll("%", message["user"].replaceAll("#", message["workspaceName"])) + customContent);
//
//   setState(() {
//     userStorage.addNewUserToWorkspace(_addWorkspaceController.text);
//   });
//   _closeModalBottomSheet();
//   displaySnackBar(context, Languages.of(context)!.strWorkspaceOperationSuccessful.replaceAll("%", Languages.of(context)!.strAdded));
//   GoogleAnalytics.instance.logWorkspaceAdded(_addWorkspaceController.text);
// }
//
// void _handleAcceptWorkspace(BuildContext context, Json message) {
//
// }
//
// void _handleRejectWorkspace(BuildContext context, Json message) {
//
// }
