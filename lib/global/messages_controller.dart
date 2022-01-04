// ================= Messages Controller =================
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';

class MessagesController {  // TODO- check validity of messages
  static BuildContext? context = globalNavigatorKey.currentContext;
  static late UserStorage userStorage;

  static void handleUserMessages(List<dynamic> messages) {
    try {
      if (context == null) {
        return;
      }

      userStorage = Provider.of<UserStorage>(context!, listen: false);
      for (var message in messages) {

        switch (indexToEnum(UserMessage.values, message["type"])) {
          case UserMessage.JoinWorkspace:
            _handleJoinWorkspace(message);
            break;

          case UserMessage.InviteWorkspace:
            _handleInviteWorkspace(message);
            break;

            case UserMessage.ShowMessage:
            _handleShowMessage(message);
            break;

          default:
            GoogleAnalytics.instance.logHandleUnknownMessage(message.toString());
            break;
        }

        GoogleAnalytics.instance.logHandleMessageSuccess(message.toString());
      }

    } catch (e) {
        GoogleAnalytics.instance.logHandleMessageFailed();
    }
  }

  static void _handleJoinWorkspace(Message message) {  // TODO- type, workspace, user
    message["message"] = Languages.of(context!)!.strUserRequestJoiningToWorkspace;
    _handleShowMessage(message);  // TODO- add actions
    userStorage.SEND_updatePendingJoiningRequest(message["workspace"], message["user"], true);
    if (userStorage.userData != null && userStorage.userData!.currentWorkspace == message["workspace"]) {
      userStorage.GET_workspaceUsers();
    }
  }

  static void _handleInviteWorkspace(Message message) {  // TODO- type, workspace, user
    message["message"] = Languages.of(context!)!.strUserInvitedToWorkspace;
    _handleShowMessage(message);  // TODO- add actions
    // userStorage.SEND_addPendingJoiningRequest(message["workspace"], message["user"]);  // TODO- implement something similar
    // if (userStorage.userData != null && userStorage.userData!.currentWorkspace == message["workspace"]) {
    //   userStorage.GET_workspaceUsers();
    // }
  }

  static void _handleShowMessage(Message message) {
    showDismissBanner(message["message"].replaceAll("%", message["workspace"]).replaceAll("#", message["user"]));
  }

  static void _handleRejectWorkspace(Message message) {

  }
}
